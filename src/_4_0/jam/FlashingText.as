package _4_0.jam
{
   import _4_0.punk.Textplus;
   import _4_0.punk.core.Alarm;
   
   public class FlashingText extends Textplus
   {
       
      
      private var alarm:Alarm;
      
      private const colors:Array = [16711680,16776960,65280,65535,255,16711935];
      
      private var current:uint = 0;
      
      public function FlashingText(str:String = "", x:int = 0, y:int = 0)
      {
         this.alarm = new Alarm(5,this.change,Alarm.LOOPING);
         super(str,x,y);
         color = this.colors[0];
         addAlarm(this.alarm);
      }
      
      private function change() : void
      {
         this.current++;
         if(this.current >= this.colors.length)
         {
            this.current = 0;
         }
         color = this.colors[this.current];
      }
   }
}
