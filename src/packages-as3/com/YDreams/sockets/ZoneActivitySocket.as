 /**
 * $Id: ZoneActivitySocket.as 87 2007-05-23 hsilveira $
 * 
 * A socket for use with ZoneActivityServer.
 * Positions.
 */ 
 package com.YDreams.sockets
 {
 	import com.YDreams.events.SocketEvent;
 	import flash.events.ProgressEvent;
 	import flash.events.DataEvent;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
 	
 	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* For use with the ZoneActivity server.
	* 
	* This class extends the AbstractSocket class.
	*
	* <p><strong>Usage</strong><br /><br />
	* No usage has been provided.
	*
	* @example <listing version="3.0">
	* See the SegmentPositionSocket example.
	* </listing>
	* 
	*/

 	public class ZoneActivitySocket extends AbstractSocket
 	{ 		
	
		public  var _newActivity:int;
		public  var _sameActivity:int;			
		public  var _canMove:Boolean;
		public  var _lastValue:int;
		public  var _timer:Timer;
	
 		public function ZoneActivitySocket():void
 		{
			_newActivity=0;
			_sameActivity=0;
			_timer = null;
			
 			super(); 
 		}
 		
 		override public function onTextSocketData(data_event:DataEvent):void
		{
			try
			{ 
				var src:String = data_event.data;				
		        var event:SocketEvent = new SocketEvent(SocketEvent.DATA_RECEIVED);
	    	    event.zone = parseInt(src);
				if (_timer==null)
				{
					_canMove=false;
					if (_lastValue==-1)
					{
						_timer = new Timer(_newActivity, 1);			
					}
					else
					{
						_timer = new Timer(_sameActivity, 1);	
					}
					_timer.addEventListener(TimerEvent.TIMER, filterHandler);
					_timer.start();
				}
				_lastValue = event.zone;
				if (_canMove)
				{
					if (event.zone!=-1)
					{
	        			dispatchEvent(event);
						_timer = null;
					}
				}
				/* DATA NULL */
				if (event.zone==-1)
				{
					event = new SocketEvent(SocketEvent.DATA_NULL);
					dispatchEvent(event);
				}
	        	
	  		} catch (e:Error) {
	  		 	this.log.error("Error " + e);
	  		}
		}
 		
		private function filterHandler(event:TimerEvent):void {
			_canMove=true;
		}
		
 		override public function onSocketData(e:ProgressEvent):void
		{
			try
			{ 
				var src:String = this.socket.readUTFBytes(this.socket.bytesAvailable);				
		        var event:SocketEvent = new SocketEvent(SocketEvent.DATA_RECEIVED);
	    	    event.zone = parseInt(src);
	        	dispatchEvent(event);
	        	
	  		} catch (e:Error) {
	  		 	this.log.error("Error " + e);
	  		}
		}
		
		public function set newActivity(valor:int):void
		{
			_newActivity = valor;
		}
		
		public function get newActivity():int
		{
			return _newActivity;
		}
		
		public function set sameActivity(valor:int):void
		{
			_sameActivity = valor;
		}
		
		public function get sameActivity():int
		{
			return _sameActivity;
		}
		
 	}
 }