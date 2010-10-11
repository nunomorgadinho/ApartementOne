package	com.YDreams.display.Scrollbar
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.display.SimpleButton;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.display.DisplayObject;
    import com.YDreams.utils.YMath;

    public class Scrollbar extends Sprite
    {
        // elements
        protected var _slider:Slider;
        protected var up_arrow:SimpleButton;
        protected var down_arrow:SimpleButton;
        private var scrollTimer:Timer;
        private var _direction:int;
        private var _stage:DisplayObject; //Needed to catch the events of the slider
        
        private var _sliderMC:Sprite;
        private var _slider_bgMC:Sprite;
        private var _btn_up:SimpleButton;
        private var _btn_down:SimpleButton;
       
        protected var _scrollSpeed:Number = .05;
       
        // read/write percentage value relates directly to the slider
        public function get percent():Number { return _slider.percent; }
        public function set percent( p:Number ):void { _slider.percent = p; }
        
        public function get upArrow():SimpleButton {return up_arrow; }
        public function get downArrow():SimpleButton {return down_arrow; }
        
        public function get slider():Sprite {return _slider; }
       
        /**
         * Constructor
         */
        public function Scrollbar(stage:DisplayObject, slider:Sprite, slider_bg:Sprite, up:SimpleButton, down:SimpleButton)
        //public function Scrollbar()
        {
        	_stage = stage;
        	
        	_sliderMC = slider;
			_slider_bgMC = slider_bg;
			_btn_up = up;
			_btn_down = down;
        
        	_direction = 0;
        	scrollTimer = new Timer(100,1);
        	scrollTimer.addEventListener(TimerEvent.TIMER_COMPLETE, AutoArrowPressed);
				
            createElements(slider, slider_bg, up, down);
            //createElements();
        }
       
       public function hide(b:Boolean):void
       {
       		_sliderMC.visible 		= b;
			_slider_bgMC.visible 	= b;
			_btn_up.visible 		= b;
			_btn_down.visible 		= b;
       }
       
       protected function AutoArrowPressed( e:TimerEvent ):void
        {
			if (_direction != 0){
	            _slider.percent += _direction * _scrollSpeed;
	            scrollTimer.reset();
	          	scrollTimer.start();
  			}
        }
        // executes when the up arrow is pressed
        protected function arrowPressed( e:MouseEvent ):void
        {
        	trace("Percentage "+_slider.percent);
            var dir:int = (e.target == up_arrow) ? -1 : 1;
            _direction = dir;
            _slider.percent += dir * _scrollSpeed;
            scrollTimer.reset();
          	scrollTimer.start();
        }
        
        private function bgPressed(e:MouseEvent):void
	    {
	    	var percent:Number 	= YMath.getValueForInterval(0, e.currentTarget.height, 0, 1, e.localY);
	    	_slider.percent 	= percent;
	    }
       
       	protected function stopScroll(e:MouseEvent):void
       	{
       		scrollTimer.stop();
       		_direction = 0;
       	}
        /**
         * Create and initialize the slider and arrow elements.
         */
        protected function createElements(s:Sprite, s_bg:Sprite, up:SimpleButton, down:SimpleButton):void
        {
        	//var bg_y:Number = s_bg.y;
            _slider = new Slider(_stage ,s, s_bg);
            
            up_arrow = up //new Sprite();
            down_arrow = down //new Sprite();
           
            //_slider.y = bg_y;
           
            up_arrow.addEventListener( 	 MouseEvent.MOUSE_DOWN, arrowPressed );
            down_arrow.addEventListener( MouseEvent.MOUSE_DOWN, arrowPressed );
            
            up_arrow.addEventListener( 	 MouseEvent.MOUSE_UP, stopScroll );
            down_arrow.addEventListener( MouseEvent.MOUSE_UP, stopScroll );
            
            //Create event for the slider_bg
            s_bg.addEventListener(MouseEvent.CLICK, bgPressed);
           
            //this.addChild( slider );
           	//this.addChild( up_arrow );
            //this.addChild( down_arrow );
        }
       
        /**
         * Override the add and remove event listeners, so that SliderEvent.CHANGE events will be
         * subscribed to the Slider directly.
         *
         * There is issues with this however, Event.CHANGE events will get subscribed directly too Slider as well.
         */
        public override function addEventListener( type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false ):void
        {
            if ( type === SliderEvent.CHANGE )
            {
                slider.addEventListener( SliderEvent.CHANGE, listener, useCapture, priority, useWeakReference );
                return;
            }
            super.addEventListener( type, listener, useCapture, priority, useWeakReference );
        }
        public override function removeEventListener( type:String, listener:Function, useCapture:Boolean=false ):void
        {
            if ( type === SliderEvent.CHANGE )
            {
                slider.removeEventListener( SliderEvent.CHANGE, listener, useCapture );
                return;
            }
            super.removeEventListener( type, listener, useCapture );
        }
        
        public function set scrollspeed(value:Number):void{
        	this._scrollSpeed = value;
        }
    }
}