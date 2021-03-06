﻿// $Id: XMLLoader.as 158 2007-06-12 13:58:00Z tbilou $ //
package com.YDreams.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* You should use this class to load XML at runtime. This class will catch and dispath the errors for you.<br />
	*
	* <p><strong>Usage</strong><br /><br />
	* Instanciate the class and listen for the EVENT ON_LOAD and ON_ERROR.<br />]
	* If you want to access the XML object later on your code (outside init() ) you can declare the XMLLoader as a class variable
	* or create a class variable to hold your XML. Just don't declare both variables function variables =)
	*
	* @example <listing version="3.0">
	* 
	* var xml:XMLLoader = new XMLLoader("config.xml");
	* xml.addEventListener(xml.ON_LOAD, init, false, 0, true);
	* xml.addEventListener(xml.ON_ERROR, handleError, false, 0, true);
	* 
	* 
	* private function init(e:Event):void{
	* 	trace(e.target.xml);
	* }
	* 
	* private function handleError(e:Event):void{
	* 	trace("Gor Error")
	* }
	* 
	* </listing>
	* 
	*/
	public class XMLLoader extends EventDispatcher
	{
		public const ON_LOAD			: String = "loadComplete";
		public const ON_ERROR			: String = "loadError";
		
		private var _xml:XML;
		
		/**
		 * The Class Constructor. If you pass the path to an XML file it will automatically load it
		 * 
		 * @param url The path to the xml file
		 */ 
		public function XMLLoader(url:String = null){
			if(url != null)
				load(url);			
		}
		/**
		 * Loads the XML File.
		 * 
		 * <p>If you don't wish to pass the url in the constructor function you can call the load directly</p>
		 * 
		 * @example <listing version="3.0">
		 * 	var xml:XMLLoader = new XMLLoader();
		 * 	xml.load("config.xml");
		 * 
		 * </listing>
		 * 
		 * @param url The path to the xml file
		 */ 
		public function load(url:String):void{
			if(url != null){
				
				var xmlURL:URLRequest = new URLRequest(url);
				var xmlLoader:URLLoader = new URLLoader();
				
				xmlLoader.addEventListener(Event.COMPLETE,xmlLoaded);
				xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
				
				try{
					xmlLoader.load(xmlURL);
				}catch (e:Error){
					trace("[XMLLoader] ERROR: This should never happend...");
					dispatchEvent(new Event(ON_ERROR));
				}
			}
		}

		/**
		 * Getter for the XML object
		 */
		public function get xml():XML{
			return _xml;
		}
		
		
		private function handleError(e:IOErrorEvent):void
		{
			dispatchEvent(new Event(ON_ERROR));	
		}

		private function xmlLoaded(eventObject:Event):void{
			_xml = new XML(eventObject.currentTarget.data);
			dispatchEvent(new Event(this.ON_LOAD));
		}
		
	}
}