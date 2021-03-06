/**
 * $Id: AbstractSocket.as 212 2007-09-18 14:49:47Z hsilveira $
 * 
 * Implementation of the methods for a regular socket connection.
 */
 package com.YDreams.sockets
 {
 	import flash.net.Socket;
 	import flash.display.Sprite;
 	import flash.display.DisplayObject;
 	import flash.events.Event;
 	import flash.events.DataEvent;
	import flash.events.TimerEvent;
 	import flash.events.IOErrorEvent;
 	import flash.events.SecurityErrorEvent;
 	import flash.events.ProgressEvent;
 	import flash.utils.Dictionary;
 	import flash.utils.getTimer;
	import flash.utils.Timer;
 	import flash.errors.IOError;
	import flash.net.XMLSocket;
	import com.YDreams.events.SocketEvent;
	import com.YDreams.utils.YLogger;
	import flash.utils.ByteArray;
 	
 	/* TODO: 
	 * associar a crosshair,
	 * actualizacao da crosshair auto
	 */
 	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* Defines the methods that SegmentPositionSocket, arToolkitPositionSocket, SensorBarSocket, etc,
	* will inherit by extending this class, methods that generally are useful for all applications 
	* that use sockets. The basic idea is to use one of the specific socket classes (e.g. SegmentPositionSocket
	* for a SegmentPosition server) where SegmentPositionSocket is the composition of AbstractSocket
	* plus the specific parse method implemented by the onSocketData method.
	* 
	* This class implements the interface ISocket.
	*
	* <p><strong>Usage</strong><br /><br />
	* You should never have to use this class directly. If you need a new type of socket create a new
	* class resembling e.g. SegmentPositionSocket but with the parse method that your server requires. 
	*
	* @example <listing version="3.0">
	* No example has been provided.
	* </listing>
	* 
	*/
 	public class AbstractSocket extends Sprite implements ISocket 
 	{
 		private var _socket:*;
 		private var _host:String;
 		private var _port:uint;
 		private var _attempts:uint;
 		private var _retryAttempts:uint;
 		private var _log:YLogger;
 		private var _hitObjects:Dictionary;
 		private var _hittest:Boolean;
 		private var _numHitElements:int;
 		private var _refOver:Array;
 		private var _refClick:DisplayObject; 		
 		private var _lasttime:int;
 		private var _raton:Sprite;
 		private var _bbtest:Boolean;
 		private var _retryTimer:Timer;
 		private var _useBinarySocket:Boolean = false;
 		
 		/**
 		* Class constructor
 		*/ 		
 		public function AbstractSocket():void
 		{
			if ( _useBinarySocket )
		 		_socket = new Socket();
		 	else
		 		_socket = new XMLSocket();
 			
 			_hitObjects = new Dictionary(true);
 			_numHitElements = 0;
 			
 			_log = new YLogger(null);
			_log.activate(_log.LOG_OUTPUT);
			
			_refOver= new Array();
			
			_refClick = null;
			_lasttime = 0;
 		}
 		
 		/** 
		*
		* Function: connect
		* Connects to the socket server
		* 
		* Parameters:
		*
	    *  host     - Server host/IP address.
	    *  port   - Server Port Name
		*  
		*/
	 	public function connect(host:String, port:uint, retry:uint = 1, retryDelay:uint = 15000):void
 		{ 
 			_host = host;
 			_port = port;
 			_retryAttempts = retry;
 			_attempts = 0;
 			
 			if (_socket.connected)		
 			{
 				try
 				{
 					_socket.flush();
 				}		
 				catch (error:IOError)
 				{
 					//_log.fatal("socket.flush error\n" + error);
 				}
 			} else {
 				/* Establish a connection */
				_socket.connect(host, port); 		
 			}
 			
 			 /* Create Dispatchers */			
 			_socket.addEventListener(Event.CONNECT, onConnect); // attempt sucess 			 			
 			_socket.addEventListener(IOErrorEvent.IO_ERROR, handleError); // attempt failed	
 			_socket.addEventListener(Event.CLOSE, handleClose);
 			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSecurityError);
 			
 			if ( _useBinarySocket )
	 			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData); // on data received	 		
	 		else
	 			_socket.addEventListener(DataEvent.DATA, onTextSocketData);

           	_retryTimer = new Timer(retryDelay, _retryAttempts);                        
           	_retryTimer.addEventListener(TimerEvent.TIMER, tryConnect);            
    		
    		tryConnect(null);

 		}
 		
		/**
		 * Connect to the socket.
		 */		
		public function tryConnect(e:TimerEvent):void
		{
			_log.log(_attempts+" try to connect to stats router at " + _host + ":" + _port);
		
			if (_socket.connected)		
			{
				_log.log("Already connected to stats router, sending cached stats.");
				_retryTimer.reset();
				_attempts = 0;
			}
			else
			{
				try 
				{
					if (_attempts<_retryAttempts || _retryAttempts==0)
					{
						_attempts++;
						_socket.connect(_host, _port);
					}
					else
					{
						_log.debug("***DIE. No more attempts!***");
					}
				} catch (e:Error) {
					_log.fatal("Error connecting to stats server");
				}
			}				 				
		}
		
		/**
		 * 
		 * left blank intencionally, to implement in classes that extend this one.
		 * 
		 */		
		public function onSocketData(event:ProgressEvent):void
		{
			// blank
		}
		
		/**
		 * 
		 * left blank intencionally, to implement in classes that extend this one.
		 * 
		 */		
		public function onTextSocketData(event:DataEvent):void
		{
			// blank
		}
		
		public function disconnect():void
		{
			_socket.close();
		}
		
		public function onConnect(event:Event):void
		{
			dispatchEvent(new SocketEvent(SocketEvent.CONNECTED));
		}
				
		public function send(obj:Object):void
		{
			_socket.send(obj);
			//nothing
		}
		
		public function sendTextSocketData(src:String):void
		{
			if (_socket.connected)	
			{
				this._socket.send(src);
			}
		}
		
			
		public function handleError(event:IOErrorEvent):void
		{
			//mando para o logger
			_log.fatal("[AbstractSocket] Error");
			if (!_retryTimer.running && _retryAttempts>=0)
			{
				_retryTimer.reset();
				_retryTimer.start();
			}
		}

		public function handleClose(event:Event):void
		{
			//mando para o logger
			_log.fatal("[AbstractSocket] close");
			if (!_retryTimer.running && _retryAttempts>=0)
			{
				_retryTimer.reset();
				_retryTimer.start();
			}
		}

		public function handleSecurityError(event:SecurityErrorEvent):void
		{
			//mando para o logger
			_log.fatal("[AbstractSocket] security error");
			if (!_retryTimer.running && _retryAttempts>=0)
			{
				_retryTimer.reset();
				_retryTimer.start();
			}
		}


		/**
		 * 
		 * @param objects - array of hit objects.
		 * @param timeout - timeout before activate the onClick event.
		 * @return void
		 * 
		 */		
		public function addHitElement(objects:Array, timeout:int = 500, callback:Function = null):void
		{			
			for (var i:int = 0; i < objects.length; i++)
			{
				var obj:HitElement = new HitElement(objects[i], timeout, callback);
				_hitObjects[_numHitElements++] = obj;
				_refOver[i]=null;
				//trace("mc = " + objects[i] + ", timeout = " + timeout);
			}		
		}
		
		public function desactivateZone(id:int):void
		{
			for (var i:int = 0; i < _refOver.length; i++)
			{
				if ((_refOver[i] != null) && (i==id)) 
				{
					var data:SocketEvent = new SocketEvent(SocketEvent.ON_OUT);
					data.object=_refOver[i];
					data.id=id;
					dispatchEvent(data);
					_refOver[i]=null;
					_refClick = null;
					_lasttime = 0;
				}
			}
		}
		
		/**
		 * Function: hitTest 
		 * Does a hitTest for each of the elements in the array hitObjects.
		 * 
		 * @param id
		 * 
		 */		 		
		public function run_hitTest(id:int=-1):void
		{
			var hitResult:Boolean = false;
			var updated:Boolean = false;
			var data:SocketEvent;
			 /* Cicle through all the different objects */
			 //trace("elements:"+_numHitElements);
			for (var i:int = 0; i < _numHitElements; i++)
			{		
				//trace("test hit "+i);	
				var e:HitElement = _hitObjects[i] as HitElement;		
				var object:DisplayObject = e.object as DisplayObject;
				var timeout:int = e.timeout;
				if (object) {
					
					if (!_bbtest)
						hitResult = object.hitTestPoint(_raton.x, _raton.y);
					else
						hitResult = _raton.hitTestObject(object);										
						
					if (hitResult) // Colision detected
					{
						updated = true;
						
						if (_refOver[id]) // se != null dantes estava em cima de alguma coisa
						{						
							if (_refOver[id] == e.object) // se   o mesmo
							{
								if (_refOver[id] != _refClick) // ainda n o lancei Click
								{				
									var now:int = getTimer();
									//trace("hit " + e.object + ",timeout = "+e.timeout+", last = "+_lasttime+", now = "+now+", now - last = " + (now - _lasttime));
									if ((now - _lasttime) > e.timeout)
									{
										dispatchClick(e.callback,object,id); 							
										_refClick = _refOver[id];
										break;
									}
								}
								break;
							}							
							else // se   outro objecto lan ar um onOut e onOver
							{
								data = new SocketEvent(SocketEvent.ON_OUT);
								data.object=_refOver[id];
								data.id=id;
								dispatchEvent(data);
								_refOver[id] = e.object;
								_lasttime = getTimer();
								data = new SocketEvent(SocketEvent.ON_OVER);
								data.object=object;
								data.id=id;
								dispatchEvent(data);
							}
						}
						else // It's the first time we are getting over these element
						{							
							_refOver[id] = e.object;
							data = new SocketEvent(SocketEvent.ON_OVER);
							data.object=object;
							data.id=id;
							dispatchEvent(data);
							_lasttime = getTimer();
							//trace("first time");
							break;
						}						
						break;
					}
					else //No Colision detected
					{					
						//_log.debug("No colision detected");
					}															
				}
			}
			/* End of loop */

			if (!updated) 
			{
				if (_refOver[id])
				{
					data = new SocketEvent(SocketEvent.ON_OUT);
					data.object=_refOver[id];
					data.id=id;
					dispatchEvent(data);
				}
				_refOver[id] = null;
				_refClick = null;
				_lasttime = 0;
			}

		}		

		/**
		 * 
		 * @param callback - function that is associated with this click event.
		 * 
		 */		
		private function dispatchClick(callback:Function,object:DisplayObject,id:int):void
		{
			if (callback!=null)
			{
    	    	callback(object,id);
			}
			var data:SocketEvent = new SocketEvent(SocketEvent.ON_CLICK);
			data.object=object;
			data.id=id;
	    	dispatchEvent(data);			
		}
		
		/**
		 * The socket object.
		 * @return 
		 * 
		 */		
		public function get socket():Socket
		{
			return _socket;
		}

		/**
		 * Indicates whether the class should do a hitTest against an array 
		 * of objects each time it receives a value on the socket.
		 * @param value
		 * 
		 */		
		public function set use_hitTest(value:Boolean):void
		{
			_hittest = value;
		}
		
		public function get use_hitTest():Boolean
		{
			return _hittest;
		}

		/**
		 * The number of elements to do hitTest with.
		 * @return 
		 * 
		 */		
		public function get numHitElements():int
		{
			return _numHitElements;
		}

		/**
		 * The object in the screen whose x,y will be update with
		 * the values we read from the socket.
		 * @param obj
		 * 
		 */		
		public function set raton(obj:Sprite):void
		{
			_raton = obj;
		}
		
		public function get raton():Sprite
		{
			return _raton;
		}

		public function get log():YLogger
		{
			return _log;
		}

		/**
		 * Whether to use hitTestObject (true) or hitTestPoint (false) when doing the hitTest.
		 * hitTestPoint() will always use shapeFlag = false.
		 * @return 
		 * 
		 */		
		public function get bbtest():Boolean
		{
			return _bbtest;
		}

		public function set bbtest(val:Boolean):void
		{
			_bbtest = val;
		}

		/**
		 * Whether to use a binary socket.
		 * What is special about binary sockets? Imagine the following word �telekinesis�.
		 * The binary representation would be 116 101 108 101 107 105 110 101 115 105 115. Every byte goes
		 * from 0 to 0xFF which means you can also read things like the byte 0. Imagine you have a 
		 * multiplayer game and you want to submit the position and scores with every package. 
		 * Using ASCII would create something like 110;234;0. Where x-Pos is 110, y-Pos is 234 and score is 0.
		 * The same information using binary data becomes n�[ZERO BYTE]. Now you were able to reduce your data
		 * from nine to three bytes. Because the 0-byte got no ASCII-representation I have to write [ZERO BYTE].
		 * The ASCII-Data in binary representation means 110 234 0. 
		 * @return 
		 * 
		 */		
		public function get useBinarySocket():Boolean
		{
			return _useBinarySocket;
		}
		
		public function set useBinarySocket(value:Boolean):void
		{
			_useBinarySocket = value;	
		}
		
		public function get connected():Boolean
		{
			return _socket.connected;
		}
 	}
 }
