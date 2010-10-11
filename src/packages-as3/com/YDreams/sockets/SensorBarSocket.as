 /**
 * $Id: SensourSocket .as 87 2007-05-20 14:50:12Z hsilveira $
 * 
 * A socket for use with SensourBarSocket .
 * Positions.
 */ 
 package com.YDreams.sockets
 {
 	import com.YDreams.events.SocketEvent;
 	import flash.events.ProgressEvent;
 	import flash.events.DataEvent;
 	
 	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* For use with the SensorBar server.
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

 	public class SensorBarSocket extends AbstractSocket
 	{ 		
 		public function SensorBarSocket():void
 		{
 			super(); 			
 		}
 		
 		override public function onTextSocketData(data_event:DataEvent):void
		{
			try
			{ 
				var src:String = data_event.data;
				var elementsArray:Array = src.split(',');
				
		        var event:SocketEvent = new SocketEvent(SocketEvent.DATA_RECEIVED);
	    	    event.x = elementsArray[0];
	    	    event.y = elementsArray[1];
	    	    event.event = elementsArray[2];
	    	    event.prox = elementsArray[3];
	    	    
	        	dispatchEvent(event);
	  		} catch (e:Error) {
	  		 	this.log.error("Error " + e);
	  		}
		}
 		
 		override public function onSocketData(e:ProgressEvent):void
		{
			try
			{ 
				var src:String = this.socket.readUTFBytes(this.socket.bytesAvailable);				
				var elementsArray:Array = src.split(',');
				
		        var event:SocketEvent = new SocketEvent(SocketEvent.DATA_RECEIVED);
	    	    event.x = elementsArray[0];
	    	    event.y = elementsArray[1];
	    	    event.event = elementsArray[2];
	    	    event.prox = elementsArray[3];
	    	    
	        	dispatchEvent(event);
	  		} catch (e:Error) {
	  		 	this.log.error("Error " + e);
	  		}
		}
		
 	}
 }