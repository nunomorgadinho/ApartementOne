package utils 
{

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import com.YDreams.utils.XMLLoader;
	import flash.ui.Mouse;
	import flash.display.DisplayObject;
	import com.YDreams.utils.YLogger;
	
	dynamic public class Settings extends Proxy implements IEventDispatcher {
		
		public static const INIT:String = "init";
		private static var instance:Settings;
		private var eventDispatcher:EventDispatcher;
		private var data:XML;
		private var urlLoader:URLLoader;		
		
		public function get isLoaded():Boolean {
			return data != null;
		}
				
		public function Settings(enforcer:SingletonEnforcer) {		
			eventDispatcher = new EventDispatcher();
		}
		
		private function onXMLDataLoaded(event:Event):void {
			data = XML(urlLoader.data);		
			
			if (data.mouse.@enabled == false)
			{
				Mouse.hide();
				//mdm.Input.Mouse.hide();		 		
			}		
			
			dispatchEvent(new Event(Settings.INIT, true, true));
		}
		
		public static function getInstance():Settings {
			if(Settings.instance == null) {
				Settings.instance = new Settings(new SingletonEnforcer());
			}
			return Settings.instance;	
		}		
		
		flash_proxy override function getProperty(name:*):*
		{
			return data;
		}
		
		public function loadSettings(url:String):void {	
			var urlRequest:URLRequest = new URLRequest(url);
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onXMLDataLoaded);
			urlLoader.load(urlRequest);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false):void {
			eventDispatcher.addEventListener(type, listener, useCapture, priority, weakRef);
		}
		
		public function dispatchEvent(event:Event):Boolean {
			return eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean {
			return eventDispatcher.hasEventListener(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function willTrigger(type:String):Boolean {
			return eventDispatcher.willTrigger(type);
		}
		
	}
	
}

class SingletonEnforcer {}