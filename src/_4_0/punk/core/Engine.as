
package _4_0.punk.core
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageDisplayState;
   import flash.display.StageQuality;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import _4_0.jam.Level;
   import _4_0.punk.logo.Splash;
   import _4_0.punk.util.Input;
   import _4_0.FP;

   public class Engine extends Sprite
   {

      public static var flash:Boolean = true;


      private var _current:Number;

      private var _width:int;

      private var _scale:int;

      private var _height:int;

      var _bitmap:Bitmap;

      var _screenRect:Rectangle;

      private var sss:Number = 0;

      private var _frameTimer:Timer;

      private var _focus:Boolean = true;

      private var _frameTime:Number;

      private var _start:Class;

      private var _skip:Number;

      private var _timer:Timer;

      private var _frame:int;

      public var runUnfocused:Boolean = false;

      private var _last:Number;

      private var _delta:Number;

      private var _frameRate:int;

      private var _rate:Number;

      public function Engine(width:int = 320, height:int = 240, fps:int = 60, scale:int = 1, world:Class = null)
      {
         super();
         if(world == null)
         {
            world = World;
         }
         this._start = world;
         this._width = width;
         this._height = height;
         _4_0.FP.fps = fps;
         this._scale = scale;
         if(_4_0.FP.randomSeed == 0)
         {
            _4_0.FP.randomizeSeed();
         }
         _4_0.FP.entity = new Entity();
         if(stage)
         {
            this.onStage(null);
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onStage);
         }
      }

      public function showSplash(backColor:uint = 2105376, logoColor:uint = 16724838, volume:Number = 0.5, webLink:Boolean = false) : void
      {
         Splash.show = true;
         Splash.volume = volume;
         Splash.link = webLink;
         Splash.back = backColor;
         Splash.front = logoColor;
      }

      public function get FPS() : int
      {
         return this._frameRate;
      }

      public function init() : void
      {
      }

      private function focusLose(e:Event) : void
      {
         this._focus = false;
         if(_4_0.FP.world.focusOut != null)
         {
            _4_0.FP.world.focusOut();
         }
      }

      private function tick(e:TimerEvent) : void
      {
         var s:BitmapData = null;
         var a:uint = 0;
         this._current = getTimer();
         this._delta = this._delta + (this._current - this._last);
         this._last = this._current;
         if(this._delta >= this._rate)
         {
            this._frame++;
            this._delta = this._delta % this._skip;
            while(this._delta >= this._rate)
            {
               this._delta = this._delta - this._rate;
               _4_0.FP.world.updateF();
               Input.update();
            }
            if(flash)
            {
               s = _4_0.FP.screen.clone();
               this.sss = (this.sss + Math.PI / 16) % (Math.PI * 2);
            }
            _4_0.FP.screen.lock();
            _4_0.FP.screen.fillRect(this._screenRect,_4_0.FP.screen.color);
            _4_0.FP.world.renderF();
            if(flash)
            {
               _4_0.FP.screen.draw(s,null,new ColorTransform(1 + Math.sin(this.sss) * 0.2,1 + Math.sin(this.sss + Math.PI * 2 / 3) * 0.2,1 + Math.sin(this.sss + Math.PI * 4 / 3) * 0.2,0.65));
            }
            if(_4_0.FP.world is Level && (_4_0.FP.world as Level).shake)
            {
               a = (_4_0.FP.world as Level).shakeAmount;
               _4_0.FP.screen.scroll(_4_0.FP.choose(a,-a),_4_0.FP.choose(a,-a));
            }
            _4_0.FP.screen.unlock();
            e.updateAfterEvent();
            if(_4_0.FP._goto_)
            {
               this.switchWorld();
            }
            if(!this._focus && !this.runUnfocused)
            {
               this._timer.stop();
            }
         }
      }

      private function onStage(e:Event = null) : void
      {
         stage.align = StageAlign.TOP_LEFT;
         stage.quality = StageQuality.HIGH;
         stage.scaleMode = StageScaleMode.SHOW_ALL;
         stage.displayState = StageDisplayState.NORMAL;
         removeEventListener(Event.ADDED_TO_STAGE,this.onStage);
         stage.frameRate = 60;
         this._rate = 1000 / _4_0.FP.fps;
         this._skip = this._rate * 10;
         this._last = getTimer();
         this._current = this._last;
         this._delta = 0;
         this._timer = new Timer(4);
         this._timer.addEventListener(TimerEvent.TIMER,this.tick);
         this._timer.start();
         this._frame = 0;
         this._frameTime = 0;
         this._frameRate = _4_0.FP.fps;
         this._frameTimer = new Timer(1000);
         this._frameTimer.addEventListener(TimerEvent.TIMER,this.frameTick);
         this._frameTimer.start();
         _4_0.FP.stage = stage;
         _4_0.FP.engine = this;
         _4_0.FP.screen = new Screen(this._width,this._height,Splash.back,this._scale);
         _4_0.FP.camera = new Camera();
         this._screenRect = _4_0.FP.screen.rect;
         this._bitmap = new Bitmap(_4_0.FP.screen);
         this._bitmap.scaleX = this._scale;
         this._bitmap.scaleY = this._scale;
         addChild(this._bitmap);
         Input.enable(stage);
         if(Splash.show)
         {
            _4_0.FP.world = new Splash(this._start);
         }
         else
         {
            _4_0.FP.world = new this._start();
         }
         stage.addEventListener(Event.ACTIVATE,this.focusGain);
         stage.addEventListener(Event.DEACTIVATE,this.focusLose);
         this.init();
         _4_0.FP.world.init();
      }

      private function frameTick(e:TimerEvent) : void
      {
         this._frameRate = this._frame;
         this._frame = 0;
      }

      private function focusGain(e:Event) : void
      {
         this._focus = true;
         if(_4_0.FP.world.focusIn != null)
         {
            _4_0.FP.world.focusIn();
         }
         if(!this._timer.running)
         {
            this._last = getTimer();
            this._timer.start();
         }
      }

      private function switchWorld() : void
      {
         _4_0.FP.world.removeAll();
         _4_0.FP.world = _4_0.FP._goto_;
         _4_0.FP._goto_.init();
         _4_0.FP._goto_ = null;
         System.gc();
         System.gc();
      }
   }
}
