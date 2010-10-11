package com.YDreams.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Matrix;

 	/**
    * <img src = "http://programming.ydreams.com/Images/YDreams.jpg" /> 
    * 
	* <p><strong>About</strong><br /><br />
	* This class extends Sprite in order to add some common methods.
	* 
	* <p><strong>Usage</strong><br /><br />
	* Use YSprite instead of Sprite to use extra methods implemented for most common YDreams applications.
	*
	* @example <listing version="3.0">
	* var img:YSprite = new YSprite();
	* img.alpha = 0.5;
	* addChild(img); 
	* </listing>
	* 
	*/
	
	public class YSprite extends Sprite
	{
		private var _regPoint:YPoint;
		private var _point:Point;
		
		public function YSprite()
		{
			super();
			_regPoint = new YPoint(this);
		}
		
		
		/**
		 * Flips vertical
		 * 
		 */
		public function flipVertical():void
		{
			var matrix:Matrix = this.transform.matrix;
			matrix.a=-1;
			matrix.tx=this.width+this.x;
			this.transform.matrix=matrix;
		}
		

		/**
		 * 
		 * @param s: Scale size for both X and Y
		 * 
		 */		
		public function set scale (s : Number):void
		{
			this.scaleX = this.scaleY = s;
		}
		
		/**
		* Resize a movieClip evenly
		* type -> can be width or height
		* newVal -> new value for given type
		*/
		public function resizeEvenly (type : String, newVal : Number):void
		{
			var oldWidth : Number;
			if (type.toUpperCase () == 'WIDTH')
			{
				oldWidth = this.width;
				this.width = newVal;
				this.height = this.height * this.width / oldWidth;
			} 
			else if (type.toUpperCase () == 'HEIGHT')
			{
				oldWidth = this.height;
				this.height = newVal;
				this.width = this.width * this.height / oldWidth;
			}
		}
		
		/**
		* Resize a movieClip evenly considering the bigger side
		* newWidth -> new width to be resized
		* newHeight -> new height to be resized
		*/
		public function resizeByBigger(newWidth : Number, newHeight : Number):void
		{
			if (this.width/newWidth >= this.height/newHeight)
				resizeEvenly( 'WIDTH', newWidth);
			else
				resizeEvenly( 'HEIGHT', newHeight);
			
		}
		/**
		 * Sets the sprite on top
		 * 
		 */
		public function setIndexTopmost():void
		{
			var myparent:Sprite = this.parent as Sprite;
			if (myparent!=null)
				myparent.swapChildrenAt(myparent.getChildIndex(this),myparent.numChildren-1);
		}
		
		/**
		 * Changes the registration point (rotation center) from position 1 to 9 according 
		 * to the following representation:
		 * 1 2 3
		 * 4 5 6
		 * 7 8 9
		 * 
		 * @param rp
		 * 
		 */
		public function setRegistration(rp:Number):void
		{
			this._regPoint.setRegistration(rp);
		}

		/**
		 * Changes the registation point (local coordinates)
		 * @param x - coordinate on x axle
		 * @param y - coordinate on y axle
		 * 
		 */
		public function setRegistrationPoint(x:Number=0, y:Number=0):void
		{
			this._regPoint.setRegistrationPoint(x, y);
			this._point = new Point(x,y);
		}

		/**
		 * 
		 * @return x registration coordinate
		 * 
		 */
		public function get X():Number
		{
			return this._regPoint.getX();
		}

		/**
		 * Changes the x coordinate
		 * @param value - new x registration coordenate
		 * 
		 */
		public function set X(value:Number):void
		{
			this.x += value - this._regPoint.getX();
		}

		/**
		 * 
		 * @return y registration coordinate
		 * 
		 */
		public function get Y():Number
		{
			return this._regPoint.getY();
		}

		/**
		 * Changes the y coordinate
		 * @param value - new y registration coordenate
		 * 
		 */
		public function set Y(value:Number):void
		{
			this.y += value - this._regPoint.getY();
		}

		/**
		 * 
		 * @return scale size on the x axle
		 * 
		 */
		public function get ScaleX():Number
		{
			return this.scaleX;
		}

		/**
		 * Changes scale size centered on registration point
		 * @param value new scale size
		 * 
		 */
		public function set ScaleX(value:Number):void
		{
			this.setProperty("scaleX", value);
		}

		/**
		 * 
		 * @return scale size on the y axle
		 * 
		 */
		public function get ScaleY():Number
		{
			return this.scaleY;
		}

		/**
		 * Changes scale size centered on registration point
		 * @param value new scale size
		 * 
		 */
		public function set ScaleY(value:Number):void
		{
			this.setProperty("scaleY", value);
		}
		
		/**
		 * Return the rotation angle
		 * @return angle
		 * 
		 */
		public function get Rotation():Number
		{
			return this.rotation;
		}
		
		/**
		 * Chanegs the rotation angle centered on registration point
		 * @param value - new angle
		 * 
		 */
		public function set Rotation(value:Number):void
		{
			this.setProperty("rotation", value);
		}

		/**
		 * 
		 * @return Local Mouse position on x axle related with registration point
		 * 
		 */
		public function get MouseX():Number
		{
			return Math.round(this.mouseX - _regPoint.x);
		}

		/**
		 * 
		 * @return Local Mouse position on y axle related with registration point
		 * 
		 */
		public function get MouseY():Number
		{
			return Math.round(this.mouseY - _regPoint.y);
		}

		/**
		 * Changes a property of the object and adjust it's position according to it's registration point
		 * @param prop - property name to be changed
		 * @param n - new value
		 * 
		 */
		private function setProperty(prop:String, n:Number):void
		{
			var myParent:DisplayObject = this.parent;
			if (myParent==null)
				myParent=this;

			var x1:Number = this.X;
			var y1:Number = this.Y;
			this[prop] = n;

			var x2:Number = this.X;
			var y2:Number = this.Y;
			//this.X = x1;
			//this.Y = y1;
			//trace(x1+"->"+this.X+","+y1+"->"+this.Y);
			this.x -= x2 - x1;
			this.y -= y2 - y1;
		}
	}
}

