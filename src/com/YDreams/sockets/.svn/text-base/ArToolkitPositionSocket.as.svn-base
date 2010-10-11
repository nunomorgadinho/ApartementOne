/**
 * $Id: SegmentPositionSocket.as 87 2007-04-20 14:50:12Z nmorgadinho $
 * 
 * A socket for use with SegmentPositionServer.
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
	* For use with the SegmentPosition server.
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
	public class ArToolkitPositionSocket extends AbstractSocket 
	{
		private var _nAreas:int;
		private var _timer:Timer;
		
		public function ArToolkitPositionSocket(nAreas:int,timeout:uint):void {
			super();
			_nAreas=nAreas;
			_timer = new Timer(timeout, 1);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_timer.start();
		}
		
		private function timerHandler(event:TimerEvent):void {
			var data:SocketEvent = new SocketEvent(SocketEvent.DATA_NULL);
			data.id = -1; 
			dispatchEvent(data);
        }
		
		override public function onTextSocketData(data_event:DataEvent):void {
			try {
				_timer.reset();
				_timer.start();
				var src:String = data_event.data;
				var elementsArray:Array = src.split('|');
				var posArray:Array = new Array();
				var data:SocketEvent;
				for (var i:int = 0; i < elementsArray.length-1; i++) {				
					data = new SocketEvent(SocketEvent.DATA_RECEIVED);
					posArray = elementsArray[i].split(' ');
					data.id = posArray[0]; 
					data.x = posArray[1].replace(",",".");
					data.y = posArray[2].replace(",",".");
					data.z = posArray[3].replace(",",".");
					data.w = posArray[4].replace(",",".");
					dispatchEvent(data);
				}
				
				/* O DATA_NULL é lançado quando a marca não está a ser detectada.
				*  Se N marcas nao tiverem a ser detectada ele lança N vezes.
				*/
				for (var j:int = 0; j < _nAreas; j++) {
					var found:Boolean = false;
					for (i = 0; i < elementsArray.length-1; i++) {
						var id:int = elementsArray[i].split(' ')[0];
						if (j==id)
						{
							found=true;
							break;
						}
					}
					if (!found)
					{
						data = new SocketEvent(SocketEvent.DATA_NULL);
						data.id = j; 
						dispatchEvent(data);
					}
				}				
				
			} catch (e:Error) {
				trace(e);
				//this.log.error("Error " + e);
			}
		}
		
		override public function onSocketData(event:ProgressEvent):void {
			try {
				var src:String = this.socket.readUTFBytes(this.socket.bytesAvailable);
				var elementsArray:Array = src.split('|');
				var posArray:Array = new Array();
				var data:SocketEvent;
				for (var i:int = 0; i < elementsArray.length-1; i++) {
					data = new SocketEvent(SocketEvent.DATA_RECEIVED);
					posArray = elementsArray[i].split(' ');
					data.id = posArray[0]; 
					data.x = posArray[1].replace(",",".");
					data.y = posArray[2].replace(",",".");
					data.z = posArray[3].replace(",",".");
					data.w = posArray[4].replace(",",".");
					dispatchEvent(data);
				}
				
			} catch (e:Error) {
				trace(e);
				//this.log.error("Error " + e);
			}
		}
	}
}