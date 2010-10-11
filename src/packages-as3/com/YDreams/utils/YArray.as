package com.YDreams.utils {

	/**
	* 	Generic Array functions
	*/

	public class YArray {
		
	
		/*
		* function: insertAt
		* 	Insert an element in a Array at a especified postion
		*   Rrturns and array with the new element
		* 
		* Parameters:
		* 	element - Element to insert
		*   at - Position to insert
		*   inputArr - Array
		* 
		*/
		public static function insertAt(element:Object,at:uint,inputArr:Array):Array
		{
			var resultArray:Array=new Array;
			resultArray=inputArr;
			resultArray.splice(at,0,element);
			return resultArray;
		}
		
		
		/*
     	*Function: shuffle
       	*Randomizes an array and returns it
		*/
		public static function shuffle (myArray : Array):Array
		{
		var i:int = myArray.length - 1;
		if (i) do
		{
			var tmp:int = myArray[i];
			var rndPos:int = Math.floor (Math.random () * (i + 1));
			myArray[i] = myArray[rndPos];
			myArray[rndPos] = tmp;
			
		} while ( -- i);
		return myArray;
		}
		
		
		/*
		* function: removeAt
		* 	Remove an element in a Array at a especified postion
		*   Returns and array with the removed element
		* 
		* Parameters:
		*   myArray - Array
		*   at - Position to remove
		* 
		*/
		public static function removeAt(myArray : Array, at:int):Array
		{
			myArray[at] = myArray[myArray.length-1];
			myArray.pop();
			return myArray;
		}
		
		
	}
	
	
}