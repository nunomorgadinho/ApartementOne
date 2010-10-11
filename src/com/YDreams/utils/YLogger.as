/* $Id$ */
package com.YDreams.utils
{
	import com.ThirdParty.luminicbox.log.*;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.display.MovieClip;
	import mdm.*;

	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* This class is heavily based on the logger from Luminicbox.
	* It allows logging messages to the console (trace) but also to the FlashInspector console
	* which is embebbed auto. in your application if you use this class. The overload of doing this is 60Kb.
	* To activate the FlashInspector use the keyboard shortcut: Ctrl+Shift+C
    *
  	* The idea is to extend this class to also allow logging to files, databases, socket ou e-mail.
	* 
	* Original work by Hugo Silveira. Documented by Nuno Morgadinho.
	*
 	* <p><strong>Usage</strong><br /><br />
 	* See the example.
 	* If you want to use this class instead of a bunch of trace's in 
 	* your code you can do overwrite the trace function:    
    * 
    * public function trace(msg:String):void
    * {
    *     myLog.log(msg);
    * }
	*
	* @example <listing version="3.0">
	* import com.YDreams.utils.YLogger;
	* ...
	* private var myLog:YLogger = new YLogger(stage);
	* 
	* // Use the FlashInspector.
	* myLog.activate(myLog.LOG_CONSOLE);
	* // Use the output window (debug mode) -- same as using 'trace'.
	* myLog.activate(myLog.LOG_OUTPUT);
	* // Use a file to log the output
	* myLog.activate(myLog.LOG_FILE); 
	* // Define the min logging level as Fatal (do logs only to the same or higher log levels). 
	* myLog.setLevel(myLog.LEVEL_FATAL);
	* // Log message at the DEBUG level.
	* myLog.debug("Hello World");
	* 
	* </listing>
	*/
	public class YLogger extends Sprite
	{
		//[Embed(source="../../../embeds/ThirdParty/luminicbox/FlashInspector.swf")]
		private var consoleCls:Class;
		
		public const LOG_CONSOLE 	: int = 0;
		public const LOG_OUTPUT 	: int = 1;
		public const LOG_FILE 		: int = 2;

		public const LEVEL_ALL:Level 		= Level.ALL;
		public const LEVEL_LOG:Level 		= Level.LOG;
		public const LEVEL_DEBUG:Level 		= Level.DEBUG;
		public const LEVEL_INFO:Level 		= Level.INFO;
		public const LEVEL_WARN:Level 		= Level.WARN;
		public const LEVEL_ERROR:Level 		= Level.ERROR;
		public const LEVEL_FATAL:Level 		= Level.FATAL;
		public const LEVEL_NONE:Level 		= Level.NONE;
		
		private var _stage:Stage;
		private var _consoleLuminic:Sprite 	= null;
		private var _pubsLuminic:int 		= 0;
		private var _logLuminic:Logger 		= null;	// Used for log
		private var _logFile:Boolean		= false;
		private var _logFileName:String		= new String("APP_LOG_FILE.txt");
		
		public function YLogger(stage:Stage)
		{	
			_stage = stage;
			//mdm.Application.init(this,OnInit);
		//}
		
		//private function OnInit():void {
			initLuminic();
		}
		
		private function initLuminic():void
		{
			if (_logLuminic==null)
			{
				_logLuminic = new Logger("myLogger");
			}
		}
		
		private function initConsole():void
		{
			if (_consoleLuminic==null)
			{
				var loader:MovieClip = new consoleCls();
	
				_consoleLuminic = new Sprite();
				_consoleLuminic.addChild(loader);
				_consoleLuminic.addEventListener(MouseEvent.MOUSE_DOWN, dragConsole);
				_consoleLuminic.addEventListener(MouseEvent.MOUSE_UP, releaseConsole);
				_consoleLuminic.visible = false;
				
				_stage.addChild(_consoleLuminic);	
				_stage.addEventListener(KeyboardEvent.KEY_UP, handleKeys);
				_stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, onFocusOut);
				_stage.focus = _stage;
			}
		}
		
		private function dragConsole(e:MouseEvent):void
		{
			_consoleLuminic.startDrag();
		}
		
		private function releaseConsole(e:MouseEvent):void
		{
			_consoleLuminic.stopDrag();
		}
		
		private function handleKeys(e:KeyboardEvent):void
		{
			if (e.ctrlKey && e.shiftKey && e.charCode==99 && e.keyCode==67)
				_consoleLuminic.visible = !_consoleLuminic.visible;				
		}
		
		private function onFocusOut(e:FocusEvent):void
		{
			_stage.focus = _stage;
		}
		
		public function activate(type:int):void
		{
			switch (type)
			{
				case LOG_CONSOLE : 
						_pubsLuminic++;
						initConsole();
						_logLuminic.addPublisher( new ConsolePublisher() );
						//Little Hack =) The first log seems to disapear... This way we make sure we make a first log
						this.log("[internal] Log initialized. The logger is now ready to be used");
						break;
				case LOG_OUTPUT : 
						_pubsLuminic++;;
						_logLuminic.addPublisher( new TracePublisher() );
						break;
				case LOG_FILE :
						_logFile = true;
						break;
			}
			
		}
		
		public function deactivate(type:int):void
		{
			switch (type)
			{
				case LOG_CONSOLE : 
						_pubsLuminic--;
						_logLuminic.removePublisher( new ConsolePublisher() );
						break;
				case LOG_OUTPUT : 
						_pubsLuminic--;;
						_logLuminic.removePublisher( new TracePublisher() );
						break;
				case LOG_FILE :
						_logFile = false;
						break;
			}
		}

        /* log functions */
		/**
		* Logs an object or message with the LOG level.
		* @param argument The message or object to inspect.
		*/
		public function log( argument:Object ):void { 
			
			if(_pubsLuminic) _logLuminic.log(argument);
			
			if (_logFile) LogIntoFile( argument );
		}
		/**
		* Logs an object or message with the DEBUG level.
		* @param argument The message or object to inspect.
		*/	
		public function debug( argument:Object ):void { 
			if(_pubsLuminic) _logLuminic.debug(argument);
			
			if (_logFile) LogIntoFile( argument );
		}
		/**
		* Logs an object or message with the INFO level.
		* @param argument The message or object to inspect.
		*/
		public function info( argument:Object ):void { 
			if(_pubsLuminic) _logLuminic.info(argument);
			
			if (_logFile) LogIntoFile( argument );
		}
		/**
		* Logs an object or message with the WARN level.
		* @param argument The message or object to inspect.
		*/	
		public function warn( argument:Object ):void { 
			if(_pubsLuminic) _logLuminic.warn(argument);
			
			if (_logFile) LogIntoFile( argument );
		}
		/**
		* Logs an object or message with the ERROR level.
		* @param argument The message or object to inspect.
		*/	
		public function error( argument:Object ):void { 
			if(_pubsLuminic) _logLuminic.error(argument);
			
			if (_logFile) LogIntoFile( argument );
		}
		/**
		* Logs an object or message with the FATAL level.
		* @param argument The message or object to inspect.
		*/	
		public function fatal( argument:Object ):void { 
			if(_pubsLuminic) _logLuminic.fatal(argument);
			
			if (_logFile) LogIntoFile( argument );
		}
		
		/**
		* Sets the lowest required level for any message.<br />
		* Any message that have a level that is lower than the supplied value will be ignored.<br />
		* This is the most basic form of filter.
		*/
		public function setLevel( level:Level ):void {
			_logLuminic.setLevel(level);
		}
		
		/**
		 * Loop through all the childs of a object and print the child name.
		 * @param obj - the object to display.
		 * @param path - for internal use.
		 * 
		 */		
		public function logChildren(obj:*, path:String = ""):void
		{
			var n:int = 0;
			log(path+obj.name+" ("+obj.numChildren+" children)");
			for (var i:int ; i<obj.numChildren ; i++)
			{
				var o:* = obj.getChildAt(i);
				try
				{
					n = o.numChildren;
				}
				catch (e:Error)
				{
					n = 0;
				}
				
				if (n>0)
				{
					log(path+o.name+" ("+typeof(o)+")");
					logChildren(o,path+o.name+".");
				}
				else
				{
					trace(path+o.name+" ("+typeof(o)+")");
				}
			}
		}
		
		/**
		 * Sets the LogFile name. The default filename is APP_LOG_FILE. Use this function to specify a new filename.
		 * @param filename - the name of the file (NO EXTENSION) eg: newlogfile.
		 */
		public function setLogFileName( filename:String ):void
		{
			_logFileName = filename + ".txt";
		}
		
		/**
		* Logs into file
		* @param argument The message or object to be written into file.
		*/
		private function LogIntoFile( argument:Object ):void
		{
			if (! mdm.FileSystem.fileExists(mdm.Application.path + _logFileName)) {
				mdm.FileSystem.saveFileUnicode(mdm.Application.path + _logFileName, "");
			}
			
			mdm.FileSystem.appendFileUnicode(mdm.Application.path + _logFileName, argument + "\r\n");
		}
	}
}