/**
 * $Id: ISocket.as 212 2007-09-18 14:49:47Z hsilveira $
 * 
 * The ISocket interface.
 * 
 * Description: Definition of the methods that classes using sockets must define.
*/
package com.YDreams.sockets
{
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.DataEvent;
		
	public interface ISocket
	{
		function connect(host:String, port:uint, retry:uint = 0, retryDelay:uint = 15000):void;
		
		function onConnect(event:Event):void;
		
		function onSocketData(event:ProgressEvent):void;	
		
		function disconnect():void;
		
		function send(obj:Object):void;	
		
		function handleError(event:IOErrorEvent):void;
	}
}