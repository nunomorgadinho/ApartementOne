package com.YDreams.display.transitions
{
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import caurina.transitions.Tweener;
	
	public class FlashTransition extends Sprite
	{
		public var _start:DisplayObject;
		public var _end:DisplayObject;
		public var _duration:uint;
		
		private var _rect:Sprite = new Sprite();
		private var _container:Sprite = new Sprite();

		public function FlashTransition(start:DisplayObject, end:DisplayObject, duration:uint)
		{
			_start = start;
			_end = end;
			_duration = duration;
			
			initRectangle();
			slideShow();
		}
		
		private function initRectangle():void
		{
			_rect.graphics.lineStyle();
			_rect.graphics.beginFill(0xffffff);
			_rect.graphics.drawRect(0, 0, _end.width, _end.height);
			_rect.graphics.endFill();

			addChild(_end);
			addChild(_rect);
		}
		
		private function slideShow():void
		{
			_rect.alpha = 1;
			_end.visible = true;
			Tweener.addTween(_rect, {alpha:0, time:_duration, transition:"linear", onComplete:onTransitionComplete});
		}
		
		private function onTransitionComplete():void
		{
			_rect.visible = false;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}