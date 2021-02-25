package _4_0.jam
{
   import _4_0.punk.Backdrop;
   import _4_0.punk.core.World;
   
   public class MenuWorld extends World
   {
       
      
      private var bg:Backdrop;
      
      public var particles:Vector.<MenuParticle>;
      
      public function MenuWorld()
      {
         super();
      }
      
      override public function init() : void
      {
         this.particles = new Vector.<MenuParticle>();
         add(this.bg = new Backdrop(Level.ImgBG));
         if(Assets.fuzz != null)
         {
            add(Assets.fuzz);
            Assets.fuzz = null;
         }
      }
      
      public function createParticles(amount:uint, x:uint, y:uint, posRand:uint, color:uint, size:uint, sizeRand:uint, speed:Number, speedRand:Number, direction:Number, dirRand:Number, life:uint, lifeRand:uint, delay:uint = 0) : void
      {
         var p:MenuParticle = null;
         if(!Assets.particles)
         {
            return;
         }
         for(var i:int = 0; i < amount; i++)
         {
            if(this.particles.length == 0)
            {
               p = new MenuParticle();
            }
            else
            {
               p = this.particles.pop();
            }
            p.setDraw(x - posRand + Math.random() * posRand * 2,y - posRand + Math.random() * posRand * 2,color,size - sizeRand + Math.random() * sizeRand * 2,speed - speedRand + Math.random() * speedRand * 2,direction - dirRand + Math.random() * dirRand * 2,life - lifeRand + Math.random() * lifeRand * 2,delay);
            add(p);
         }
      }
      
      override public function update() : void
      {
         this.bg.x = this.bg.x - 0.25;
         this.bg.y = this.bg.y - 0.25;
      }
   }
}
