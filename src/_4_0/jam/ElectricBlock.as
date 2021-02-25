package _4_0.jam
{
   import _4_0.FP;
   import _4_0.Library;
   import _4_0.punk.core.Spritemap;

   public class ElectricBlock extends Block
   {

      private static const ImgElec:Class = _4_0.Library.ElectricBlock_ImgElec;

      private static const SprElec:Spritemap = _4_0.FP.getSprite(ImgElec,8,8);


      public function ElectricBlock(x:int, y:int, width:uint, height:uint)
      {
         super(x,y,width,height);
         sprite = SprElec;
         delay = 10;
         image = y / 8 % sprite.number;
      }

      override public function render() : void
      {
         var j:int = 0;
         super.render();
         for(var i:int = 0; i < width; i = i + 8)
         {
            for(j = 0; j < height; j = j + 8)
            {
               drawSprite(SprElec,(image + j / 8) % sprite.number,x + i,y + j);
            }
         }
      }
   }
}
