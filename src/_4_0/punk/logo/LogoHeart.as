
package _4_0.punk.logo
{
   import _4_0.FP;
   import _4_0.punk.Acrobat;

   public class LogoHeart extends Acrobat
   {


      private var _spdX:Number;

      private var _spdY:Number;

      private const ImgLogoHeart:Class =_4_0.Library.LogoHeart_ImgLogoHeart;

      private var _par:Acrobat;

      private var _slow:Number;

      public function LogoHeart(startx:int, starty:int, parent:Acrobat)
      {
         super();
         sprite = _4_0.FP.getSprite(this.ImgLogoHeart,11,9);
         delay = 4;
         loop = false;
         this._spdX = 1 + Math.random() * 1;
         this._spdY = -1 - Math.random();
         this._slow = 0.02 + Math.random() * 0.03;
         this._par = parent;
         x = startx;
         y = starty;
      }

      override public function update() : void
      {
         x = x + this._spdX;
         y = y + this._spdY;
         if(this._spdX > 0)
         {
            this._spdX = this._spdX - this._slow;
         }
         else
         {
            this._spdX = 0;
         }
         alpha = this._par.alpha;
      }
   }
}
