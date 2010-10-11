package com.YDreams.display {
	import flash.display.Sprite;
	import com.YDreams.display.*;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	
	import com.YDreams.events.SocketEvent;
	import com.YDreams.sockets.AbstractSocket;

	
	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* This class allows you to create Screensavers based on the SlideShow classe.<br />
	* It differs from the SlideShow class because it implements a number of ways to start and stop the screensaver
	* using the keyboard, mouse or socket.<br />
	* <br/>
	* The screensaver is started after the specified timeout (defined in the activate function) has occurred. It can be deactivated using the Mouse, Keyboard and/or Socket.
	* It implements a lock mecanism. It can only be locked using a key (Keyboard) or using the lock() function. The same is true for the unlock.
	* 
	* <p><strong>Usage</strong><br /><br />
	*  
	* 1) Create an array of assets and pass it to the contructor of the Slideshow class.<br />
	* 2) Call the activate method with the number of seconds needed to start the screensaver. <br />
	* 3) Specify a way to stop the screensaver.
	* 
	* </p>
	*
	* @example <listing version="3.0">
	* 
	* //import the classes
	* import com.YDreams.display.*;
	* 
	* //Specify the assets to load
	* var pics:Array = new Array("C:\\GameData\\fifascreen.jpg", "C:\\GameData\\nfsscreen.jpg"); 
	* 
	* //Create an instance of the class
	* var ss:ScreenSaver = new ScreenSaver(pics); 
	* s.activate(20); //20 seconds
	* 
	* addChild(s);
	* 
	* //Start the ScreenSaver
 	* s.useMouse()
	* 
	* </listing>
	* 
	* <p><strong>Author</strong><br /><br />
	* Hugo Silveira
	*/
	public class ScreenSaver extends SlideShow
	{
		private var _socket:AbstractSocket;
		private var _target:DisplayObject;
		private var _source:String;
		private var _wait:uint;
		private var _runtimer:Timer;
		private var _keyLock:String;
		private var _keyUnlock:String;
		private var _waitInterval:Number;
		public  var _active:Boolean;
		private var _locked:Boolean;
		
		/**
		 * 
		 * @param sources An array of assets (you can use anything the YDreams.display.media class can handle)
		 * @param srcwidth The Width of the applications screen
		 * @param srcheight The Height of the applications screen
		 * @param delay The delay between transitions (in Seconds)
		 * @param transition The kind of transition you want to use. All the transitions are specified in the Transision class
		 * @param duration The duration of the transition (in Seconds). Make sure this is not higher than the delay parameter
		 * @param target The DisplayObject that will stay behind the screensaver. It's visible property will be set to false when the screensaver is on.
		 * 
		 * @return void
		 * 
		 */		 		
		public function ScreenSaver(sources:Array, scrwidth:uint = 1024, scrheight:uint = 768, delay:Number = 3, transition:String = "Fade", duration:Number = 1.5, target:DisplayObject = null)
		{
			super(sources, scrwidth, scrheight, delay, transition, duration);
			
			this.name = "Screensaver";
			
			_target = target;
			
			_active = false;
			_locked = false;
		}
		
		/**
		 * activate - Start the ScrenSaver Animation
		 * 
		 * @param wait - Number of seconds to start the screensaver (Seconds)
		 * 
		 */		
		public function activate(wait:Number):void
		{
			_wait = wait * 1000; //Keep it in miliseconds
			trace("activating");	
			StartTimer();
			this.addEventListener("ON_SHOW",hideTarget);
		}
		
		private function hideTarget(e:Event):void
		{
			if (_target != null) _target.visible = false;
		}
		
		/**
		 * useKeys - Activate keys control. Specify a lock (activate) and an unlock (deactivate) key to start and stop the screensaver.
		 * 
		 * @param focus - An instance of the displayObject class. This is usually the class where we create the screensaver
		 * @param lock - Keyboard character key to use to show screen saver
		 * @param unlock - Keyboard character key to use to hide screen saver
		 * 
		 */		
		public function useKeys(focus:DisplayObject, unlock:String, lock:String = "dummy"):void
		{
			_keyLock = lock;
			_keyUnlock = unlock;
			
			focus.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys);
		}
		
		/**
		 *  useMouse - Activate mouse control. Use the mouse to stop (hide) the screensaver.
		 * 
		 */		
		public function useMouse():void
		{			
			addEventListener(MouseEvent.MOUSE_MOVE, handleMouse);			
			addEventListener(MouseEvent.MOUSE_DOWN, handleMouse);
			
			if (_target!=null)
			{
				_target.addEventListener(MouseEvent.MOUSE_MOVE, handleMouse);			
				_target.addEventListener(MouseEvent.MOUSE_DOWN, handleMouse);
			}
		}
		
		/**
		 * useSocket - Activate socket control. When data arrives on the socket the screensaver is stopped.
		 * 
		 * @param socket - Any socket that extends AbstractSocket
		 * 
		 */
		public function useSocket(socket:AbstractSocket):void
		{
			_socket = socket;
			_socket.addEventListener(SocketEvent.DATA_RECEIVED, handleSocket);			
		}
		
		/* ================[ Event Handlers ]================== */
		
		/**
		 * handleKeys - Lock/unlock screensaver
		 * 
		 * @param e - KeyboardEvent
		 * 
		 */
		private function handleKeys(e:KeyboardEvent):void {
    		var key:String = String.fromCharCode(e.charCode);
		//trace(key.toLowerCase());
		//trace("KEY "+key);
    		if (!isLocked() && key.toLowerCase() == _keyLock.toLowerCase())
    		{
    			lock();
    		}
    		else if ((isLocked() || isActive()) && key.toLowerCase() == _keyUnlock.toLowerCase())
    		{
    			unlock();
    			resetTimer();
    		}
		}
		
		/**
		 * handleMouse - hides screensaver on mouse event
		 * 
		 * @param e - MouseEvent
		 * 
		 */		
		private function handleMouse(e:MouseEvent):void
		{
			//trace("mouse move, active:"+isActive());
    		if (!isLocked() && isActive())
    		{
    			hide();
    		}
    		resetTimer();
		}
		
		/**
		 * socketListenning - hides screensaver on socket activity
		 * 
		 * @param e - SocketEvent
		 * 
		 */		
		private function handleSocket(e:SocketEvent):void
		{
    		if (!isLocked() && isActive())
    		{
    			hide();
    		}
    		resetTimer();
		}
		
		/**
		 * isLocked
		 * 
		 * @return true if screensaver is locked
		 * 
		 */
		public function isLocked():Boolean
		{
			return this._locked;
		}
		
		/**
		 * isActive
		 * 
		 * @return true if screensaver is visible
		 * 
		 */
		public function isActive():Boolean
		{
			return this._active;
		}
		
		
		
		/**
		 * show - show screensaver if is time to
		 * 
		 * @param e - TimerEvent
		 * 
		 */
		public function show(e:TimerEvent):void
		{
			if (!isLocked() && !isActive())
			{
				this.visible = true;

				try
				{
					this.start();
				}
				catch (error:Error)
				{
					trace(error.message);
					throw error;
				}
				
				_active = true;
				
		

			}
		}
		
		/**
		 * hide - hides screensaver
		 * 
		 */
		private function hide():void
		{
			if (_active)
			{
				this.removeAllTransitions();
				this.visible = false;
				this.stop();
				this.clear();
				_active = false;
				if (_target != null) _target.visible = true;	
				var data:Event = new Event("ON_HIDE");
				dispatchEvent(data);
			}
		}
		
		/**
		 * Locks screensaver. If the screensaver is locked it will not respond to the mouse and socket events. You can only unlock the screensaver using the unlock key or calling the unlock funcion. 
		 */
		public function lock():void
		{
			if (!_active)
				show(null);
					
			_locked = true;
		}
		
		/**
		 * Unlocks the ScreenSaver. The screensaver can only be locked using the lock Key or the Lock function
		 * 
		 */
		public function unlock():void
		{
			hide();
			
			_locked = false;
		}
		
		/**
		 * StartTimer - start countdown
		 * 
		 */
		private function StartTimer():void
		{
			_runtimer = new Timer(_wait, 0);
			_runtimer.addEventListener(TimerEvent.TIMER, show);
			_runtimer.start();
		}
		
		/**
		 * StopTimer - stops timer
		 * 
		 */
		public function StopTimer():void
		{		
			if (!isLocked())
			{
				_runtimer.stop();
				hide();
			}
		}
		
		/**
		 * resetTimer - Restart the Timer countdown
		 * 
	 	*/
		public function resetTimer():void
		{
			if (!isLocked())
			{
				hide();
			}
			_runtimer.reset();
			_runtimer.start();
		}
	}
}