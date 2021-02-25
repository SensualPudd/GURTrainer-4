package _4_0.punk
{
   import _4_0.FP;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   public class Textplus extends Text
   {
       
      
      private var _matrix:Matrix;
      
      private var _color:ColorTransform;
      
      private var _update:Boolean = true;
      
      public var scaleX:Number = 1;
      
      public var scaleY:Number = 1;
      
      public var angle:Number = 0;
      
      private const _DEG:Number = -Math.PI / 180;
      
      public function Textplus(str:String = "", x:int = 0, y:int = 0)
      {
         this._matrix = _4_0.FP.matrix;
         this._color = new ColorTransform();
         super(str,x,y);
      }
      
      override public function prepare() : void
      {
         super.prepare();
         if(this._color.alphaMultiplier < 1)
         {
            this._color.alphaMultiplier = this.alpha;
            _data.colorTransform(_rect,this._color);
         }
      }
      
      override public function render() : void
      {
         if(this.angle == 0 && this.scaleX == 1 && this.scaleY == 1)
         {
            _point.x = x - originX - _4_0.FP.camera.x;
            _point.y = y - originY - _4_0.FP.camera.y;
            _4_0.FP.screen.copyPixels(_data,_rect,_point);
            return;
         }
         this._matrix.a = this.scaleX;
         this._matrix.d = this.scaleY;
         this._matrix.b = this._matrix.c = 0;
         this._matrix.tx = -originX * this.scaleX;
         this._matrix.ty = -originY * this.scaleY;
         if(this.angle != 0)
         {
            this._matrix.rotate(this.angle * this._DEG);
         }
         this._matrix.tx = this._matrix.tx + (x - _4_0.FP.camera.x);
         this._matrix.ty = this._matrix.ty + (y - _4_0.FP.camera.y);
         _4_0.FP.screen.draw(_data,this._matrix);
      }
      
      public function set alpha(value:Number) : void
      {
         this._color.alphaMultiplier = value;
         this.prepare();
      }
      
      public function get alpha() : Number
      {
         return this._color.alphaMultiplier;
      }
   }
}
