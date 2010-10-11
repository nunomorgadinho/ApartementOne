﻿ /**
 * $Id: SegmentPositionSocket.as 164 2007-06-20 16:09:43Z hsilveira $
 * 
 * A socket for use with SegmentPositionServer.
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
	* For use with the SegmentPosition server.
	* 
	* This class extends the AbstractSocket class.
	*
	* <p><strong>Usage</strong><br /><br />
	* See the example.
	*
	* @example <listing version="3.0">
	* var so:SegmentPositionSocket = new SegmentPositionSocket();
	* so.connect("localhost", 24242, 0);
	* so.addEventListener(SocketEvent.CONNECTED, onConnect);
	* so.addEventListener(SocketEvent.DATA_RECEIVED, onData);
	*	
	* private function onConnect(e:SocketEvent):void
	* {
	* 	trace("Connected..");
	* }
	*	
	* private function onData(e:SocketEvent):void
	* {
	* 	trace("x = " + e.x + ", y = " + e.y);
	* }
	* </listing>
	* 
	*/

 	public class SegmentPositionSocket extends AbstractSocket
 	{ 		
 		public function SegmentPositionSocket():void
 		{
 			super(); 			
 		}
 		
 		override public function onTextSocketData(data_event:DataEvent):void
		{
			try
			{ 
				var src:String = data_event.data;
				if (src == "") throw new Error("Empty String");
				parse(src);								
	  		} 
	  		catch (e:Error) {
	  		 	//this.log.error("Error " + e);
	  		}
		} 		
 		
 		override public function onSocketData(prog_event:ProgressEvent):void
		{
			try
			{ 
				var src:String = this.socket.readUTFBytes(this.socket.bytesAvailable);				
				if (src == "") throw new Error("Empty String");
				parse(src);
	  		} 
	  		catch (e:Error) {
	  		 	//this.log.error("Error " + e);
	  		}
		}
		
		private function parse(src:String):void
 		{
 			var elementsArray:Array = src.split('|');
			var elem:Array;
			for (var i:uint=0 ; i<elementsArray.length-1 ; i++)
			{
				elem = elementsArray[i].split(' ');									
				
				if (this.use_hitTest) {
					run_hitTest();
				}
				
				var event:SocketEvent = new SocketEvent(SocketEvent.DATA_RECEIVED);
				event.x = elem[0];
				event.y = elem[1];
				dispatchEvent(event);
			}
			
 		}
 	}
 }