package com.YDreams.display.transitions
{
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import caurina.transitions.Tweener;
	
	public class FadeTransition extends Sprite
	{
		public var _start:DisplayObject;
		public var _end:DisplayObject;
		public var _duration:uint;
		
		private var _container:Sprite = new Sprite();

		public function FadeTransition(start:DisplayObject, end:DisplayObject, duration:uint)
		{
			_start = start;
			_end = end;
			_duration = duration;
			
			if (start!=null)
				addChild(_start);
			if (end!=null)
				addChild(_end);
			
			slideShow();
		}
		
		private function slideShow():void
		{
			_end.visible = true;
			_end.alpha = 0;
			
			Tweener.addTween(_start, {alpha:0, time:_duration, transition:"linear"});
			Tweener.addTween(_end, {alpha:1, time:_duration, transition:"linear", onComplete:onTransitionComplete});
		}
		
		private function onTransitionComplete():void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}