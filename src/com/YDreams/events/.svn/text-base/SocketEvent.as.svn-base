// ActionScript file
package com.YDreams.events
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.display.DisplayObject;
	
	public class SocketEvent extends Event
	{
 		public static const CONNECTED:String = Event.CONNECT;
 		public static const DATA_RECEIVED:String = "DATA_RECEIVED";
		public static const DATA_NULL:String = "DATA_NULL";
 		public static const ON_CLICK:String = "ON_CLICK";
 		public static const ON_OVER:String = "ON_OVER";
 		public static const ON_OUT:String = "ON_OUT";
 		public static const IO_ERROR:String = IOErrorEvent.IO_ERROR;
 		public static const CLOSE:String = Event.CLOSE;
 		public static const SECURITY_ERROR:String = SecurityErrorEvent.SECURITY_ERROR;
 		public static const SOCKET_DATA:String = ProgressEvent.SOCKET_DATA;
 		
		private var _x:int;
		private var _y:int;	
		private var _z:Number;
		private var _w:Number;
		private var _id:Number;
		private var _event:String;
		private var _prox:int;
		private var _zone:int;
		private var _object:DisplayObject;
		
		public function SocketEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}
				
		/**
		 * The X coordinate.
		 * @param x
		 * 
		 */		
		public function set x(x:int):void {
			_x = x;
		}
		
		public function get x():int {
			return _x;
		}

		/**
		 * The Y coordinate.
		 * @param y
		 * 
		 */				
		public function set y(y:int):void {
			_y = y;
		}
		
		public function get y():int {
			return _y;
		}		
		
		/**
		 * The W coordinate (to use with ArToolkitPositionSocket).
		 * @return 
		 * 
		 */		
		public function get w():Number {
			return _w;
		}
		
		public function set w(w:Number):void {
			_w = w;
		}
		
		/**
		 * The Z coordinate (to use with ArToolkitPositionSocket).
		 * @return 
		 * 
		 */		
		public function get z():Number {
			return _z;
		}
		
		public function set z(z:Number):void {
			_z = z;
		}
		
		/**
		 * The id of each ArToolkitPosition mark. (to use with ArToolkitPositionSocket).
		 * @return 
		 * 
		 */		
		public function get id():Number {
			return _id;
		}
		
		public function set id(id:Number):void {
			_id = id;
		}
		
		/**
		 * The event received from the SensorBar FL, FR, OVER, NE (to use with SensorBarSocket).
		 * @param event
		 * 
		 */		
		public function set event (event:String):void
		{
			_event = event;
		}
	
		public function get event ():String
		{
			return _event;
		}
	
		/**
		 * The distance (in the Y-axis) from the SensorBar. (to use with SensorBarSocket).
		 * @param prox
		 * 
		 */		
		public function set prox (prox:int):void
		{
			_prox = prox;
		}
	
		public function get prox ():int
		{
			return _prox;
		}
		
		/**
		 * The zone id (to use with ZoneActivitySocket).
		 * @param zone
		 * 
		 */		
		public function set zone(zone:int):void {
			_zone = zone;
		}
		
		public function get zone():int{
			return _zone;
		}
		
		/**
		 * The internal use.
		 * @return 
		 * 
		 */		
		public function get object():DisplayObject {
			return _object;
		}
		
		public function set object(object:DisplayObject):void {
			_object = object;
		}
		
	}	
}