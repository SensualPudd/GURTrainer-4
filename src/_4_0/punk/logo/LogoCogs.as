
package _4_0.punk.logo
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import _4_0.FP;
   import _4_0.punk.Acrobat;
   import _4_0.punk.util.Input;

   public class LogoCogs extends Acrobat
   {


      private const ImgLogoCogs:Class =_4_0.Library.LogoCogs_ImgLogoCogs;

      private var _spit:Boolean = false;

      public function LogoCogs()
      {
         super();
         sprite = _4_0.FP.getSprite(this.ImgLogoCogs,68,41);
         delay = 6;
         alpha = 0;
         color = Splash.front;
      }

      override public function update() : void
      {
         var heart:Acrobat = null;
         var URL:URLRequest = null;
         if(alpha < 1)
         {
            alpha = alpha + 0.01;
         }
         if(!this._spit && image == 3)
         {
            this._spit = true;
            heart = new LogoHeart(x + 58,y,this);
            heart.color = color;
            heart.alpha = heart.alpha * alpha;
            _4_0.FP.world.add(heart);
         }
         if(image == 4)
         {
            this._spit = false;
         }
         if(Splash.link && Input.mousePressed)
         {
            if(Input.mouseX > 0 && Input.mouseY > 0 && Input.mouseX < _4_0.FP.screen.width && Input.mouseY < _4_0.FP.screen.height)
            {
               URL = new URLRequest("http://flashpunk.net");
               navigateToURL(URL,"_self");
            }
         }
      }
   }
}
