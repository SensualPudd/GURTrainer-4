
package _4_0.punk.logo
{
	import _4_0.FP;
	import _4_0.Library;
   import _4_0.punk.Acrobat;

   public class LogoText extends Acrobat
   {


      private const SndScribble:Class =_4_0.Library.LogoText_SndScribble;

      private const SndBoing:Class =_4_0.Library.LogoText_SndBoing;

      private var _punkSnd:Boolean = false;

      var _fadeWait:int = 0;

      var _endWait:int = 0;

      private var _wait:int = 30;

      private var _state:int = 0;

      var _fadeOut:Boolean = false;

      private const ImgLogoText:Class =_4_0.Library.LogoText_ImgLogoText;

      public function LogoText()
      {
         super();
         sprite = _4_0.FP.getSprite(this.ImgLogoText,51,12);
         loop = false;
         anim = this.animEnd;
         delay = 0;
         y = y + 41;
         color = Splash.front;
      }

      override public function update() : void
      {
         if(this._fadeWait > 0)
         {
            this._fadeWait--;
            if(this._fadeWait == 0)
            {
               this._fadeOut = true;
            }
         }
         if(this._fadeOut)
         {
            if(alpha > 0)
            {
               alpha = alpha - 0.02;
            }
            else
            {
               alpha = 0;
               this._endWait++;
            }
            return;
         }
         if(this._wait > 0)
         {
            this._wait--;
            if(this._wait == 0)
            {
               this._state++;
               if(this._state == 3)
               {
                  delay = 6;
               }
               else
               {
                  delay = 1;
                  _4_0.FP.play(this.SndScribble,Splash.volume);
               }
            }
         }
         if(image == 40 || image == 42 || image == 44 || image == 46)
         {
            if(!this._punkSnd)
            {
               _4_0.FP.play(this.SndBoing,Splash.volume);
               this._punkSnd = true;
            }
         }
         else
         {
            this._punkSnd = false;
         }
         if(this._state == 1 && image == 39)
         {
            delay = 0;
            this._wait = 10;
            this._state++;
         }
      }

      private function animEnd() : void
      {
         this._fadeWait = 60;
      }
   }
}
