package _4_0.punk
{
   import _4_0.FP;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import _4_0.punk.core.Entity;
   
   public class Backdrop extends Entity
   {
       
      
      private var _rect:Rectangle;
      
      private var _data:BitmapData;
      
      private var _scrollW:int;
      
      private var _scrollX:Number;
      
      private var _scrollY:Number;
      
      private var _repeatY:Boolean;
      
      private var _point:Point;
      
      private var _scrollH:int;
      
      private var _repeatX:Boolean;
      
      public function Backdrop(bitmap:Class, scrollX:Number = 0, scrollY:Number = 0, repeatX:Boolean = true, repeatY:Boolean = true)
      {
         this._point = _4_0.FP.point;
         super();
         var data:BitmapData = _4_0.FP.getBitmapData(bitmap);
         var w:int = data.width;
         var h:int = data.height;
         if(repeatX)
         {
            w = w + _4_0.FP.screen.width;
         }
         if(repeatY)
         {
            h = h + _4_0.FP.screen.height;
         }
         this._data = new BitmapData(w,h);
         this._rect = data.rect;
         this._scrollW = data.width;
         this._scrollH = data.height;
         this._repeatX = repeatX;
         this._repeatY = repeatY;
         this._point.x = this._point.y = 0;
         while(this._point.y < this._data.height + data.height)
         {
            while(this._point.x < this._data.width + data.width)
            {
               this._data.copyPixels(data,this._rect,this._point);
               this._point.x = this._point.x + data.width;
            }
            this._point.x = 0;
            this._point.y = this._point.y + data.height;
         }
         this._scrollX = 1 - scrollX;
         this._scrollY = 1 - scrollY;
         this._rect = this._data.rect;
         depth = 16777215;
      }
      
      override public function render() : void
      {
         if(!this._data)
         {
            return;
         }
         if(this._repeatX)
         {
            this._point.x = (x - _4_0.FP.camera.x * this._scrollX) % this._scrollW;
            if(this._point.x > 0)
            {
               this._point.x = this._point.x - this._scrollW;
            }
         }
         else
         {
            this._point.x = x - _4_0.FP.camera.x * this._scrollX;
         }
         if(this._repeatY)
         {
            this._point.y = (y - _4_0.FP.camera.y * this._scrollY) % this._scrollH;
            if(this._point.y > 0)
            {
               this._point.y = this._point.y - this._scrollH;
            }
         }
         else
         {
            this._point.y = y - _4_0.FP.camera.y * this._scrollY;
         }
         _4_0.FP.screen.copyPixels(this._data,this._rect,this._point);
      }
   }
}
