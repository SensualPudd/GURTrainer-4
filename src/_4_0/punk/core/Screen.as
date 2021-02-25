package _4_0.punk.core
{
   import _4_0.FP;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Stage;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import _4_0.punk.util.Input;
   
   public class Screen extends BitmapData
   {
       
      
      public var color:uint = 2105376;
      
      private var _color:ColorTransform;
      
      private var _zero:Point;
      
      var _rect:Rectangle;
      
      private var _point:Point;
      
      public var scale:Number = 1;
      
      private var _stage:Stage;
      
      public function Screen(width:int, height:int, color:uint = 2105376, scale:int = 1)
      {
         this._rect = _4_0.FP.rect;
         this._point = _4_0.FP.point;
         this._stage = _4_0.FP.stage;
         this._color = _4_0.FP.color;
         this._zero = _4_0.FP.zero;
         super(width,height,false,color);
         this.color = color;
         this.scale = scale;
      }
      
      public function drawClear(color:uint = 0, alpha:Number = 1) : void
      {
         if(alpha >= 1)
         {
            fillRect(this._rect,color);
            return;
         }
         var g:Graphics = _4_0.FP.sprite.graphics;
         g.clear();
         g.beginFill(color,alpha);
         g.drawRect(0,0,width,height);
         g.endFill();
         draw(_4_0.FP.sprite);
      }
      
      public function get mouseX() : Number
      {
         return Input.mouseX;
      }
      
      public function get mouseY() : Number
      {
         return Input.mouseY;
      }
   }
}
