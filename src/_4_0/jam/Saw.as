package _4_0.jam
{
   import _4_0.FP;
   import _4_0.Library;
   import _4_0.punk.core.Spritemap;

   public class Saw extends Block
   {

      private static const ImgSaw:Class = _4_0.Library.Saw_ImgSaw;

      private static const SprSaw:Spritemap = _4_0.FP.getSprite(ImgSaw,16,16,true);


      public function Saw(x:int, y:int, flip:Boolean)
      {
         super(x,y,16,16);
         sprite = SprSaw;
         delay = 3;
         flipX = flip;
         depth = 10;
      }
   }
}
