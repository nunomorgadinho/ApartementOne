package com.YDreams.display.transitions
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import com.YDreams.display.transitions.*;

	public class Transition extends Sprite
	{
		public static const TYPE_SIMPLE:String = "No";
		public static const TYPE_FLASH:String = "Flash";
		public static const TYPE_FADE:String = "Fade";

		protected static const TRANSITION_SIMPLE:NoTransition = null;
		protected static const TRANSITION_FLASH:FlashTransition = null;
		protected static const TRANSITION_FADE:FadeTransition = null;
		
		public static const COMPLETE:String = Event.COMPLETE;
		
		private var _end:DisplayObject;
		
		public function Transition(type:String, start:DisplayObject, end:DisplayObject, duration:uint)
		{
			trace("new transition");
			if (type==null)
				type = TYPE_SIMPLE;
			this._end = end;
			
			var className:String = "com.YDreams.display.transitions."+type+"Transition"
			var classRef:Class = getDefinitionByName(className) as Class;
			var trans:Sprite = new classRef(start,_end,duration);
			this.addChild(DisplayObject(trans));
			trans.addEventListener(Event.COMPLETE, onTransitionComplete,false,0,true);
		}
		
		public function onTransitionComplete(e:Event):void
		{
			dispatchEvent(new Event(COMPLETE));
		}
		
		public function get end():DisplayObject
		{
			return _end;
		}
		
	}
}