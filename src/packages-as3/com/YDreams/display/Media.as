package com.YDreams.display
{
	import com.YDreams.display.YSprite;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.AsyncErrorEvent;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.net.NetConnection;
	import flash.events.IOErrorEvent;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.LoaderInfo;
	import flash.geom.Matrix;
	import flash.events.ErrorEvent;
	import flash.net.LocalConnection;
	
 	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* This class extends YSprite and takes care of loading files like: jpeg, gif, png, swf and flv into it self.
	* 
	* <p><strong>Usage</strong><br /><br />
	* Media(source:String, width:uint = 320, height:uint = 240, buffer:int = 10, id:int= -1 )<br />
	* <br />
	* Media class accepts 3 parameters:<br />
	 * source:<br />
	 * File source (including full path)<br />
	 * <br />
	 * width:<br />
	 * Video width size<br />
	 * <br />
	 * height:<br />
	 * Video height size<br />
	*
	* @example <listing version="3.0">
	* var img:Media = new Media("images/foto.jpg");
	* addChild(img); 
	* var vid:Media = new Media("jumping.flv");
	* addChild(vid); 
	* </listing>
	* 
	*/
	public class Media extends YSprite
	{
		private var _source:String;
		private var _width:Number;
		private var _height:Number;
		private var _netStream:NetStream;
		private var _inner_mc:MovieClip;
		private var _inner_bitmap:Bitmap;
		private var ns:NetStream;
		private var _id:int;
		
		private var loader:Loader;

		public function Media(source:String, width:uint = 0, height:uint = 0, buffer:int = 10, id:int= -1 )
		{
			this._source = source.toLowerCase();
			this._width = width;
			this._height = height;
			this._id=id;
			if(isImage())
			{
				getImage(source); 
				//addChild(image);
			}
			else if(isVideo())	// Load FLV video
			{
				var video:Video = getVideo(source, width, height, buffer); //Video
				addChild(video);
			}
			else if(isFlash())
			{
				var flash:YSprite = getMovie(source); 
				addChild(flash);
			}
			else
			{
				throw new Error("Source file '"+source+"' unknown!");
			}
		}
		/**
		 * 
		 * @returns a boolean that tells if is a video!
		 * 
		 */
		public function isVideo():Boolean
		{
			return (_source.toUpperCase().indexOf(".FLV") != -1)
		}
		/**
		 * 
		 * @returns a boolean that tells if is a image!
		 * 
		 */
		public function isImage():Boolean
		{
			return (_source.toUpperCase().indexOf(".JPG") != -1 || _source.toUpperCase().indexOf(".PNG") != -1 )
		}
		
		/**
		 * 
		 * @returns a boolean that tells if is a swf!
		 * 
		 */
		public function isFlash():Boolean
		{
			return (_source.toUpperCase().indexOf(".SWF") != -1)
		}
		
		private function getImage(source:String):void
		{
			loader = new Loader();
			loader.load(new URLRequest(source));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded,false,0,true);//, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onMediaError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, onMediaError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, onMediaError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.VERIFY_ERROR, onMediaError, false, 0, true);
		}
		
		private function getMovie(source:String):YSprite
		{
			var container:YSprite = new YSprite();
			container.name = "container";
			
			loader = new Loader();
			loader.load(new URLRequest(source));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onMediaLoaded, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onMediaError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, onMediaError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, onMediaError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.VERIFY_ERROR, onMediaError, false, 0, true);
			
			container.addChild(loader);			
			
			return container;
		}
		
		private function onImageLoaded(e:Event):void
		{
			/* The magic lines from gskinner =)  */
			try {
			   new LocalConnection().connect('bar');
			   new LocalConnection().connect('bar');
			} catch (e:*) {}
			
			var loader:Loader = Loader(e.target.loader);
			var container:Bitmap = Bitmap(loader.content);
			this.addChild(container);
			
			var li:LoaderInfo = e.target as LoaderInfo;
			var mc:Bitmap = li.content as Bitmap;
			_inner_bitmap = mc;

			if (this._width!=0 && this._height!=0)
			{
				mc.width = this._width;
				mc.height = this._height;
			}

			dispatchEvent(e);
		}
		
		private function onMediaLoaded(e:Event):void
		{
			if (this._width!=0 && this._height!=0)
			{
				var rw:Number = this._width/this.width;
				var rh:Number = this._height/this.height;
				
				if (rw>rh)
					this.scaleX = this.scaleY = rw;
				else
					this.scaleX = this.scaleY = rh;
					
			}	
			var li:LoaderInfo = e.target as LoaderInfo;
			var mc:MovieClip = li.content as MovieClip;
			this._inner_mc = mc;
												
			dispatchEvent(e);
		}
		/**
		 * 
		 * @return the id associated with the media
		 * 
		 */
		public function get id():int
		{
			return _id;
		}
		
		/**
		 * 
		 * @return the movie clip loaded
		 * 
		 */
		public function get movieClip():MovieClip
		{
			return this._inner_mc;
		}
		
		/**
		 * 
		 * @return the bitmap loaded
		 * 
		 */
		public function get bitmap():Bitmap
		{
			return this._inner_bitmap;
		}
		
		private function onMediaError(e:IOErrorEvent):void
		{
			dispatchEvent(e);
		}
		
		private function getVideo(source:String, width:uint, height:uint, buffer:int):Video
		{
			var nc:NetConnection = new NetConnection(); 
			var video:Video = new Video(width, height);
			nc.connect(null);
			ns = new NetStream(nc); 
			ns.client = this;
			ns.bufferTime = buffer;
			video.attachNetStream(ns);
			
			ns.addEventListener(NetStatusEvent.NET_STATUS, onVideoActivate);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onVideoAsyncError);
			
			ns.play(source);
			trace("Play: "+source)
			
			return video;
		}
		
		public function onMetaData(infoObject:Object):void {
		    trace("metadata");
		}
		 
		public function set onCuePoint(infoObject:Object):void {
		    trace("cue point");
		}
		
		private function onVideoActivate(e:NetStatusEvent):void
		{
			if(e.info.code.toString() == "NetStream.Play.Start"){
				//trace("Playing");
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function onVideoAsyncError(e:AsyncErrorEvent):void
		{
			trace("video error");
		}
		
	}
}