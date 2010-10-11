// $Id$ //
package com.YDreams.utils
{	
	public class ObjectUtils
	{
		/**
		 * The ObjectUtils class is an all-static class with methods for
		 * working with Objects. You do not create instances of ObjectUtils;
		 * instead you simply call static methods such as the method
		 * ObjectUtils.findChildByName().
		 */		
		public function ObjectUtils():void
		{
			// nothing	
		}
		
		/**
		 * Para facilmente encontrar um determinado objecto dentro de outro.
		 * @param obj - O objecto onde se vai procurar.
		 * @param name - O objecto que se vai procurar.
		 * @return 
		 * 
		 * Example usage:
		 * 		var t:TextField = ObjectYUtil.findChildByName(myMovie, "data1_t") as TextField; 
		 */		
		public static function findChildByName(obj:Object, name:String):Object
	    {
	    	/* se conseguir fazer pelo getChildByName faz */
	        if (obj.getChildByName(name))
	            return obj.getChildByName(name);
	            
	        if (obj.numChildren == 0)
	            return null;
	            
	        for (var i:int = 0 ; i < obj.numChildren ; i++)
	        {
	            try
	            {
	            	var o:* = obj.getChildAt(i);
	            	var n:int = o.numChildren;
	                
	                if (n > 0)
	                {
	                    var obj_in:* = findChildByName(o, name);
		                if (obj_in)
	    	                return obj_in;
	        	    }
	            }
	            catch (e:Error)
	            {
	                return null;
	            }	               
	        }
	        
	        return null;
	    }
	    
	    public static function copyProperties(fromObj:Object, toObj:Object):Object
	    {
	    	try
	    	{
	    		for (var propName:String in fromObj)
	    		{
	    			if (toObj[propName]!=undefined)
	    			{
	    				toObj[propName] = fromObj[propName];
	    			}
	    		}
	    	}
	    	catch (e:Error)
	    	{
	    		
	    	}
	    	
	    	return toObj;
	    }
	}
}