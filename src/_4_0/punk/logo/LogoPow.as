
package _4_0.punk.logo
{
   import _4_0.FP;
   import _4_0.Library;
   import _4_0.punk.Acrobat;

   public class LogoPow extends Acrobat
   {


      private var _state:int;

      private var _wait:int;

      private var _cogs:LogoCogs;

      private var ImgLogoPow:Class;

      private var _text:LogoText;

      public function LogoPow(cogs:LogoCogs, text:LogoText)
      {
         this.ImgLogoPow = _4_0.Library.LogoPow_ImgLogoPow;
         super();
         sprite = _4_0.FP.getSprite(this.ImgLogoPow,56,7);
         alpha = 0;
         x = x + 6;
         y = y + 48;
         this._cogs = cogs;
         this._text = text;
         color = Splash.front;
      }

      override public function update() : void
      {
         if(this._state == 0)
         {
            alpha = alpha + 0.1;
            if(alpha >= 1)
            {
               alpha = 1;
               this._state = 1;
               this._wait = 40;
            }
         }
         else if(this._state == 1)
         {
            this._wait--;
            if(this._wait == 0)
            {
               this._state = 2;
            }
         }
         else if(this._state == 2)
         {
            alpha = alpha - 0.1;
            if(alpha <= 0)
            {
               this._state = 3;
               _4_0.FP.world.add(this._cogs);
               _4_0.FP.world.add(this._text);
               _4_0.FP.world.remove(this);
            }
         }
      }
   }
}
