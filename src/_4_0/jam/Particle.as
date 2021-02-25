package _4_0.jam
{
   import _4_0.FP;
   import flash.geom.Point;
   import _4_0.punk.Actor;
   import _4_0.punk.core.Alarm;
   
   public class Particle extends Actor
   {
       
      
      private var size:uint;
      
      private var color:uint;
      
      protected var alarm:Alarm;
      
      private var alarmDelay:Alarm;
      
      private var vSpeed:Number;
      
      private var hSpeed:Number;
      
      public function Particle()
      {
         this.alarm = new Alarm(1,this.die,Alarm.PERSIST);
         this.alarmDelay = new Alarm(1,this.onDelay,Alarm.PERSIST);
         super();
         visible = false;
         active = false;
         depth = -1000;
         addAlarm(this.alarm,false);
         addAlarm(this.alarmDelay,false);
      }
      
      public function die() : void
      {
         visible = false;
         active = false;
         this.alarm.stop();
         _4_0.FP.world.remove(this);
         (_4_0.FP.world as Level).particles.push(this);
      }
      
      private function onDelay() : void
      {
         this.alarm.start();
         visible = true;
         active = true;
      }
      
      public function setDraw(x:uint, y:uint, color:uint, size:uint, speed:Number, direction:Number, life:uint, delay:uint = 0) : void
      {
         this.x = x - size / 2;
         this.y = y - size / 2;
         this.color = color;
         this.size = size;
         var p:Point = _4_0.FP.anglePoint(direction,speed);
         this.hSpeed = p.x;
         this.vSpeed = p.y;
         this.alarm.totalFrames = life;
         if(delay > 0)
         {
            this.alarmDelay.totalFrames = delay;
            this.alarmDelay.start();
         }
         else
         {
            visible = true;
            active = true;
            this.alarm.start();
         }
      }
      
      override public function update() : void
      {
         x = x + this.hSpeed;
         y = y + this.vSpeed;
      }
      
      override public function render() : void
      {
         drawRect(x,y,this.size,this.size,this.color,this.alarm.remainingFrames / (this.alarm.totalFrames / 8));
      }
   }
}
