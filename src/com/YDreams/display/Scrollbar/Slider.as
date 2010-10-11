package com.YDreams.display.Scrollbar
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;

    /**
     * Represents the base functionality for Sliders.
     *
     * Broadcasts 1 event:
     * -SliderEvent.CHANGE
     */
    public class Slider extends Sprite
    {
        // elements
        protected var track:Sprite;
        protected var marker:Sprite;
        private var markerOffset:Number;
        private var _stage:DisplayObject;
       
        // percentage
        protected var percentage:Number = 0;
        /**
         * The percent is represented as a value between 0 and 1.
         */
        public function get percent():Number { return percentage; }
        /**
         * The percent is represented as a value between 0 and 1.
         */
        public function set percent( p:Number ):void
        {
            percentage = Math.min( 1, Math.max( 0, p ) );
           	marker.y = percentage * (track.height - marker.height) + markerOffset;
                       
            dispatchEvent( new SliderEvent( SliderEvent.CHANGE, percentage ) );
        }
       
        /**
         * Constructor
         */
        public function Slider(p:DisplayObject, s:Sprite, s_bg:Sprite)
        {
        	_stage = p;
            createElements(s,s_bg);
        }
       
        // ends the sliding session
        protected function stopSliding( e:MouseEvent ):void
        {
            marker.stopDrag();
            _stage.removeEventListener( MouseEvent.MOUSE_MOVE, updatePercent );
            _stage.removeEventListener( MouseEvent.MOUSE_UP, stopSliding );
        }       
        // updates the data to reflect the visuals
        protected function updatePercent( e:MouseEvent ):void
        {
            e.updateAfterEvent();
            percentage = (marker.y - markerOffset) / (track.height - marker.height);
            dispatchEvent( new SliderEvent( SliderEvent.CHANGE, percentage ) );
        }
               
        //  Executed when the marker is pressed by the user.
        protected function markerPress( e:MouseEvent ):void
        {
            marker.startDrag( false, new Rectangle( marker.x, markerOffset, 0, track.height - marker.height  ) );
            _stage.addEventListener( MouseEvent.MOUSE_MOVE, updatePercent );
            _stage.addEventListener( MouseEvent.MOUSE_UP, stopSliding );
        }
       
        /**
         * Creates and initializes the marker/track elements.
         */
        protected function createElements(s:Sprite, s_bg:Sprite):void
        {
            track = s_bg//new Sprite();//slider_bg;
            marker = s//new Sprite(); //slider;//

            markerOffset = marker.y;
            marker.addEventListener( MouseEvent.MOUSE_DOWN, markerPress );
        }
    }
}