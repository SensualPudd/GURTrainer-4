package _4_0.punk
{
   import _4_0.FP;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import _4_0.punk.core.Spritemap;
   
   public class Acrobat extends Actor
   {
       
      
      private var _img:int;
      
      private var _flipX:Boolean;
      
      public var scaleX:Number = 1;
      
      public var scaleY:Number = 1;
      
      public var angle:Number = 0;
      
      private var _flipY:Boolean;
      
      public var center:Boolean = false;
      
      private var _buffer:BitmapData;
      
      public var color:uint = 0;
      
      private var _color:ColorTransform;
      
      public var alpha:Number = 1;
      
      private const _DEG:Number = -Math.PI / 180;
      
      private var _update:Boolean = true;
      
      private var _alpha:Number;
      
      private var _bufferRect:Rectangle;
      
      public function Acrobat()
      {
         this._color = new ColorTransform();
         super();
      }
      
      override public function get sprite() : Spritemap
      {
         return _sprite;
      }
      
      override public function set sprite(value:Spritemap) : void
      {
         super.sprite = value;
         if(!this._buffer || _sprite.imageW > this._buffer.width || _sprite.imageH > this._buffer.height)
         {
            this._buffer = new BitmapData(_sprite.imageW,_sprite.imageH,true,0);
            this._bufferRect = this._buffer.rect;
         }
         else
         {
            this._buffer.fillRect(this._buffer.rect,0);
         }
         this._update = true;
      }
      
      override public function render() : void
      {
         if(!_sprite)
         {
            return;
         }
         if(this._update || _image !== this._img || flipX !== this._flipX || flipY !== this._flipY || this.alpha !== this._alpha)
         {
            _rect.x = !!flipX?Number(_sprite.imageR - _image * _sprite.imageW):Number(_image * _sprite.imageW);
            _rect.y = !!flipY?Number(_sprite.imageB):Number(0);
            this._update = false;
            this._img = _image;
            this._flipX = flipX;
            this._flipY = flipY;
            this._alpha = this._color.alphaMultiplier = this.alpha;
            this._buffer.copyPixels(_sprite,_rect,_zero);
            if(this._alpha < 1 || this.color)
            {
               if(this.color)
               {
                  this._color.redMultiplier = this._color.greenMultiplier = this._color.blueMultiplier = 1;
                  this._color.redOffset = this._color.greenOffset = this._color.blueOffset = this._color.alphaOffset = 0;
                  this._color.color = this.color;
               }
               this._buffer.colorTransform(this._buffer.rect,this._color);
            }
         }
         if(this.angle == 0 && this.scaleX == 1 && this.scaleY == 1)
         {
            _point.x = x - _sprite.originX - _4_0.FP.camera.x;
            _point.y = y - _sprite.originY - _4_0.FP.camera.y;
            _4_0.FP.screen.copyPixels(this._buffer,this._bufferRect,_point);
            if(!delay)
            {
               return;
            }
            _count++;
            if(_count >= delay)
            {
               _count = 0;
               _image++;
               if(_image == _sprite.number)
               {
                  _image = !!loop?0:int(_image - 1);
               }
               else if(anim !== null && _image == _sprite.number - 1)
               {
                  anim();
               }
            }
            return;
         }
         _matrix.a = this.scaleX;
         _matrix.d = this.scaleY;
         _matrix.b = _matrix.c = 0;
         if(this.center)
         {
            _matrix.tx = -_sprite.imageCX * this.scaleX;
            _matrix.ty = -_sprite.imageCY * this.scaleY;
            if(this.angle != 0)
            {
               _matrix.rotate(this.angle * this._DEG);
            }
            _matrix.tx = _matrix.tx + (x - _4_0.FP.camera.x - _sprite.originX + _sprite.imageCX);
            _matrix.ty = _matrix.ty + (y - _4_0.FP.camera.y - _sprite.originY + _sprite.imageCY);
         }
         else
         {
            _matrix.tx = -_sprite.originX * this.scaleX;
            _matrix.ty = -_sprite.originY * this.scaleY;
            if(this.angle != 0)
            {
               _matrix.rotate(this.angle * this._DEG);
            }
            _matrix.tx = _matrix.tx + (x - _4_0.FP.camera.x);
            _matrix.ty = _matrix.ty + (y - _4_0.FP.camera.y);
         }
         _4_0.FP.screen.draw(this._buffer,_matrix);
         if(!delay)
         {
            return;
         }
         _count++;
         if(_count >= delay)
         {
            _count = 0;
            _image++;
            if(_image == _sprite.number)
            {
               _image = !!loop?0:int(_image - 1);
            }
            else if(anim !== null && _image == _sprite.number - 1)
            {
               anim();
            }
         }
      }
   }
}
