package com.YDreams.utils
{
   /* Original class from Ian Thomas
    * http://wildwinter.blogspot.com/2007/04/come-back-delegate-all-is-forgiven.html
    */
   
    public class YDelegate
    {
        // Create a wrapper for a callback function.
        // Tacks the additional args on to any args normally passed to the
        // callback.
        public static function create(handler:Function,...args):Function
        {
            return function(...innerArgs):void
            {
                handler.apply(this,innerArgs.concat(args));
            }
        }
    }
}