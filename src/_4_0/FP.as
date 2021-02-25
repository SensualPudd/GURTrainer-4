package _4_0
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import _4_0.punk.core.*;

   public class FP
   {

      public static var stage:Stage;

      public static var soundVolume:Number = 1;

      private static var _musicCH:SoundChannel;

      private static var _sound:Vector.<Sound> = new Vector.<Sound>();

      public static var mute:Boolean = false;

      public static var volume:Number = 1;

      private static var _end:Function = null;

      public static var camera:Camera;

      private static var _music:Sound;

      private static var _soundID:Array = [];

      private static const _DEG:Number = -180 / Math.PI;

      private static var _musicTR:SoundTransform = new SoundTransform();

      private static const _RAD:Number = Math.PI / -180;

      public static var engine:Engine;

      private static var _paused:Boolean = false;

      private static var _bitmap:Array = [];

      private static var _seed:uint = 0;

      private static var _musicMute:Boolean = false;

      public static var _goto_:World;

      public static var color:ColorTransform = new ColorTransform();

      public static var screen:Screen;

      private static var _looping:Boolean = false;

      private static var _position:Number = 0;

      private static var _soundTR:SoundTransform = new SoundTransform();

      public static var world:World;

      public static var point2:Point = new Point();

      public static var zero:Point = new Point();

      public static const VERSION:String = "0.86";

      public static var matrix:Matrix = new Matrix();

      public static var sprite:Sprite = new Sprite();

      public static var point:Point = new Point();

      public static var soundMute:Boolean = false;

      private static var _id:int = 0;

      private static var _rotation:Array = [];

      private static var _getSeed:uint;

      public static var entity:Entity;

      public static var rect:Rectangle = new Rectangle();

      private static var _musicVolume:Number = 1;

      public static var fps:int;

      private static var _sprite:Array = [];

      private static var _playing:Boolean = false;


      public function FP()
      {
         super();
      }

      public static function choose(... objs) : *
      {
         return objs[int(objs.length * random)];
      }

      public static function distanceRects(x1:Number, y1:Number, w1:Number, h1:Number, x2:Number, y2:Number, w2:Number, h2:Number) : Number
      {
         if(x1 < x2 + w2 && x2 < x1 + w1)
         {
            if(y1 < y2 + h2 && y2 < y1 + h1)
            {
               return 0;
            }
            if(y1 > y2)
            {
               return y1 - (y2 + h2);
            }
            return y2 - (y1 + h1);
         }
         if(y1 < y2 + h2 && y2 < y1 + h1)
         {
            if(x1 > x2)
            {
               return x1 - (x2 + w2);
            }
            return x2 - (x1 + w1);
         }
         if(x1 > x2)
         {
            if(y1 > y2)
            {
               return distance(x1,y1,x2 + w2,y2 + h2);
            }
            return distance(x1,y1 + h1,x2 + w2,y2);
         }
         if(y1 > y2)
         {
            return distance(x1 + w1,y1,x2,y2 + h2);
         }
         return distance(x1 + w1,y1 + h1,x2,y2);
      }

      public static function rand(amount:uint) : uint
      {
         _seed = _seed * 16807 % 2147483647;
         return _seed / 2147483647 * amount;
      }

      public static function play(sound:Class, vol:Number = 1, pan:Number = 0) : void
      {
         if(mute || soundMute)
         {
            return;
         }
         var id:int = _soundID[String(sound)];
         if(!id)
         {
            _soundID[String(sound)] = id = _id;
            _sound[_id++] = new sound();
         }
         _soundTR.volume = vol * soundVolume * volume;
         _soundTR.pan = pan;
         _sound[id].play(0,0,_soundTR);
      }

      public static function set musicVolume(value:Number) : void
      {
         var mute:Number = !!_musicMute?Number(0):Number(1);
         _musicVolume = value < 0?Number(0):Number(value);
         _musicTR.volume = _musicVolume * mute;
         if(_musicCH)
         {
            _musicCH.soundTransform = _musicTR;
         }
      }

      public static function getGreen(color:uint) : uint
      {
         return color >> 8 & 255;
      }

      public static function scale(value:Number, min:Number, max:Number, min2:Number, max2:Number) : Number
      {
         return min2 + (value - min) / (max - min) * (max2 - min2);
      }

      public static function getRed(color:uint) : uint
      {
         return color >> 16 & 255;
      }

      public static function getBitmapData(bitmap:Class) : BitmapData
      {
         var arr:Array = _bitmap;
         if(arr[String(bitmap)])
         {
            return arr[String(bitmap)];
         }
         return arr[String(bitmap)] = new bitmap().bitmapData;
      }

      private static function musicEnd(e:Event) : void
      {
         if(_looping)
         {
            if(_musicCH.hasEventListener(Event.SOUND_COMPLETE))
            {
               _musicCH.removeEventListener(Event.SOUND_COMPLETE,musicEnd,false);
            }
            _musicCH = _music.play(0,999,_musicTR);
            _musicCH.addEventListener(Event.SOUND_COMPLETE,musicEnd,false,0,true);
         }
         else
         {
            _playing = false;
            _paused = false;
            _position = 0;
         }
         if(_end != null)
         {
            _end();
         }
      }

      public static function anglePoint(angle:Number, length:Number = 1) : Point
      {
         return new Point(Math.cos(angle * _RAD) * length,Math.sin(angle * _RAD) * length);
      }

      public static function scaleClamp(value:Number, min:Number, max:Number, min2:Number, max2:Number) : Number
      {
         value = min2 + (value - min) / (max - min) * (max2 - min2);
         if(max2 > min2)
         {
            value = value < max2?Number(value):Number(max2);
            return value > min2?Number(value):Number(min2);
         }
         value = value < min2?Number(value):Number(min2);
         return value > max2?Number(value):Number(max2);
      }

      public static function distanceRectPoint(px:Number, py:Number, rx:Number, ry:Number, rw:Number, rh:Number) : Number
      {
         if(px >= rx && px <= rx + rw)
         {
            if(py >= ry && py <= ry + rh)
            {
               return 0;
            }
            if(py > ry)
            {
               return py - (ry + rh);
            }
            return ry - py;
         }
         if(py >= ry && py <= ry + rh)
         {
            if(px > rx)
            {
               return px - (rx + rw);
            }
            return rx - px;
         }
         if(px > rx)
         {
            if(py > ry)
            {
               return distance(px,py,rx + rw,ry + rh);
            }
            return distance(px,py,rx + rw,ry);
         }
         if(py > ry)
         {
            return distance(px,py,rx,ry + rh);
         }
         return distance(px,py,rx,ry);
      }

      public static function get musicVolume() : Number
      {
         return _musicVolume;
      }

      public static function set randomSeed(value:uint) : void
      {
         _seed = clamp(value,1,2147483646);
         _getSeed = _seed;
      }

      public static function approach(value:Number, target:Number, amount:Number) : Number
      {
         return value < target?target < value + amount?Number(target):Number(value + amount):target > value - amount?Number(target):Number(value - amount);
      }

      public static function musicResume() : void
      {
         if(_paused)
         {
            _musicCH = _music.play(_position,!!_looping?999:0,_musicTR);
            _musicCH.addEventListener(Event.SOUND_COMPLETE,musicEnd,false,0,true);
            _playing = true;
            _paused = false;
         }
      }

      public static function clamp(value:Number, min:Number, max:Number) : Number
      {
         if(max > min)
         {
            value = value < max?Number(value):Number(max);
            return value > min?Number(value):Number(min);
         }
         value = value < min?Number(value):Number(min);
         return value > max?Number(value):Number(max);
      }

      public static function set musicMute(value:Boolean) : void
      {
         var mute:Number = !!value?Number(0):Number(1);
         _musicMute = value;
         _musicTR.volume = _musicVolume * mute;
         if(_playing)
         {
            _musicCH.soundTransform.volume = _musicVolume * mute;
         }
      }

      public static function sign(value:Number) : int
      {
         return value < 0?-1:value > 0?1:0;
      }

      public static function randomizeSeed() : void
      {
         randomSeed = 2147483647 * Math.random();
      }

      public static function get random() : Number
      {
         _seed = _seed * 16807 % 2147483647;
         return _seed / 2147483647;
      }

      public static function musicStop() : void
      {
         if(!_playing)
         {
            return;
         }
         if(_musicCH.hasEventListener(Event.SOUND_COMPLETE))
         {
            _musicCH.removeEventListener(Event.SOUND_COMPLETE,musicEnd,false);
         }
         _musicCH.stop();
         _playing = _paused = false;
      }

      public static function getSprite(bitmap:Class, imageW:int, imageH:int, flipX:Boolean = false, flipY:Boolean = false, originX:int = 0, originY:int = 0, useCache:Boolean = true) : Spritemap
      {
         var data:Spritemap = null;
         var temp:BitmapData = null;
         var fX:Boolean = false;
         var fY:Boolean = false;
         var spr:Spritemap = null;
         var w:int = 0;
         var h:int = 0;
         var arr:Array = _sprite;
         var pos:String = String(bitmap);
         if(useCache && arr[pos])
         {
            spr = arr[pos];
            if((!flipX || spr.flippedX) && (!flipY || spr.flippedY))
            {
               return arr[pos];
            }
            fX = spr.flippedX;
            fY = spr.flippedY;
         }
         if(flipX || flipY || fX || fY)
         {
            temp = new bitmap().bitmapData;
            if(!imageW)
            {
               imageW = temp.width;
            }
            if(!imageH)
            {
               imageH = temp.height;
            }
            w = !!flipX?temp.width << 1:int(temp.width);
            h = !!flipY?temp.height << 1:int(temp.height);
            data = new Spritemap(w,h,imageW,imageH,temp.width / imageW,originX,originY);
            data.copyPixels(temp,temp.rect,zero);
            matrix.b = matrix.c = 0;
            if(flipX || fX)
            {
               data.flippedX = true;
               data.imageR = w - imageW;
               matrix.a = -1;
               matrix.d = 1;
               matrix.tx = w;
               matrix.ty = 0;
               data.draw(temp,matrix);
            }
            if(flipY || fY)
            {
               data.flippedY = true;
               data.imageB = h >> 1;
               matrix.a = 1;
               matrix.d = -1;
               matrix.tx = 0;
               matrix.ty = h;
               data.draw(temp,matrix);
               if(flipX)
               {
                  matrix.a = -1;
                  matrix.tx = w;
                  data.draw(temp,matrix);
               }
            }
            if(useCache)
            {
               arr[pos] = data;
            }
            return data;
         }
         temp = new bitmap().bitmapData;
         if(!imageW)
         {
            imageW = temp.width;
         }
         if(!imageH)
         {
            imageH = temp.height;
         }
         data = new Spritemap(temp.width,temp.height,imageW,imageH,temp.width / imageW,originX,originY);
         data.copyPixels(temp,temp.rect,zero);
         data.imageW = imageW;
         data.imageH = imageH;
         if(useCache)
         {
            arr[pos] = data;
         }
         return data;
      }

      public static function getBlue(color:uint) : uint
      {
         return color & 255;
      }

      public static function musicPause() : void
      {
         if(_playing && !_paused)
         {
            _position = _musicCH.position;
            if(_musicCH.hasEventListener(Event.SOUND_COMPLETE))
            {
               _musicCH.removeEventListener(Event.SOUND_COMPLETE,musicEnd,false);
            }
            _musicCH.stop();
            _playing = false;
            _paused = true;
         }
      }

      public static function angle(x1:Number, y1:Number, x2:Number = 0, y2:Number = 0) : Number
      {
         var a:Number = Math.atan2(y2 - y1,x2 - x1) * _DEG;
         return a < 0?Number(a + 360):Number(a);
      }

      public static function get randomSeed() : uint
      {
         return _getSeed;
      }

      public static function get musicMute() : Boolean
      {
         return _musicMute;
      }

      public static function getColorRGB(R:uint = 0, G:uint = 0, B:uint = 0) : uint
      {
         return R << 16 | G << 8 | B;
      }

      public static function distance(x1:Number, y1:Number, x2:Number = 0, y2:Number = 0) : Number
      {
         return Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
      }

      public static function musicPlay(sound:Class, loop:Boolean = true, end:Function = null) : void
      {
         musicStop();
         _music = new sound();
         _musicTR.volume = _musicVolume * volume;
         _musicCH = _music.play(0,!!loop?999:0,_musicTR);
         _musicCH.addEventListener(Event.SOUND_COMPLETE,musicEnd,false,0,true);
         _playing = true;
         _looping = loop;
         _paused = false;
         _position = 0;
         _end = end;
      }
   }
}
