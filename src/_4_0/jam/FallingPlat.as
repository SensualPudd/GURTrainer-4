package _4_0.jam
{
   import _4_0.FP;
   import _4_0.punk.core.Alarm;
   import _4_0.punk.core.Entity;
   
   public class FallingPlat extends Block
   {
       
      
      private var started:Boolean = false;
      
      private var falling:Boolean = false;
      
      private var vSpeed:Number = 0;
      
      private var finished:Boolean = false;
      
      private const GRAVITY:Number = 0.2;
      
      private const MAX_FALL:Number = 3.5;
      
      private var alarm:Alarm;
      
      private var endY:uint;
      
      public function FallingPlat(x:int, y:int, width:int, height:int)
      {
         this.alarm = new Alarm(60,this.fall,Alarm.ONESHOT);
         super(x,y,width,height);
         addAlarm(this.alarm,false);
      }
      
      override public function update() : void
      {
         var i:int = 0;
         if(this.started)
         {
            if(this.falling)
            {
               this.vSpeed = Math.min(this.vSpeed + this.GRAVITY,this.MAX_FALL);
               moveV(Math.min(this.vSpeed,this.endY - y));
               if(y == this.endY)
               {
                  this.finished = true;
                  this.falling = false;
                  _4_0.FP.play(Assets.SndLand);
                  (_4_0.FP.world as Level).screenShake(10);
                  if(y > (_4_0.FP.world as Level).height)
                  {
                     _4_0.FP.world.remove(this);
                     for(i = x; i <= x + width; i = i + 4)
                     {
                        (_4_0.FP.world as Level).createParticles(2,i,(_4_0.FP.world as Level).height + 6,3,16777215,4,2,0.8,0.2,90,30,50,10);
                     }
                  }
                  else
                  {
                     for(i = x; i <= x + width; i = i + 4)
                     {
                        (_4_0.FP.world as Level).createParticles(2,i,y + height,3,16777215,4,2,0.3,0.1,0,180,50,10);
                     }
                  }
               }
            }
            else if(!this.finished)
            {
               if(!grapple && !collideWith(player,x,y - 1))
               {
                  this.alarm.stop();
                  this.fall();
               }
            }
         }
         else if(grapple || collideWith(player,x,y - 1))
         {
            _4_0.FP.play(Assets.SndShake);
            (_4_0.FP.world as Level).screenShake(10,1);
            particleBurst();
            this.started = true;
            this.alarm.start();
         }
      }
      
      public function getEndY() : void
      {
         var obj:Entity = null;
         this.endY = y;
         while(this.endY < (_4_0.FP.world as Level).height && ((obj = collide("solid",x,this.endY + 8)) == null || obj is FallingPlat || obj is Saw))
         {
            this.endY = this.endY + 8;
         }
         if(this.endY >= (_4_0.FP.world as Level).height)
         {
            this.endY = (_4_0.FP.world as Level).height + 24;
         }
      }
      
      private function fall() : void
      {
         _4_0.FP.play(Assets.SndFall);
         this.falling = true;
      }
      
      override public function render() : void
      {
         if(this.started && !this.falling && !this.finished)
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
