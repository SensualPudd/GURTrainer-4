
package _4_0.punk.core
{
   import _4_0.FP;
   import flash.display.Graphics;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Core
   {
       
      
      private var _rect:Rectangle;
      
      public var active:Boolean = true;
      
      public var alarmLast:Alarm;
      
      private var _point:Point;
      
      private var _graphics:Graphics;
      
      private var _sprite:Sprite;
      
      public var visible:Boolean = true;
      
      var _alarmFirst:Alarm;
      
      public function Core()
      {
         this._point = _4_0.FP.point;
         this._rect = _4_0.FP.rect;
         this._sprite = _4_0.FP.sprite;
         this._graphics = _4_0.FP.sprite.graphics;
         super();
      }
      
      public function drawRect(x:int, y:int, w:int, h:int, color:uint = 0, alpha:Number = 1) : void
      {
         if(alpha >= 1)
         {
            this._rect.x = x - _4_0.FP.camera.x;
            this._rect.y = y - _4_0.FP.camera.y;
            this._rect.width = w;
            this._rect.height = h;
            _4_0.FP.screen.fillRect(this._rect,color);
            return;
         }
         this._graphics.clear();
         this._graphics.beginFill(color,alpha);
         this._graphics.drawRect(x - _4_0.FP.camera.x,y - _4_0.FP.camera.y,w,h);
         this._graphics.endFill();
         _4_0.FP.screen.draw(this._sprite);
      }
      
      public function update() : void
      {
         if(this._alarmFirst)
         {
            this._alarmFirst.update();
         }
      }
      
      public function drawLinePlus(x1:int, y1:int, x2:int, y2:int, color:uint = 4.27819008E9, alpha:Number = 1, thick:Number = 1) : void
      {
         this._graphics.clear();
         this._graphics.lineStyle(thick,color,alpha,false,LineScaleMode.NONE);
         this._graphics.moveTo(x1 - _4_0.FP.camera.x,y1 - _4_0.FP.camera.y);
         this._graphics.lineTo(x2 - _4_0.FP.camera.x,y2 - _4_0.FP.camera.y);
         _4_0.FP.screen.draw(this._sprite);
      }
      
      public function render() : void
      {
      }
      
      public function drawLine(x1:int, y1:int, x2:int, y2:int, color:uint = 0) : void
      {
         var xx:int = 0;
         var yy:int = 0;
         var slope:Number = NaN;
         x1 = x1 - _4_0.FP.camera.x;
         y1 = y1 - _4_0.FP.camera.y;
         x2 = x2 - _4_0.FP.camera.x;
         y2 = y2 - _4_0.FP.camera.y;
         var screen:Screen = _4_0.FP.screen;
         var X:Number = Math.abs(x2 - x1);
         var Y:Number = Math.abs(y2 - y1);
         if(X == 0)
         {
            if(Y == 0)
            {
               screen.setPixel(x1,y1,color);
               return;
            }
            yy = y2 > y1?1:-1;
            while(y1 != y2)
            {
               screen.setPixel(x1,y1,color);
               y1 = y1 + yy;
            }
            screen.setPixel(x2,y2,color);
            return;
         }
         if(Y == 0)
         {
            xx = x2 > x1?1:-1;
            while(x1 != x2)
            {
               screen.setPixel(x1,y1,color);
               x1 = x1 + xx;
            }
            screen.setPixel(x2,y2,color);
            return;
         }
         xx = x2 > x1?1:-1;
         yy = y2 > y1?1:-1;
         var c:Number = 0;
         if(X > Y)
         {
            slope = Y / X;
            c = 0.5;
            while(x1 != x2)
            {
               screen.setPixel(x1,y1,color);
               x1 = x1 + xx;
               c = c + slope;
               if(c >= 1)
               {
                  y1 = y1 + yy;
                  c--;
               }
            }
            screen.setPixel(x2,y2,color);
            return;
         }
         slope = X / Y;
         c = 0.5;
         while(y1 != y2)
         {
            screen.setPixel(x1,y1,color);
            y1 = y1 + yy;
            c = c + slope;
            if(c >= 1)
            {
               x1 = x1 + xx;
               c--;
            }
         }
         screen.setPixel(x2,y2,color);
      }
      
      public function removeAllAlarms() : void
      {
         var a:Alarm = null;
         while(this._alarmFirst)
         {
            this._alarmFirst._prev = null;
            a = this._alarmFirst;
            this._alarmFirst = a._next;
            a._next = null;
            a._added = false;
         }
      }
      
      public function drawSprite(sprite:Spritemap, image:int = 0, x:int = 0, y:int = 0, flipX:Boolean = false, flipY:Boolean = false) : void
      {
         this._rect.x = !!flipX?Number(sprite.imageR - image * sprite.imageW):Number(image * sprite.imageW);
         this._rect.y = !!flipY?Number(sprite.imageB):Number(0);
         this._rect.width = sprite.imageW;
         this._rect.height = sprite.imageH;
         this._point.x = x - _4_0.FP.camera.x - sprite.originX;
         this._point.y = y - _4_0.FP.camera.y - sprite.originY;
         _4_0.FP.screen.copyPixels(sprite,this._rect,this._point);
      }
      
      public function removeAlarm(alarm:Alarm) : Alarm
      {
         if(!alarm._added)
         {
            return alarm;
         }
         if(alarm._prev)
         {
            alarm._prev._next = alarm._next;
         }
         if(alarm._next)
         {
            alarm._next._prev = alarm._prev;
         }
         if(this._alarmFirst == alarm)
         {
            this._alarmFirst = alarm._next;
         }
         alarm._next = alarm._prev = null;
         alarm._entity = null;
         alarm._added = false;
         return alarm;
      }
      
      public function addAlarm(alarm:Alarm, start:Boolean = true) : Alarm
      {
         if(alarm._added)
         {
            return alarm;
         }
         if(this._alarmFirst)
         {
            this._alarmFirst._prev = alarm;
         }
         alarm._next = this._alarmFirst;
         alarm._added = true;
         alarm._entity = this;
         this._alarmFirst = alarm;
         if(start)
         {
            alarm.start();
         }
         return alarm;
      }
      
      public function drawCircle(x:int, y:int, radius:Number, color:uint = 0, alpha:Number = 1) : void
      {
         this._graphics.clear();
         this._graphics.beginFill(color,alpha);
         this._graphics.drawCircle(x - _4_0.FP.camera.x,y - _4_0.FP.camera.y,radius);
         this._graphics.endFill();
         _4_0.FP.screen.draw(this._sprite);
      }
   }
}
