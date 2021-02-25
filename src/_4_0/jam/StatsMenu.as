package _4_0.jam
{
   import _4_0.FP;
   import _4_0.punk.core.Alarm;
   import _4_0.punk.util.Input;
   
   public class StatsMenu extends MenuWorld
   {
       
      
      private var current:uint = 0;
      
      private var dots:Vector.<GraphDot>;
      
      private var canGo:Boolean = true;
      
      private const G_HEIGHT:uint = 200;
      
      private const G_X:uint = 10;
      
      private const G_Y:uint = 20;
      
      private var mode:Boolean = true;
      
      private var hitText:FlashingText;
      
      private var alarmColors:Alarm;
      
      public var color:uint;
      
      private var text:FlashingText;
      
      private const G_WIDTH:uint = 300;
      
      private const colors:Array = [16711680,16776960,65280,65535,255,16711935];
      
      private var inText:FlashingText;
      
      public function StatsMenu()
      {
         this.alarmColors = new Alarm(5,this.onColor,Alarm.LOOPING);
         super();
         this.color = this.colors[0];
         this.dots = new Vector.<GraphDot>();
      }
      
      private function onColor() : void
      {
         this.current++;
         if(this.current >= this.colors.length)
         {
            this.current = 0;
         }
         this.color = this.colors[this.current];
      }
      
      private function loadGraph(name:String, graph:Vector.<uint>) : void
      {
         var u:uint = 0;
         var i:int = 0;
         this.text.text = name;
         this.text.center();
         var biggest:int = 0;
         for each(u in graph)
         {
            if(u > biggest)
            {
               biggest = u;
            }
         }
         if(biggest == 0)
         {
            for(i = 0; i < Assets.TOTAL_LEVELS[Stats.saveData.mode]; i++)
            {
               this.dots[i]._goto_Y = this.G_Y + this.G_HEIGHT;
            }
         }
         else
         {
            for(i = 0; i < Assets.TOTAL_LEVELS[Stats.saveData.mode]; i++)
            {
               this.dots[i]._goto_Y = this.G_Y + this.G_HEIGHT - graph[i] / biggest * this.G_HEIGHT;
            }
         }
      }
      
      override public function init() : void
      {
         var g:GraphDot = null;
         super.init();
         addAlarm(this.alarmColors);
         this.text = new FlashingText("",160,16);
         this.text.size = 24;
         this.text.center();
         add(this.text);
         this.inText = new FlashingText("",160,120);
         this.inText.size = 16;
         this.inText.depth = -100;
         this.inText.center();
         add(this.inText);
         this.hitText = new FlashingText("Z/A - Time    ENTER - Continue",160,232);
         this.hitText.size = 8;
         this.hitText.center();
         add(this.hitText);
         for(var i:int = 0; i < Assets.TOTAL_LEVELS[Stats.saveData.mode]; i++)
         {
            g = new GraphDot();
            g.x = i / (Assets.TOTAL_LEVELS[Stats.saveData.mode] - 1) * this.G_WIDTH + this.G_X;
            g.y = this.G_Y + this.G_HEIGHT;
            g._goto_Y = g.y;
            add(g);
            this.dots.push(g);
         }
         this._goto_DeathsGraph();
      }
      
      override public function render() : void
      {
         var last:GraphDot = null;
         var g:GraphDot = null;
         for each(g in this.dots)
         {
            if(last)
            {
               drawLine(last.x,last.y,g.x,g.y,this.color);
            }
            last = g;
         }
      }
      
      private function _goto_TimeGraph() : void
      {
         this.loadGraph("Time",Stats.saveData.time_stage);
         this.inText.text = Stats.saveData.formattedTime;
         this.hitText.text = "Z/A - Deaths    ENTER - Continue";
         this.inText.center();
         this.hitText.center();
      }
      
      override public function update() : void
      {
         super.update();
         if(Input.pressed("grapple"))
         {
            this.mode = !this.mode;
            _4_0.FP.play(Assets.SndSelect);
            if(this.mode)
            {
               this._goto_DeathsGraph();
            }
            else
            {
               this._goto_TimeGraph();
            }
         }
         if(Input.pressed("skip") && this.canGo)
         {
            Stats.clear();
            Stats.setHardMode(true);
            this.canGo = false;
            _4_0.FP.play(Assets.SndWin);
            add(new FuzzTransition(FuzzTransition.MENU,SubmitMenu));
         }
      }
      
      private function _goto_DeathsGraph() : void
      {
         this.loadGraph("Deaths",Stats.saveData.deaths_stage);
         if(Stats.saveData.deaths > 0)
         {
            this.inText.text = String(Stats.saveData.deaths);
         }
         else
         {
            this.inText.text = "None!";
         }
         this.hitText.text = "Z/A - Time      ENTER - Continue";
         this.inText.center();
         this.hitText.center();
      }
   }
}
