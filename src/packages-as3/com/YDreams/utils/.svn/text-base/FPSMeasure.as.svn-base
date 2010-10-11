package com.YDreams.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	
	public class FPSMeasure extends Sprite
	{
		private var fps : uint;
		private var timer : Timer;
		private var _textbox : TextField;
		
		public function FPSMeasure(textbox:TextField)
		{
			_textbox = textbox;
			
			timer = new Timer(1000);
			timer.addEventListener( TimerEvent.TIMER, onTimerEvent );
			timer.start();
			fps = 0;
			this.addEventListener(Event.ENTER_FRAME, onFrameEnter);	
		}
		
		private function onFrameEnter(event:Event):void
		{
			fps++;
		}
		
		private function onTimerEvent(event:Event):void
		{			
			_textbox.text = fps.toString()
			fps=0;
		}
		
	}
}