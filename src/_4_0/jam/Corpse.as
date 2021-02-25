package _4_0.jam
{
   import _4_0.punk.Acrobat;
   
   public class Corpse extends Acrobat
   {
       
      
      public function Corpse(x:int, y:int)
      {
         super();
         this.x = x;
         this.y = y;
         sprite = Player.SprIdle;
         delay = 0;
         color = 4294967295;
      }
      
      override public function update() : void
      {
         alpha = alpha - 0.05;
         scaleX = scaleX + 0.02;
         scaleY = scaleY + 0.02;
      }
   }
}
