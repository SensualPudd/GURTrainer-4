package _4_0.punk.core
{
   import _4_0.FP;
   import flash.geom.Point;
   import _4_0.punk.util.Input;
   
   public class Camera
   {
       
      
      public var originX:Number = 0;
      
      protected var _height:int;
      
      protected var _width:int;
      
      private var _point:Point;
      
      protected var _maxX:int = 2.147483647E9;
      
      protected var _maxY:int = 2.147483647E9;
      
      protected var _minX:int = -2.147483648E9;
      
      protected var _minY:int = -2.147483648E9;
      
      public var originY:Number = 0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public function Camera()
      {
         this._width = _4_0.FP.screen.width;
         this._height = _4_0.FP.screen.height;
         this._point = _4_0.FP.point;
         super();
      }
      
      public function collideRect(x:int, y:int, width:int, height:int) : Boolean
      {
         return x + this._width > this.x && y + this._height > this.y && x < this.x + this._width && y < this.y + this._height;
      }
      
      public function get mouseX() : Number
      {
         return Input.mouseX;
      }
      
      public function get mouseY() : Number
      {
         return Input.mouseY;
      }
      
      public function clampInBounds() : void
      {
         if(this.x < this._minX)
         {
            this.x = this._minX;
         }
         if(this.y < this._minY)
         {
            this.y = this._minY;
         }
         if(this.x > this._maxX)
         {
            this.x = this._maxX;
         }
         if(this.y > this._maxY)
         {
            this.y = this._maxY;
         }
      }
      
      public function centerOrigin() : void
      {
         this.x = this.x + (this.originX - this._width / 2);
         this.y = this.y + (this.originY - this._height / 2);
         this.originX = this._width / 2;
         this.originY = this._height / 2;
         this.clampInBounds();
      }
      
      public function setOrigin(originX:Number = 0, originY:Number = 0) : void
      {
         this.x = this.x + (this.originX - originX);
         this.y = this.y + (this.originY - originY);
         this.originX = originX;
         this.originY = originY;
         this.clampInBounds();
      }
      
      public function moveTo(x:Number = 0, y:Number = 0) : void
      {
         this.x = x - this.originX;
         this.y = y - this.originY;
         this.clampInBounds();
      }
      
      public function collidePoint(x:int, y:int) : Boolean
      {
         return x >= this.x && y >= this.y && x < this.x + this._width && y < this.y + this._width;
      }
      
      public function stepTowards(x:Number, y:Number, speed:Number) : void
      {
         this._point.x = x - this.originX - this.x;
         this._point.y = y - this.originY - this.y;
         if(this._point.length < speed)
         {
            this.x = x - this.originX;
            this.y = y - this.originY;
            this.clampInBounds();
            return;
         }
         this._point.normalize(speed);
         this.x = this.x + this._point.x;
         this.y = this.y + this._point.y;
         this.clampInBounds();
      }
      
      public function setBounds(left:int, top:int, right:int, bottom:int) : void
      {
         this._minX = left;
         this._minY = top;
         this._maxX = right - this._width;
         this._maxY = bottom - this._height;
         this.clampInBounds();
      }
   }
}
