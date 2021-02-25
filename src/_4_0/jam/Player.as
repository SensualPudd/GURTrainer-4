package _4_0.jam
{
   import _4_0.FP;
   import _4_0.Library;
   import _4_0.punk.core.Alarm;
   import _4_0.punk.core.Spritemap;
   import _4_0.punk.util.Input;

   public class Player extends Moveable
   {

      private static const ImgThrow:Class =_4_0.Library.Player_ImgThrow;

      private static const ImgThrowDown:Class =_4_0.Library.Player_ImgThrowDown;

      private static const ImgThrowUp:Class =_4_0.Library.Player_ImgThrowUp;

      private static const ImgFall:Class =_4_0.Library.Player_ImgFall;

      private static const ImgIdle:Class =_4_0.Library.Player_ImgIdle;

      private static const ImgRun:Class =_4_0.Library.Player_ImgRun;

      private static const ImgGrapple:Class =_4_0.Library.Player_ImgGrapple;

      private static const ImgJump:Class =_4_0.Library.Player_ImgJump;

      private static const ImgGrappleAir:Class =_4_0.Library.Player_ImgGrappleAir;

      public static const SprIdle:Spritemap = _4_0.FP.getSprite(ImgIdle,10,18,true,false,5,13);

      private static const SprThrowUp:Spritemap = _4_0.FP.getSprite(ImgThrowUp,10,17,true,false,5,12);

      private static const SprThrow:Spritemap = _4_0.FP.getSprite(ImgThrow,10,17,true,false,5,12);

      private static const SprThrowDown:Spritemap = _4_0.FP.getSprite(ImgThrowDown,10,17,true,false,5,12);

      private static const SprJump:Spritemap = _4_0.FP.getSprite(ImgJump,10,18,true,false,5,13);

      private static const SprGrappleAir:Spritemap = _4_0.FP.getSprite(ImgGrappleAir,12,17,true,false,6,10);

      private static const SprRun:Spritemap = _4_0.FP.getSprite(ImgRun,12,17,true,false,6,12);

      private static const SprFall:Spritemap = _4_0.FP.getSprite(ImgFall,10,17,true,false,5,12);

      private static const SprGrapple:Spritemap = _4_0.FP.getSprite(ImgGrapple,12,17,true,false,6,12);


      private var varJ:Boolean = false;

      private var level:Level;

      private var dir:int = 1;

      private var grapple:Grapple;

      private const MAX_FALL:Number = 3.0;

      private const AIR_FRIC:Number = 0.1;

      private var alarmVarJTime:Alarm;

      private var currentSprite:int = -1;

      private const FRIC:Number = 0.6;

      private const VARJ_TIME:uint = 12;

      private const RUN:Number = 0.6;

      private const GRAVITY:Number = 0.15;

      private const MAX_RUN:Number = 2.0;

      public var vSpeed:Number = 0;

      private const JUMP:Number = -2.0;

      private var grappleWall:Boolean = false;

      public var hSpeed:Number = 0;

      public function Player(level:Level, x:int, y:int)
      {
         this.alarmVarJTime = new Alarm(this.VARJ_TIME,this.onVarJTime,Alarm.PERSIST);
         super();
         this.level = level;
         this.x = x;
         this.y = y;
         width = 8;
         height = 10;
         originX = 4;
         originY = 5;
         depth = -900;
         this.setSprite(SprIdle,15);
         addAlarm(this.alarmVarJTime,false);
         visible = false;
         active = false;
      }

      public function die(b:Block = null) : void
      {
         _4_0.FP.play(Assets.SndDie);
         this.level.screenShake(20);
         active = false;
         visible = false;
         if(this.grapple)
         {
            this.grapple.kill();
         }
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,0,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,45,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,90,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,135,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,180,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,225,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,270,0,60,0);
         this.level.createParticles(1,x,y,0,16777215,6,1,1.5,0,315,0,60,0);
         this.level.createParticles(26,x,y,6,16777215,2,1,2,1,0,180,40,10);
         this.level.createParticles(13,x,y,6,16777215,3,2,4,1,0,180,40,10);
         _4_0.FP.world.add(new Corpse(x,y));
         (_4_0.FP.world as Level).die();
      }

      private function setSprite(to:Spritemap, del:uint = 0) : void
      {
         if(sprite != to)
         {
            sprite = to;
            image = 0;
         }
         delay = del;
      }

      override public function update() : void
      {
         var onG:Block = getBelow();
         if(onG is ElectricBlock)
         {
            this.die();
            return;
         }
         if(Input.check("right"))
         {
            if(onG)
            {
               this.level.createParticles(1,x,y + 6,2,16777215,3,1,0.3,0.1,90,15,20,5);
            }
            flipX = false;
            this.dir = 1;
            if(this.hSpeed < this.MAX_RUN)
            {
               this.hSpeed = Math.min(this.hSpeed + this.RUN,this.MAX_RUN);
            }
         }
         else if(Input.check("left"))
         {
            if(onG)
            {
               this.level.createParticles(1,x,y + 6,2,16777215,3,1,0.3,0.1,90,15,20,5);
            }
            flipX = true;
            this.dir = -1;
            if(this.hSpeed > -this.MAX_RUN)
            {
               this.hSpeed = Math.max(this.hSpeed - this.RUN,-this.MAX_RUN);
            }
         }
         else
         {
            this.hSpeed = _4_0.FP.approach(this.hSpeed,0,!!onG?Number(this.FRIC):Number(this.AIR_FRIC));
         }
         if(this.grapple)
         {
            if(!Input.check("grapple"))
            {
               this.grapple.destroy();
            }
         }
         else if(Input.pressed("grapple"))
         {
            _4_0.FP.play(Assets.SndThrow);
            _4_0.FP.world.add(this.grapple = new Grapple(this.level,this,x,y,this.dir));
         }
         if(!this.grappleWall)
         {
            if(onG)
            {
               if(Input.pressed("jump"))
               {
                  this.level.createParticles(6,x,y + 6,2,16777215,3,2,1,0.5,90,30,20,8);
                  this.varJ = true;
                  this.alarmVarJTime.start();
                  this.vSpeed = this.JUMP;
                  _4_0.FP.play(Assets.SndJump);
               }
            }
            else
            {
               this.vSpeed = Math.min(this.vSpeed + this.GRAVITY,this.MAX_FALL);
               if(this.varJ)
               {
                  if(Input.check("jump"))
                  {
                     this.vSpeed = this.JUMP;
                  }
                  else
                  {
                     this.varJ = false;
                  }
               }
            }
            moveH(this.hSpeed,this.collideH);
            moveV(this.vSpeed,this.collideV);
         }
         if(this.grappleWall)
         {
            this.level.createParticles(2,x,y,8,16711935,3,2,2,0.5,0,180,4,1);
            if(onG)
            {
               this.setSprite(SprGrapple);
            }
            else
            {
               this.setSprite(SprGrappleAir,5);
            }
         }
         else if(onG)
         {
            if(this.grapple)
            {
               this.setSprite(SprThrow);
            }
            else if(!Input.check("left") && !Input.check("right"))
            {
               this.setSprite(SprIdle,12);
            }
            else
            {
               this.setSprite(SprRun,6);
            }
         }
         else if(this.grapple)
         {
            if(Math.abs(this.vSpeed) <= 0.8)
            {
               this.setSprite(SprThrow);
            }
            else if(this.vSpeed < 0)
            {
               this.setSprite(SprThrowUp);
            }
            else
            {
               this.setSprite(SprThrowDown);
            }
         }
         else if(Math.abs(this.vSpeed) <= 0.8)
         {
            this.setSprite(SprIdle);
         }
         else if(this.vSpeed < 0)
         {
            this.setSprite(SprJump);
         }
         else
         {
            this.setSprite(SprFall);
         }
         _4_0.FP.camera.moveTo(x,y);
         if(x > (_4_0.FP.world as Level).width + originX - 1)
         {
            if(this.grapple)
            {
               this.grapple.destroy();
            }
            (_4_0.FP.world as Level).win();
         }
         else if(y > (_4_0.FP.world as Level).height + originY + 5)
         {
            this.die();
         }
      }

      private function collideH(b:Block) : void
      {
         if(b is ElectricBlock || b is Saw)
         {
            this.die();
         }
         this.hSpeed = 0;
      }

      private function collideV(b:Block) : void
      {
         if(b is ElectricBlock || b is Saw)
         {
            this.die();
         }
         this.vSpeed = 0;
      }

      public function onGrappleHitWall() : void
      {
         this.hSpeed = 0;
         this.vSpeed = 0;
         this.grappleWall = true;
      }

      private function onVarJTime() : void
      {
         this.varJ = false;
      }

      override public function render() : void
      {
         var ax:int = 0;
         var ay:int = 0;
         var c:uint = 0;
         if(this.grappleWall)
         {
            ax = -3 + Math.random() * 6;
            ay = -3 + Math.random() * 6;
         }
         else
         {
            ax = 0;
            ay = 0;
         }
         if(this.grapple)
         {
            if(this.grappleWall)
            {
               c = 4278255615;
            }
            else
            {
               c = 4294967040;
            }
            drawLinePlus(this.grapple.x,this.grapple.y,x + ax,y + ay - originY - 4,c,1,2);
         }
         x = x + ax;
         y = y + ay;
         super.render();
         x = x - ax;
         y = y - ay;
      }

      public function removeGrapple() : void
      {
         this.grapple = null;
         this.grappleWall = false;
      }
   }
}
