package _4_0.jam
{
	import _4_0.FP;
   public class MenuParticle extends Particle
   {
       
      
      public function MenuParticle()
      {
         super();
      }
      
      override public function die() : void
      {
         visible = false;
         active = false;
         alarm.stop();
         _4_0.FP.world.remove(this);
         (_4_0.FP.world as MenuWorld).particles.push(this);
      }
   }
}
