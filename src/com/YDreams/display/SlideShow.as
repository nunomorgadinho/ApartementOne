// $Id$ //
package com.YDreams.display
{
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import com.YDreams.display.Media;
	import com.YDreams.display.transitions.Transition;

	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* This class allows you to create Slideshows using external assets. Just give it a list of images, videos or anything the YDreams.display.media class can handle.<br/>
	* This is the base classe for ScreenSaver and Background.
	* 
	* <p><strong>Usage</strong><br /><br />
	* Just create an array of assets and pass it to the contructor of the Slideshow class.
	* 
	* </p>
	*
	* @example <listing version="3.0">
	* 
	* //import the classes
	* import com.YDreams.display.*;
	* import com.YDreams.display.transitions.*;
	* 
	* //Specify the assets to load
	* var pics:Array = new Array("C:\\GameData\\fifascreen.jpg", "C:\\GameData\\nfsscreen.jpg"); 
	* 
	* //Create an instance of the class
	* var s:SlideShow = new SlideShow(); 
	* 
	* addChild(s);
	* 
	* //Start the slideshow
	* s.start(); 
	* 
	* </listing>
	* 
	* <p><strong>Author</strong><br /><br />
	* Hugo Silveira
	*/
	public class SlideShow extends Sprite
	{
		private var _timer:Timer;
		private var _index:uint;
		private var _width:uint;
		private var _height:uint;
		private var _delay:uint;
		private var _duration:uint;
		private var _transition:String;
  		private var _sources:Array;
  		private var _assets:Array=[];
  		private var _level:int = -1;
  		private var _clear:Boolean = false;
  		private var _media:Media;
  		
  		/**
		 * The class constructor
		 * 
		 * @param sources An array of assets (you can use anything the YDreams.display.media class can handle)
		 * @param srcwidth The Width of the applications screen
		 * @param srcheight The Height of the applications screen
		 * @param delay The delay between transitions (in Seconds)
		 * @param transition The kind of transition you want to use. All the transitions are specified in the Transision class
		 * @param duration The duration of the transition (in Seconds). Make sure this is not lower than the delay parameter
		 * 
		 * @return void
		 * 
		 */
		public function SlideShow(sources:Array, scrwidth:uint = 1024, scrheight:uint = 768, delay:Number = 3, transition:String = "Fade", duration:Number = 1.5)
		{
			_width = scrwidth;
			_height = scrheight;
			_delay = delay * 1000;
			_sources = sources;
			_duration = duration;
			_transition = transition;
		}
		
		/**
        * Starts the screensaver.
        */
		public function start():void
		{
			//tbilou - Because the loading is asyncronous
			// we must make sure we clear the asset that might be loaded after the clear() call.
			// Here we reset the variable.
			_clear = false;
			
			if (_sources.length==1)
			{
				onTime(null);
			}
			else if (_sources.length>1)
			{
				_index = 0;
				_timer = new Timer(_delay, 1);
				_timer.addEventListener(TimerEvent.TIMER, onTime);
				_timer.start();
				
				onTime(null);
			}
			else
			{
				// ****************************
				//There are no sources to process
				// ****************************
				//dispatchEvent(new Event(Event.CLOSE));
				throw new Error("No sources to load!");
			}
		}		
		
		/**
        * Stops the screensaver.
        */
		public function stop():void
		{
			if (_timer!=null)
			{
				_timer.reset();
				_timer.stop();
			}
		}
		
		/**
        * Removes from the screen all the images from the screensaver
        */
		public function clear():void
		{
			// tbilou - Keep a flag telling us that the clear command was issued
			// We need this because the loading of the asset is async.
			_clear = true;
			for (var i:int=0; i<this.numChildren; i++)
			{
				this.removeChildAt(i);
			}	
		}
		
		private function onTime(e:TimerEvent):void
		{
			var file:String = getPath(_index);
			_media = new Media(file,_width, _height);
			trace("its time to load "+file);
			_media.addEventListener(Event.COMPLETE, onMediaLoaded);
			_media.addEventListener(IOErrorEvent.DISK_ERROR, onMediaError);//,false,0,true);
			_media.addEventListener(IOErrorEvent.IO_ERROR, onMediaError);//,false,0,true);
			_media.addEventListener(IOErrorEvent.NETWORK_ERROR, onMediaError);//,false,0,true);
			_media.addEventListener(IOErrorEvent.VERIFY_ERROR, onMediaError);//,false,0,true);
			
			_index++;
			if (_index == _sources.length)
				_index = 0;
				
			//_timer.stop();
			
		}
		
		private function onMediaLoaded(e:Event):void
		{
			trace("loaded!");
			var last:Transition;
			if (this.numChildren>0)
				last = this.getChildAt(this.numChildren-1) as Transition;
				
			//var media:Media = e.target as Media;
			var trans:Transition = new Transition(_transition, (last==null ? null : last.end), _media, _duration);
			trans.addEventListener(Event.COMPLETE,dispatchShow);
			//tbilou - if the clear() was called before the loading was complete
			// do not add this child.
			if (!_clear) addChild(trans);
			
			if (this.numChildren>1)
				this.removeChildAt(0);
				
			if (_timer!=null)
			{
			 _timer.start();
			}

			
		}
		
		public function removeAllTransitions():void
		{
			while ( this.numChildren>0 )
			{
				var trans:Transition = this.getChildAt(0) as Transition;
				if (trans.hasEventListener(Event.COMPLETE))
					trans.removeEventListener(Event.COMPLETE,dispatchShow);
				this.removeChildAt(0);
			}
		}
		
		private function dispatchShow(e:Event):void
		{
			trace("Show");
			var data:Event = new Event("ON_SHOW");
			dispatchEvent(data);
		}
		
		private function onMediaError(e:IOErrorEvent):void
		{
			trace("image not loaded");
			_timer.start();
			dispatchEvent(e);
		}
		
		private function getPath(i:uint):String
		{
			var file:String = _sources[i];
			return file;	
		}
  		
  		/* Gets and Sets for the private constructor properties */
  		/**
		 * (read/write) the scrwidth property
		 */
		public function get scrwidth():uint{
			return _width;
		}
		/**
		* @private
		*/
		public function set srcwidth(value:uint):void{
			_width = value;
		}
		
		/**
		 * (read/write) the scrheight property
		 */
		public function get srcheight():uint{
			return _height;
		}
		/**
		* @private
		*/
		public function set srcheight(value:uint):void{
			_height = value;
		}
		
		/**
		 * (read/write) the delay property (seconds)
		 */
		public function get delay():Number{
			return _delay / 1000;
		}
		/**
		* @private
		*/
		public function set delay(value:Number):void{
			_delay = value * 1000;
		}
		
		/**
		 * (read/write) the duration property (secods)
		 */
		public function get duration():uint{
			return _duration;
		}
		/**
		* @private
		*/
		public function set duration(value:uint):void{
			_duration = value;
		}
		
		/**
		 * (read/write) the duration property (secods)
		 */
		public function get transition():String{
			return _transition;
		}
		/**
		* @private
		*/
		public function set transition(value:String):void{
			_transition = value;
		}
  		
	}
}