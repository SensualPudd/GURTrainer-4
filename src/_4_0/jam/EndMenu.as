package _4_0.jam
{
   import _4_0.FP;
   import _4_0.punk.Text;
   import _4_0.punk.core.Alarm;
   import _4_0.punk.util.Input;
   
   public class EndMenu extends MenuWorld
   {
       
      
      private var rank:uint;
      
      private var alarm:Alarm;
      
      private const REQS:Array = [160,100,50,25,10];
      
      private var drawn:uint = 0;
      
      private var balls:Vector.<DiscoBall>;
      
      private var canGo:Boolean = false;
      
      public function EndMenu()
      {
         this.alarm = new Alarm(120,this.cont,Alarm.PERSIST);
         super();
         addAlarm(this.alarm);
         _4_0.FP.musicStop();
         this.rank = 1;
         for(var i:int = 0; i < this.REQS.length; i++)
         {
            if(Stats.saveData.deaths <= this.REQS[i])
            {
               this.rank++;
            }
         }
         this.balls = new Vector.<DiscoBall>();
      }
      
      override public function update() : void
      {
         super.update();
         if(this.canGo && Input.pressed("skip"))
         {
            _4_0.FP.play(Assets.SndWin);
            add(new FuzzTransition(FuzzTransition.MENU,StatsMenu));
            this.canGo = false;
         }
      }
      
      private function cont() : void
      {
         var t:Text = null;
         if(this.drawn == 0)
         {
            t = new FlashingText("Good Job ROBOT!!",160,24);
            t.size = 36;
            t.center();
            add(t);
            this.alarm.start();
         }
         else if(this.drawn == 1)
         {
            t = new FlashingText("Your rank is...",160,48);
            t.size = 16;
            t.center();
            add(t);
            this.alarm.start();
         }
         else if(this.drawn < this.rank + 2)
         {
            this.balls[this.drawn - 2].start();
            _4_0.FP.play(Assets["SndRank" + (this.drawn - 1)]);
            this.alarm.totalFrames = 60;
            this.alarm.start();
         }
         else
         {
            t = new FlashingText("Press ENTER!",160,224);
            t.size = 16;
            t.center();
            add(t);
            this.canGo = true;
         }
         this.drawn++;
      }
      
      override public function init() : void
      {
         super.init();
         for(var i:int = 0; i < 6; i++)
         {
            this.balls.push(add(new DiscoBall(80 + 80 * (i % 3),96 + Math.floor(i / 3) * 80)) as DiscoBall);
         }
      }
   }
}
