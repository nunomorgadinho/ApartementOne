package com.YDreams.display.Scrollbar
{
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    public class ScrollContent extends Sprite
    {
        // elements
        protected var content:Sprite;
        protected var scrollbar:Scrollbar;
        protected var contentHeight:Number;
       
        /**
         * Constructor
         */
        public function ScrollContent( clip:Sprite, scroller:Scrollbar, scrollRect:Rectangle )
        {
            content = clip;
            contentHeight = clip.height;
            content.scrollRect = scrollRect;
           
            scrollbar = scroller;
           
            scrollbar.addEventListener( SliderEvent.CHANGE, updateContent );
        }
       
        public function updateContent( e:SliderEvent ):void
        {
        	var p:Number = e.percent;
        	//trace("ScrollRect Heigh "+content.scrollRect.height);
        	//trace("ScrollRect x: "+content.scrollRect.x);
        	//trace("ScrollRect y: "+content.scrollRect.y);
        	
        	//trace("contentHeight "+contentHeight+"  content.scrollRect.height "+content.scrollRect.height);
            var scrollable:Number = contentHeight - content.scrollRect.height;
			//trace("scrollable "+scrollable);
            var sr:Rectangle = content.scrollRect.clone();
            if (p > 0.99) p = 1; //fix (should use integers instead of Number
            
            sr.y = (scrollable+8) * p;
            content.scrollRect = sr;
        }
        
        public function updateScrollContent( clip:Sprite ):void
        {
            contentHeight = clip.height;
        }
    }
}