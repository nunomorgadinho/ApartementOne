package com.YDreams.display
{
	import flash.display.*;
	import flash.geom.Rectangle;
	import com.YDreams.display.Scrollbar.*;
	
	/**
    * <img src = "http://www.iilab.com/flashdocs/logo.png" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* This class enables the use scrollbars in an AS3 project.
	* This class does not create the scrollbar. You must have all the movieclips that make up the scrollbar in the screen you want to use.
	*
 	* <p><strong>Usage</strong><br /><br />
	* Create a movieclip with the 5 (five) elements you need to use the scrollbar<br />
	*  - contents area (linkage: bg)          [sprite]<br />
	*  - button up     (linkage: btn_up)      [simpleButton]<br />
	*  - button down   (linkage: btn_down)    [simpleButton] <br />
	*  - scroller		(linkage: scroller)    [sprite]<br />
	*  - scroller_bg		(linkage: scroller_bg) [sprite]<br />
	* <br />
	* Add this movieclip (with all the elements) to the stage (addchild) and passe it to the YScrollbar constructor. You're done :)
	* </p>
	*
	* @example <listing version="3.0">
	* 
	* //import the classes
	* import com.YDreams.display.Scrollbar.*;
	* 
	* var screen1:MovieClip = _assets.getAsset("screen1") as MovieClip; //this is the movieclip containing the 5 items
	* addChild(screen1);
	* 
	* var s:YScrollbar = new YScrollbar(stage, screen1.scroll_guide);
	*
	*
	* var d:Sprite = _assets.getAsset("dummy") as Sprite;
	* s.addContents(d);
	* 
	* </listing>
	* 
	* <p><strong>Author</strong><br /><br />
	* Tiago Bilou
	*/
	public class YScrollbar
	{
		private var _scroll_container:MovieClip;
		private var _content:Sprite;
		private var _content_height:Number;
		
		private var _btn_up:SimpleButton;
		private var _btn_down:SimpleButton;
		private var _slider:Sprite;
		private var _slider_bg:Sprite;
		private var _bg:Sprite;
		
		private var _scrollbar:Scrollbar;
		private var _scrollContent:ScrollContent;
		private var _scroll_rect:Rectangle;
		
		/**
		 *  Class Constructor
		 */
		public function YScrollbar(stage:DisplayObject, container:MovieClip)
		{
			_scroll_container = container;
			
			// Set the variables
			_btn_up 	= container.btn_up 		as SimpleButton;
			_btn_down 	= container.btn_down 	as SimpleButton;
			_slider 	= container.scroller 	as Sprite;
			_slider_bg	= container.scroller_bg as Sprite;
			_bg			= container.bg			as Sprite;
			
			//Create the content
			_content_height = 0;
			_content = new Sprite();
			container.addChild(_content);

			//Instantiate Scrollbar
			_scrollbar 	 = new Scrollbar(stage, _slider, _slider_bg, _btn_up, _btn_down);
			
			// Set the dimensions of the rectangle
			_scroll_rect = new Rectangle(_bg.x, _bg.y, _bg.width, _bg.height);
			
			updateContents();
		}
		
		public function addContents(content:Sprite):void
		{
			//Set the Y property of the element to add to the container
			content.y = _content.height;
			
			_content.addChild(content);
			//Update the conteiner height
			_content_height += content.height;
			
			// Update the ScrollContent
			updateContents();
		}
		
		private function updateContents():void
		{
			_scrollContent = new ScrollContent(_content, _scrollbar, _scroll_rect);
			_scrollbar.hide( (_content.height > _scroll_rect.height) ?  true : false )
		}
		
		//public function get content():Sprite { return _content; }
	}
}