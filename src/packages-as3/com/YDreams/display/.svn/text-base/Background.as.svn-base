package com.YDreams.display
{
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	
	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* Allows you to have a "slideshow" as background.
	* 
	* <p><strong>Usage</strong><br /><br />
	* See SlideShow
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
	* var bg:Background = new Background(pics); 
	* 
	* addChild(s);
	* 
	* //Start the slideshow
	* bg.start(); 
	* 
	* </listing>
	* 
	* <p><strong>Author</strong><br /><br />
	* Hugo Silveira
	*/
	public class Background extends SlideShow
	{
		/**
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
		public function Background(sources:Array, scrwidth:uint = 1024, scrheight:uint = 768, delay:Number = 3, transition:String = "Fade", duration:Number = 1.5)
		{
			super(sources,scrwidth,scrheight,delay,transition,duration);
			
			this.addEventListener(Event.CLOSE, onBackgroundClose);
			this.addEventListener(IOErrorEvent.DISK_ERROR, onBackgroundError);
			this.addEventListener(IOErrorEvent.IO_ERROR, onBackgroundError);
			this.addEventListener(IOErrorEvent.NETWORK_ERROR, onBackgroundError);
			this.addEventListener(IOErrorEvent.VERIFY_ERROR, onBackgroundError);
			
			this.name = "background";
			
			try
			{
				this.start();
			}
			catch (error:Error)
			{
				trace(error.message);
				throw error;
			}
		}
		
		/**
		 * onBackgroundError - On error event
		 * 
		 * @param e - IOErrorEvent
		 * 
		 */
		private function onBackgroundError(e:IOErrorEvent):void
		{
			try
			{
				throw new Error ("background error" ,0);
			}
			catch (error:Error)
            {
                trace("error: "+error.message);
            }
		}

		/**
		 * onBackgroundClose - On close event
		 * 
		 * @param e - Event
		 * 
		 */
		private function onBackgroundClose(e:Event):void
		{
			try
			{
				throw new Error ("background closed" ,0);
			}
			catch (error:Error)
            {
                trace("error: "+error.message);
				throw error;
            }
		}

	}
}