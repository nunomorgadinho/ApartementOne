 /**
 * $Id: ProximitySocket.as 87 2007-05-23 hsilveira $
 * 
 * A socket to use with SensorServer.
 * 
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
	* For use with the SensorServer server.
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

 	public class ProximitySocket extends AbstractSocket
 	{ 		
 		public function ProximitySocket():void
 		{
 			super(); 			
 		}
 		
 		override public function onTextSocketData(data_event:DataEvent):void
		{
			var src:String = data_event.data;
			
			if (src!=null)
				socketDataHandler(src);
		}
 		
 		override public function onSocketData(e:ProgressEvent):void
		{
			var src:String = this.socket.readUTFBytes(this.socket.bytesAvailable);

			if (src!=null)
				socketDataHandler(src);
		}
		
 		private function socketDataHandler(src:String):void
		{
			src = src.substr(1, src.length);
 			var elem:Array = src.split(';');
			var event:SocketEvent = new SocketEvent(SocketEvent.DATA_RECEIVED);
			event.prox = elem[0];
			dispatchEvent(event);
		}
		
 	}
 }