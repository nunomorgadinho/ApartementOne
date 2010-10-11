package com.YDreams.utils {

	/**
	* 	Generic Math functions
	*/

	public class YMath {
		
	
		/**
		* Returns a random number from a given range.
		* <p>An increment can optionally be specified</p>
		* 
		* @param min The lowest value from the random range
		* @param max The highest value from the random range
		* @param inc (Optional) will only return values multiples of the inc
		* 
		* @example <listing version="3.0">
		*
		* //Returns a number between 0 and 100 
		*   var n:int = YMath.rndRange(0,100); </listing>
		*/
		public static function rndRange(min:int,max:int,inc:int=1):int {
			var z:int = min + (Math.round (Math.random () * ((max - min) / inc)) * inc);
			return z;
		}
		/*
		* 
		* Function: getValueForInterval 
		* 
		* Converts a Number from an interval to another e.g ([20-40] [200-300]) 
		* 
		* If the input is 30, using that inveral we get 250;
		* 
		* Parameters:
		*  min1 - First Interval minimum value
		*  max1 - Fisrt Interval maximum value
		*  min2 - Second Interval minimum value
		*  max2 - Second Interval maximum value
		*  input - Value From the First Interval
		* 
		*/
		public static  function getValueForInterval(min1:Number,max1:Number,min2:Number,max2:Number,input:Number):Number
		{
			return min2+(input-min1)*(max2-min2)/(max1-min1);
		}
		/*
		* 
		* Function: convertToInterval 
		* 
		* Converts a percentage number (0-100) to a interval (p.e. [30-80])
		* 
		* Parameters:
		*  min - Interval minimum value
		*  max - Interval maximum value
		*  perc - Interval percentage
		*/
		public static  function convertToInterval(min:Number, max:Number, perc:Number):Number
		{
			var diff:Number = max - min;
			var factor:Number = diff/100;
			return (perc*factor)+min;
		}
		
		
	}
	
	
}