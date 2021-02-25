package _4_0.jam
{
   import _4_0.FP;
   import _4_0.punk.Actor;
   
   public class EndLine extends Actor
   {
       
      
      private var level:Level;
      
      public function EndLine()
      {
         super();
         this.level = _4_0.FP.world as Level;
         depth = 100000;
      }
      
      override public function render() : void
      {
         drawRect(this.level.width - 3,0,3,this.level.height,4473924);
         drawRect(this.level.width - 6,0,2,this.level.height,4473924);
         drawRect(this.level.width - 8,0,1,this.level.height,4473924);
      }
   }
}
