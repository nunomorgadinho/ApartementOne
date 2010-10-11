package com.YDreams.display
{
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
		
	public class YPoint
	{
			
	 /** Takes a movieClip and adjusts
	 *  the registration point to any of the 9 available points.
	 * Attributes:
	 * child - MovieClip contained by container.  reg point refers to which part of child appears at 0,0 of container
	 * container - clip containing movieClip.  Registration point of mc is relative to clip, often use <b>this</b>
	 * rp - new Registration point number
	 * in the form of 
	 * 1 2 3
	 * 4 5 6
	 * 7 8 9
	 */
	 
		private var _point:Point;
		private var _child:DisplayObject;
		
		public function YPoint(child:DisplayObject)
		{
			this._child = child;
			this._point = new Point(0,0);
			
			createCross();
		}
		
		private function createCross():void
		{
			var grPoint:Sprite = new Sprite();
			grPoint.graphics.lineStyle(2, 0, 1);
			grPoint.graphics.moveTo(this._point.x-2,this._point.y);
			grPoint.graphics.lineTo(this._point.x+2,this._point.y);
			grPoint.graphics.moveTo(this._point.x,this._point.y-2);
			grPoint.graphics.lineTo(this._point.x,this._point.y+2);
			grPoint.name = "cross";
			grPoint.visible = false;
			(_child as Sprite).addChild(grPoint);
		}
			
		private function moveCross(x:Number, y:Number):void
		{
			var grPoint:Sprite = (this._child as  Sprite).getChildByName("cross") as Sprite;
			grPoint.x = x;
			grPoint.y = y;
		}
			
		public function setRegistration(rp:Number):void
		{
			var boundTest:Rectangle = _child.getRect(_child.parent);
			var placement:Object = getPlacement(rp);
			this.setX(boundTest,placement.horizontal);
			this.setY(boundTest,placement.vertical);
			moveCross(this.x, this.y);
			trace("center:"+this.x+","+ this.y);
		}
		 
		public function setRegistrationPoint(posx:Number,posy:Number):void
		{
			this._point = new Point(posx,posy);
			moveCross(posx, posy);
		}
		
		public function get x():Number
		{
			return this._point.x;
		}
		 
		public function set x(x:Number):void
		{
			this._point.x = x;// = new Point(x, this.y);
			moveCross(this.x, this.y);
		}
		 
		public function get y():Number
		{
			return this._point.y;
		}
		 
		public function set y(y:Number):void
		{
			this._point.y = y;// = new Point(this.x, y);
			moveCross(this.x, this.y);
		}
		 
		public function getX():Number
		{
			if (this._child.parent!=null)
			{
				var p:Point = this._child.parent.globalToLocal(this._child.localToGlobal(_point));
				return p.x;
			}
			else
				return this._child.x;
		}
	
		public function getY():Number
		{
			if (this._child.parent!=null)
			{
				var p:Point = this._child.parent.globalToLocal(this._child.localToGlobal(_point));
				
				return p.y;
			}
			else
				return this._child.y;
		}
	
		private function setX(b:Rectangle, region:String):void
		{
			trace(b.right+","+b.left+","+b.bottom+","+b.top);
			var posX:Number;
			if(region.toLowerCase() == "left"){
	   			posX = b.left;
			} else if (region.toLowerCase() == "center"){
	   			posX = (b.left - b.right)/2;
	  		} else if (region.toLowerCase() == "right"){
	   			posX = b.right;
	  		}
	  		this.x = posX-b.left;
	 	}
	 	
		private function setY(b:Rectangle, region:String):void
		{
			var posY:Number;
			if(region.toLowerCase() == "top"){
	   			posY = b.top;
	  		} else if (region.toLowerCase() == "center"){
	   			posY = (b.bottom - b.top)/2;
	  		} else if (region.toLowerCase() == "bottom"){
	   			posY = b.bottom;
	  		}
	  		this.y = posY-b.top;
	 	}
	 	
		private function getPlacement(regPoint:Number):Object
		{
			var aPlacement:Array = new Array();
			aPlacement[1] = {vertical:'top',horizontal:'left'};
			aPlacement[2] = {vertical:'top',horizontal:'center'};
			aPlacement[3] = {vertical:'top',horizontal:'right'};
			aPlacement[4] = {vertical:'center',horizontal:'left'};
			aPlacement[5] = {vertical:'center',horizontal:'center'};
			aPlacement[6] = {vertical:'center',horizontal:'right'};
			aPlacement[7] = {vertical:'bottom',horizontal:'left'};
			aPlacement[8] = {vertical:'bottom',horizontal:'center'};
			aPlacement[9] = {vertical:'bottom',horizontal:'right'};
			return aPlacement[regPoint];
	 	}
	}
}