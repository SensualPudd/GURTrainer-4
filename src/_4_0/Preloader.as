package _4_0
{
   import _4_0.Library;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.geom.Matrix;
   import flash.utils.getDefinitionByName;

   public class Preloader extends MovieClip
   {

      private static const ImgBG:Class = _4_0.Library.Preloader_ImgBG;

      private static const ImgLoading:Class = _4_0.Library.Preloader_ImgLoading;


      private var bar:Sprite;

      public function Preloader()
      {
         super();
         addEventListener(Event.ENTER_FRAME,this.checkFrame);
         loaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progress);
         var s:Sprite = new Sprite();
         var m:Matrix = new Matrix();
         m.scale(2,2);
         s.graphics.beginBitmapFill((new ImgBG() as Bitmap).bitmapData,m);
         s.graphics.drawRect(0,0,640,480);
         s.graphics.endFill();
         m.scale(1,1);
         m.translate(161,129);
         s.graphics.beginBitmapFill((new ImgLoading() as Bitmap).bitmapData,m,false);
         s.graphics.drawRect(0,0,640,480);
         s.graphics.endFill();
         addChild(s);
         this.bar = new Sprite();
         this.bar.graphics.beginFill(5592405);
         this.bar.graphics.drawRect(260,230,120,20);
         this.bar.graphics.endFill();
         addChild(this.bar);
      }

      private function checkFrame(e:Event) : void
      {
         if(currentFrame == totalFrames)
         {
            removeEventListener(Event.ENTER_FRAME,this.checkFrame);
            this.startup();
         }
      }

      private function progress(e:ProgressEvent) : void
      {
         this.bar.graphics.clear();
         this.bar.graphics.beginFill(5592405);
         this.bar.graphics.drawRect(260,230,120,20);
         this.bar.graphics.endFill();
         this.bar.graphics.beginFill(16777215);
         this.bar.graphics.drawRect(260,230,e.bytesLoaded / e.bytesTotal * 120,20);
         this.bar.graphics.endFill();
      }

      private function startup() : void
      {
         stop();
         loaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progress);
         var mainClass:Class = getDefinitionByName("Main") as Class;
         addChild(new mainClass() as DisplayObject);
      }
   }
}
