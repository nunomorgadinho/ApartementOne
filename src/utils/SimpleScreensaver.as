/*
	Class for a screensaver that just shows/hides a swf movie.
*/
package utils
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class SimpleScreensaver extends Sprite
	{
		/*
			Configuration
		*/
		private const PATH:String 	 = Settings.getInstance().data.screensaver.@path;
		private const TIMEOUT:Number = Settings.getInstance().data.screensaver.@timeout;
		
		private var _timer:Timer;
		private var _loader:Loader;
		
		public function SimpleScreensaver(target:DisplayObject)
		{
			_timer = new Timer((TIMEOUT * 1000), 1);
			_timer.addEventListener(TimerEvent.TIMER, onTimeout);
			_timer.start();	
			
			target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}

		/*
			Private
		*/
		
		private function onTimeout(e:TimerEvent):void
		{
			trace("timeout");	
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete, false, 0, true);
			_loader.load(new URLRequest(PATH));	
		}

		private function onLoadComplete(e:Event):void
		{
			trace("onLoadComplete");
			
			var mc:MovieClip = _loader.content as MovieClip;
			addChild(mc);
			
			this.parent.setChildIndex(this, this.parent.numChildren-1);
		
			dispatchEvent(new Event("SHOW"));
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			trace("onMouseMove");
			
			if (_loader) {
				var mc:MovieClip = _loader.content as MovieClip;
				if (mc && this.contains(mc)) {
					removeChild(mc);
				}
			}
			
			_timer.reset();
			_timer.start();
		}

	}
}