package _4_0.jam
{
   import _4_0.FP;
   import _4_0.punk.Acrobat;
   
   public class Spawn extends Acrobat
   {
       
      
      public function Spawn(x:int, y:int)
      {
         super();
         this.x = x;
         this.y = y;
         sprite = Player.SprIdle;
         delay = 0;
         color = 16777215;
         alpha = 0;
      }
      
      override public function update() : void
      {
         alpha = alpha + 0.05;
         if(alpha >= 1 && (_4_0.FP.world as Level).player)
         {
            _4_0.FP.world.remove(this);
            (_4_0.FP.world as Level).player.visible = true;
            (_4_0.FP.world as Level).player.active = true;
         }
      }
   }
}
