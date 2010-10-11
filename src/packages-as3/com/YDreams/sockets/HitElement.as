package com.YDreams.sockets
{
	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* A HitElement is encapsulation for a (object, timeout, callback) structure that will be
	* used in AbstractSocket if use_hitTest is defined as true.
	* Normally HitElement's are put in an array and a hitTest is done against that array of objects
	* each time a value is received on the socket.
	*
	* <p><strong>Usage</strong><br /><br />
	* You should specify the hitelement you want to use in your application.
	* See the example.
	*
	* @example <listing version="3.0">
	* socket.addHitElement([_template["cor_mc"+1]], 2000, callback1);
	* socket.addHitElement([_template["cor_mc"+2]], 3000, callback2);
	* socket.addHitElement([_template["cor_mc"+3]], 5000, callback3);
	* socket.addHitElement([_template["cor_mc"+4]], 5000, callback4);
	* socket.addHitElement([_template["cor_mc"+5]], 4000, callback5);
	* socket.addHitElement([_template["cor_mc"+6]], 10000, callback6);
	*								
    * trace("numHitElements = " + _socket.numHitElements);
	* socket.raton = _raton;
	* socket.bbtest = true; // use object hittest			
	* 
	* socket.connect("127.0.0.1", 24242);
	*
	* private function callback1() { trace("cor_mc1 clicked"); } 
	* private function callback2() { trace("cor_mc2 clicked"); } 
	* private function callback3() { trace("cor_mc3 clicked"); } 
	* (..)
	* </listing>
	*/
	public class HitElement
	{
		private var _object:*;
		private var _timeout:int;
		private var _callback:Function;
		private var _onOver:Boolean;
		private var _onClick:Boolean;
		private var _onOut:Boolean;
		private var _lasttime:int;  // keep the last time we check this HitElement for updates
				
		public function HitElement(object:*, timeout:int, callback:Function)
		{
			_object = object;
			_timeout = timeout;
			_callback = callback;
			_onOver = false;
			_onClick = false;
			_onOut = false;
			_lasttime = 0;
		}
		
		/**
		 * The object which we will do hitTest against.
		 * @param obj
		 * 
		 */		
		public function set object(obj:Object):void
		{
			_object = obj;
		}
		
		public function get object():*
		{
			return _object;
		}
		
		/**
		 * The function that will be called after timeout has been reached.
		 * @param callback
		 * 
		 */		
		public function set callback(callback:Function):void
		{
			_callback = callback;	
		}
		
		public function get callback():Function
		{
			return _callback;	
		}
		
		/**
		 * Indicates whether we are over the object.
		 * @param value
		 * 
		 */		
		public function set onOver(value:Boolean):void
		{
			_onOver = value;	
		}

		public function get onOver():Boolean
		{
			return _onOver;	
		}
		
		/**
		 * Indicates whether we clicked the object.
		 * @param value
		 * 
		 */		
		public function set onClick(value:Boolean):void
		{
			_onOver = value;	
		}

		public function get onClick():Boolean
		{
			return _onClick;	
		}
		
		/**
		 * Indicates whether we stop being over the object.
		 * @param value
		 * 
		 */		
		public function set onOut(value:Boolean):void
		{
			_onOut = value;	
		}

		public function get onOut():Boolean
		{
			return _onOut;	
		}
		
		/**
		 * The timeout after which the callback is called.
		 * @param value
		 * 
		 */		
		public function set timeout(value:int):void
		{
			_timeout = value;	
		}

		public function get timeout():int
		{
			return _timeout;	
		}
		
		/**
		 * the last time we check this HitElement for updates.
		 * @param value
		 * 
		 */		
		public function set lasttime(value:int):void
		{
			_lasttime = value;	
		}

		public function get lasttime():int
		{
			return _lasttime;	
		}
		
	}
}