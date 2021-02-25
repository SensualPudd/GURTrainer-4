package _4_0.jam
{
   import _4_0.FP;
   import _4_0.Library;
   import flash.geom.Point;
   import _4_0.punk.Acrobat;
   import _4_0.punk.core.Entity;
   import _4_0.punk.core.Spritemap;
   import _4_0.punk.util.Input;

   public class Grapple extends Acrobat
   {

      private static const ImgGrapple:Class = _4_0.Library.Grapple_ImgGrapple;

      private static var SprGrapple:Spritemap = _4_0.FP.getSprite(ImgGrapple,4,4,false,false,2,2);


      private var changedRad:int = 0;

      private var level:Level;

      private var direction:Number;

      private var wall:Block;

      private var dir:int;

      private const SAW_MOMENTUM:Number = 5.0;

      private var radius:Number;

      private var momentum:Number = 0;

      private var player:Player;

      private const SWING:Number = 0.1;

      private const RADIUS_UP:Number = 1.0;

      private const FRIC:Number = 0.025;

      private const GRAVITY:Number = 0.15;

      private const RADIUS_DOWN:Number = 1.5;

      private const MAX_MOMENTUM:Number = 2.5;

      private const MAX_RADIUS:Number = 128;

      private const MAX_PMOVE:Number = 9.0;

      private var goBack:Boolean = false;

      private const MOVE_SPEED:uint = 5;

      private var hitWall:Boolean = false;

      private const MIN_RADIUS:Number = 16;

      public function Grapple(level:Level, player:Player, x:int, y:int, dir:int)
      {
         super();
         this.level = level;
         this.player = player;
         this.x = x;
         this.y = y;
         this.dir = dir;
         width = 6;
         height = 6;
         originX = 3;
         originY = 3;
         depth = -1000;
         sprite = SprGrapple;
         scaleX = 3;
         scaleY = 3;
         image = 0;
         delay = 0;
      }

      private function onHitWallSaw(b:Block = null) : void
      {
         this.direction = this.direction - this.momentum;
         this.momentum = 0;
         if(b is ElectricBlock || b is Saw)
         {
            this.player.die();
         }
         this.radius = this.radius - 2;
      }

      public function kill() : void
      {
         var color:uint = 0;
         var p:Point = null;
         if(this.hitWall)
         {
            color = 65535;
         }
         else
         {
            color = 16776960;
         }
         this.radius = _4_0.FP.distance(x,y,this.player.x,this.player.y - 10);
         this.direction = _4_0.FP.angle(x,y,this.player.x,this.player.y - 10);
         var j:int = 0;
         for(var i:int = this.radius; i > 0; i = i - 6)
         {
            p = _4_0.FP.anglePoint(this.direction,i);
            this.level.createParticles(1,x + p.x,y + p.y,1,color,2,1,0.2,0.1,0,180,6,2,j);
            j = j + 2;
         }
         this.level.createParticles(6,x,y,4,color,3,1,0.4,0.2,0,180,30,10);
         this.destroy(false);
      }

      override public function render() : void
      {
         angle = _4_0.FP.angle(this.player.x,this.player.y,x,y) - 90;
         super.render();
      }

      private function onHitWall(b:Block = null) : void
      {
         this.direction = this.direction - this.momentum;
         this.momentum = 0;
         if(b is ElectricBlock || b is Saw)
         {
            this.player.die();
         }
      }

      public function move(h:Number, v:Number) : void
      {
         x = x + h;
         y = y + v;
         this.player.moveH(h);
         this.player.moveV(v);
      }

      public function destroy(parts:Boolean = true) : void
      {
         var color:uint = 0;
         var i:int = 0;
         var p:Point = null;
         if(parts)
         {
            if(this.hitWall)
            {
               color = 65535;
            }
            else
            {
               color = 16776960;
            }
            for(i = this.radius; i > 0; i = i - 6)
            {
               p = _4_0.FP.anglePoint(this.direction,i);
               this.level.createParticles(1,x + p.x,y + p.y,1,color,3,1,0.2,0.1,0,180,12,2);
            }
         }
         if(this.hitWall)
         {
            _4_0.FP.play(Assets.SndDrop);
         }
         _4_0.FP.world.remove(this);
         this.player.removeGrapple();
         if(this.wall)
         {
            this.wall.grapple = null;
         }
      }

      override public function update() : void
      {
         var p:Point = null;
         var obj:Entity = null;
         var onSaw:Boolean = false;
         var mx:Number = NaN;
         var my:Number = NaN;
         var s:Number = NaN;
         if(!this.hitWall)
         {
            if(this.goBack)
            {
               p = _4_0.FP.anglePoint(_4_0.FP.angle(x,y,this.player.x,this.player.y),this.MOVE_SPEED * Math.SQRT2);
               x = x + p.x;
               y = y + p.y;
               if(collideWith(this.player,x,y))
               {
                  this.destroy();
               }
            }
            else
            {
               x = x + this.MOVE_SPEED * this.dir;
               y = y - this.MOVE_SPEED;
               if(_4_0.FP.distance(x,y,this.player.x,this.player.y) > this.MAX_RADIUS)
               {
                  this.goBack = true;
               }
            }
            if((obj = collide("solid",x,y)) != null && (obj.x >= 0 && obj.y >= 0 || obj is MovingPlat))
            {
               image = 1;
               this.player.onGrappleHitWall();
               this.radius = _4_0.FP.distance(x,y,this.player.x,this.player.y);
               this.direction = _4_0.FP.angle(x,y,this.player.x,this.player.y);
               this.hitWall = true;
               this.wall = obj as Block;
               this.wall.grapple = this;
               if(obj is Saw)
               {
                  _4_0.FP.play(Assets.SndGrappleSaw);
               }
               else if(obj is ElectricBlock)
               {
                  _4_0.FP.play(Assets.SndGrappleElec);
               }
               else
               {
                  _4_0.FP.play(Assets.SndGrapple);
               }
               if(this.wall is Saw)
               {
                  x = this.wall.x + 8;
                  y = this.wall.y + 8;
               }
               this.level.createParticles(6,x,y,4,65535,3,2,0.8,0.3,0,180,25,5);
            }
         }
         else
         {
            onSaw = false;
            if(this.wall is Saw)
            {
               onSaw = true;
               this.momentum = this.SAW_MOMENTUM * (!!this.wall.flipX?1:-1);
               this.level.screenShake(4,1);
            }
            else
            {
               if(this.direction < 270 && this.direction > 90)
               {
                  this.momentum = Math.min(this.momentum + this.GRAVITY,this.MAX_MOMENTUM);
               }
               else
               {
                  this.momentum = Math.max(this.momentum - this.GRAVITY,-this.MAX_MOMENTUM);
               }
               if(Input.check("right"))
               {
                  if(this.direction > 260 && this.direction < 280)
                  {
                     s = this.SWING * 3;
                  }
                  else
                  {
                     s = this.SWING;
                  }
                  this.momentum = Math.min(this.momentum + s,this.MAX_MOMENTUM);
               }
               else if(Input.check("left"))
               {
                  if(this.direction > 260 && this.direction < 280)
                  {
                     s = this.SWING * 3;
                  }
                  else
                  {
                     s = this.SWING;
                  }
                  this.momentum = Math.max(this.momentum - s,-this.MAX_MOMENTUM);
               }
               else if(this.direction > 260 && this.direction < 280)
               {
                  this.momentum = _4_0.FP.approach(this.momentum,0,this.FRIC);
               }
            }
            if(Input.check("up"))
            {
               this.radius = Math.max(this.MIN_RADIUS,this.radius - this.RADIUS_UP);
            }
            else if(Input.check("down"))
            {
               this.radius = Math.min(this.MAX_RADIUS,this.radius + this.RADIUS_DOWN);
            }
            this.direction = this.direction + this.momentum;
            p = _4_0.FP.anglePoint(this.direction,this.radius);
            mx = p.x + x - this.player.x;
            my = p.y + y - this.player.y;
            mx = Math.min(Math.max(mx,-this.MAX_PMOVE),this.MAX_PMOVE);
            my = Math.min(Math.max(my,-this.MAX_PMOVE),this.MAX_PMOVE);
            this.player.moveH(mx,!!onSaw?this.onHitWallSaw:this.onHitWall);
            if(!this.player)
            {
               return;
            }
            this.player.moveV(my,!!onSaw?this.onHitWallSaw:this.onHitWall);
            if(!this.player)
            {
               return;
            }
            this.player.hSpeed = mx;
            this.player.vSpeed = my;
         }
      }
   }
}
