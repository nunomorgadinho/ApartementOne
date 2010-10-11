// $Id$ //
package com.YDreams.utils
{
	import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.system.*;
    import flash.net.*;
    
    /**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* You should use this class if you want to load elements (movieclips) from an swf at runtime. 
	* This approach gives you the advantage of changing the elements in the library withou the need to recompile your application, 
	* as oposition to the [embeded] approach (where you must recompile your application everytime the library assets change) <br />
	*
	* <p><strong>Usage</strong><br /><br />
	* The swf (created in flash CS3) will act as an external library that must be present at all times side-by-side with your application <br /> 
	* The library must be generated for flash player 9 (Actionscript 3).<br /> You must give "linkage" to the movieclips you want to access</p>
	*
	* @example <listing version="3.0">
	* // Declare a variable
	* private var _assets:AssetLoader;
	* 
	* // Load Library
	* _assets = new AssetLoader(_xml.mask_file_path);				
	* _assets.addEventListener(_assets.ON_LOADED, drawStage);
	* _assets.addEventListener(_assets.ON_ERROR, handleError); 
	* 
	* private function drawStage(e:Event):void{
	* 	  var myMask:MovieClip = _assets.getSkinAsset("myMovie") as MovieClip;
	* }
	* 
	* private function handleError(e:Event):void{
	*     trace("Gor Error")
	* }
	* 
	* </listing>
	* 
	*/
	public class AssetLoader extends Sprite
	{
		private var theSkin:Loader;
		private var isLoaded:Boolean;

		public static const ON_ERROR			: String = "AssetLoaderError";
		public static const ON_LOADED 		: String = "LibraryLoaded";
		
		/**
		 * The class constructor
		 * 
		 * @param library The path to the swf (library)
		 * @return void
		 */
		public function AssetLoader(library:String):void{	
			isLoaded = false;
            loadSkin(library);           
        }
        
        private function loadSkin(library:String):void{
			theSkin = new Loader();
			theSkin.contentLoaderInfo.addEventListener(Event.COMPLETE, skinLoadedHandler);
			theSkin.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			theSkin.load(new URLRequest(library));
        }
        
        private function skinLoadedHandler(event:Event):void{
		dispatchEvent(new Event(AssetLoader.ON_LOADED));
        	isLoaded = true;
        }
        
        // Wrapper for the getSkinAsset
        /**
        * Returns a DisplayObject from the loaded library using its name
        * 
        * <p> If the asset has no linkage it will return <strong>null</strong> so make sure you handle it properly </p>
        * 
        * @param asset The name of the asset you wish to fetch from the library
        */
        public function getAsset(asset:String):DisplayObject{
        	return getSkinAsset(asset);
        }
        
        /**
        * [DEPRECATED] Please use getAsset() instead
        * 
        * @see #getAsset()
        */ 
        public function getSkinAsset(skinAsset:String):DisplayObject{
        	try
        	{
				var assetClass:Class = theSkin.contentLoaderInfo.applicationDomain.getDefinition(skinAsset) as Class;
				var asset:* = new assetClass();
				return asset;
        	}
        	catch(e:Error)
         	{
				dispatchEvent(new Event(ON_ERROR));	
         	}
			return null;
        }
	
		private function onError(e:IOErrorEvent):void{
			dispatchEvent(e);
		}
		
        public function loaded():Boolean
        {
        	return isLoaded;
        }
        
	}
}