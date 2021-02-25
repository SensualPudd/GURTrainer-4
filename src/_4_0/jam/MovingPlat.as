package _4_0.jam
{
   import _4_0.FP;
   import flash.geom.Point;
   import _4_0.punk.core.Alarm;
   
   public class MovingPlat extends Block
   {
       
      
      private var goY:int;
      
      private var shaking:Boolean = false;
      
      private var stopAtEnd:Boolean;
      
      private var alarm:Alarm;
      
      private var dontStart:Boolean;
      
      private var endX:int;
      
      private var endY:int;
      
      private var goX:int;
      
      private var startX:int;
      
      private var startY:int;
      
      private var vSpeed:Number;
      
      private var going:Boolean;
      
      private var hSpeed:Number;
      
      public function MovingPlat(x:int, y:int, width:int, height:int, endX:int, endY:int, speed:Number, dontStart:Boolean, stopAtEnd:Boolean)
      {
         super(x,y,width,height);
         this.startX = x;
         this.startY = y;
         this.endX = endX;
         this.endY = endY;
         this.dontStart = dontStart;
         this.stopAtEnd = stopAtEnd;
         var p:Point = _4_0.FP.anglePoint(_4_0.FP.angle(x,y,endX,endY),speed);
         this.hSpeed = Math.abs(p.x);
         this.vSpeed = Math.abs(p.y);
         this.goX = endX;
         this.goY = endY;
         this.going = !dontStart;
         if(dontStart)
         {
            this.alarm = new Alarm(20,this.start,Alarm.ONESHOT);
            addAlarm(this.alarm,false);
         }
      }
      
      override public function update() : void
      {
         if(this.going)
         {
            if(x < this.goX)
            {
               moveH(Math.min(this.goX - x,this.hSpeed));
            }
            else if(x > this.goX)
            {
               moveH(Math.max(this.goX - x,-this.hSpeed));
            }
            if(y < this.goY)
            {
               moveV(Math.min(this.goY - y,this.vSpeed));
            }
            else if(y > this.goY)
            {
               moveV(Math.max(this.goY - y,-this.vSpeed));
            }
            if(x == this.goX && y == this.goY)
            {
               if(this.goX == this.endX && this.goY == this.endY)
               {
                  this.goX = this.startX;
                  this.goY = this.startY;
                  if(this.stopAtEnd)
                  {
                     _4_0.FP.play(Assets.SndEnd);
                     this.going = false;
                  }
               }
               else
               {
                  this.goX = this.endX;
                  this.goY = this.endY;
               }
            }
         }
         else if(this.dontStart && !this.shaking)
         {
            if(collideWith(player,x,y - 1) || grapple != null)
            {
               this.dontStart = false;
               this.alarm.start();
               _4_0.FP.play(Assets.SndStart);
               (_4_0.FP.world as Level).screenShake(10,1);
               particleBurst();
               this.shaking = true;
            }
         }
      }
      
      private function start() : void
      {
         this.shaking = false;
         this.going = true;
      }
      
      override public function render() : void
      {
         if(this.shaking)
         {
            drawTiles(x - 2 + Math.random() * 4,y - 2 + Math.random() * 4);
         }
         else
         {
            drawTiles(x,y);
         }
      }
   }
}
