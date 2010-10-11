package com.YDreams.display
{
	import flash.display.Sprite ;
	import flash.geom.ColorTransform;
	  
    public class YColor {
			
		public static function setRGB(mc:Sprite,col:uint):void
		{
        	var color:ColorTransform=new ColorTransform() ;
            color.color=col ;
            mc.transform.colorTransform=color ;
        }
		
        public static function getRGB(mc:Sprite):uint
		{
        	return mc.transform.colorTransform.color ;
        }
		
        public static function getRGBstr(mc:Sprite):String
		{
            var hexStr:String=mc.transform.colorTransform.color.toString(16);
            //trace("hex ="+hexStr);
            var toFill:int =6-hexStr.length ;
            while(toFill--){ hexStr="0"+hexStr; }
            hexStr="0x"+hexStr ;
            return hexStr ;
        }
                //        r= -255 ~ 255 .
        public static function setRGB2(mc:Sprite,r:uint,g:uint,b:uint):void 
		{
        	var c:uint= (r << 16 | g << 8 | b ) ;
            setRGB(mc,c);
        }
		
        public static function getRGB2(mc:Sprite):Object 
		{
        	var c:ColorTransform= mc.transform.colorTransform ;
            return { r:c.redOffset,g:c.greenOffset,b:c.blueOffset } ;
        }
		
        public static function reset(mc:Sprite ):void 
		{
        	mc.transform.colorTransform= new ColorTransform();
        }
		
        public static function setBrightness(mc:Sprite,bright:uint):void
		{
        	var trans:ColorTransform=mc.transform.colorTransform ;
            with(trans)
			{
            	redMultiplier=greenMultiplier=blueMultiplier=(100-Math.abs(bright))/100 ;
                redOffset=greenOffset=blueOffset=(bright > 0 ) ? bright*(256/100) : 0 ;
            }
            mc.transform.colorTransform=trans ;
                        }
                //offset = -255~ 255 .
		public static function setBrightOffset(mc:Sprite,offset:uint):void
		{
        	var trans:ColorTransform=mc.transform.colorTransform ;
            with(trans){
            	redOffset=greenOffset=blueOffset=offset ;
            }
            mc.transform.colorTransform=trans ;
        }
		
        public static function setTint(mc:Sprite,r:uint,g:uint,b:uint,percent:uint):void
		{
        	var per:Number=percent/100 ;
            var trans:ColorTransform=mc.transform.colorTransform ;
            with(trans){
            	redOffset   = per*redOffset ;
                greenOffset = per*greenOffset ;
                blueOffset  = per*blueOffset ;
                redMultiplier=greenMultiplier=blueMultiplier=(100-percent)/100 ;
            }
            mc.transform.colorTransform=trans ;
        }
		
        public static function getTint(mc:Sprite):Object 
		{
        	var trans:ColorTransform=mc.transform.colorTransform ;
            var tint:Object=new Object() ;
            tint.percent=(1-trans.redMultiplier )*100;
            var per:Number=100/tint.percent ;
            tint.r       = Math.round(per*trans.redOffset) ;
            tint.g       = Math.round(per*trans.greenOffset) ;
            tint.b       = Math.round(per*trans.blueOffset) ;
            return tint ;
         }
		 
		 public static function setTintOffset(mc:Sprite,r:uint,g:uint,b:uint):void
		 {
			var trans:ColorTransform=mc.transform.colorTransform ;
            with(trans){
            	redOffset   = r ;
                greenOffset = g ;
                blueOffset  = b ;
            }
			mc.transform.colorTransform=trans ;
		}
		public static function getTintOffset(mc:Sprite):Object {
			var trans:ColorTransform=mc.transform.colorTransform ;
			var tint:Object=new Object() ;
			tint.rb       = trans.redOffset;
			tint.gb       = trans.greenOffset ;
			tint.bb       = trans.blueOffset ;
			return tint ;
		}
			
		public static function invert(mc:Sprite):void{
			var trans:ColorTransform=mc.transform.colorTransform ;
			with(trans){
					redMultiplier   = -redMultiplier ;
					greenMultiplier = -greenMultiplier ;
					blueMultiplier  = -blueMultiplier ;
					redOffset       = 255-redOffset ;
					greenOffset     = 255-greenOffset;
					blueOffset      = 255-blueOffset;
					}
			mc.transform.colorTransform=trans ;
		}
		
		//percent=0~100
		public static function setNegative(mc:Sprite,percent:Number):void
		{
			var trans:ColorTransform=mc.transform.colorTransform ;
			with(trans){
			redMultiplier   = greenMultiplier = blueMultiplier  =(100-2*percent)/100;
			redOffset       = greenOffset     = blueOffset      =percent*(255/100);
					}
			mc.transform.colorTransform=trans ;
		}
		
		public static function getNegative(mc:Sprite):Number{
			var trans:ColorTransform=mc.transform.colorTransform ;
			return trans.redOffset*(100/255) ;
		}
		
		public static function setRed(mc:Sprite,r:uint):void
		{
			var t:ColorTransform=mc.transform.colorTransform ;
			var c:uint= ( r << 16 | t.greenOffset << 8 | t.blueOffset );
			setRGB(mc,c);
		}
		
		public static function setGreen(mc:Sprite,r:uint):void
		{
			var t:ColorTransform=mc.transform.colorTransform ;
			var c:uint= ( t.redOffset << 16 | r << 8 | t.blueOffset );
			setRGB(mc,c);
		}
		
		public static function setBlue(mc:Sprite,r:uint):void{
			var t:ColorTransform=mc.transform.colorTransform ;
			var c:uint= ( t.redOffset << 16  | t.greenOffset << 8 | r );
			setRGB(mc,c);
		}
		
		public static function getRed(mc:Sprite):uint{
			return  mc.transform.colorTransform.redOffset;
		}
		
		public static function getGreen(mc:Sprite):uint{
			return  mc.transform.colorTransform.greenOffset;
		}
		
		public static function getBlue(mc:Sprite):uint{
			return  mc.transform.colorTransform.blueOffset;
		}
	}
}