package _4_0.punk.core
{
   import _4_0.FP;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Spritemap extends BitmapData
   {
       
      
      private var _rect:Rectangle;
      
      public var imageB:int;
      
      public var number:int;
      
      public var imageH:int;
      
      public var imageCX:int;
      
      public var imageCY:int;
      
      public var flippedX:Boolean;
      
      public var imageR:int;
      
      public var imageW:int;
      
      public var flippedY:Boolean;
      
      private var _zero:Point;
      
      public var originX:int;
      
      public var originY:int;
      
      public function Spritemap(width:int, height:int, imageWidth:int = 0, imageHeight:int = 0, imageNum:int = 1, originX:int = 0, originY:int = 0)
      {
         this._rect = _4_0.FP.rect;
         this._zero = _4_0.FP.zero;
         super(width,height,true,0);
         this.imageW = imageWidth > 0?int(imageWidth):int(width);
         this.imageH = imageHeight > 0?int(imageHeight):int(height);
         this.imageCX = this.imageW >> 1;
         this.imageCY = this.imageH >> 1;
         this.imageR = width;
         this.imageB = height;
         this.number = imageNum;
         this.originX = originX;
         this.originY = originY;
      }
      
      public function getRect(image:int = 0, flipX:Boolean = false, flipY:Boolean = false) : Rectangle
      {
         this._rect.x = !!flipX?Number(this.imageR - image * this.imageW):Number(image * this.imageW);
         this._rect.y = !!flipY?Number(this.imageB):Number(0);
         this._rect.width = this.imageW;
         this._rect.height = this.imageH;
         return this._rect;
      }
      
      public function getImage(image:int = 0, flipX:Boolean = false, flipY:Boolean = false) : BitmapData
      {
         var data:BitmapData = new BitmapData(this.imageW,this.imageH,true,0);
         image = image % this.number;
         this._rect.x = !!flipX?Number(this.imageR - image * this.imageW):Number(image * this.imageW);
         this._rect.y = !!flipY?Number(this.imageB):Number(0);
         this._rect.width = this.imageW;
         this._rect.height = this.imageH;
         data.copyPixels(this,this._rect,this._zero);
         return data;
      }
   }
}
