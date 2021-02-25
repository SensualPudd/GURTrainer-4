package _4_0.adultswim
{
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   
   public class ScoreComponent
   {
       
      
      public function ScoreComponent()
      {
         super();
      }
      
      public static function submit(gameID:String, score:Number) : void
      {
         var strURI:String = ExternalInterface.call("getLittleServer");
         var local3:String = gameID;
         var local1:Number = score;
         var var5:Number = ExternalInterface.call("getSrvrTime");
         var var1:String = var5.toString();
         var strN1:String = var1.substr(-3,3);
         var strN2:String = var1.substr(-4,3);
         var n1:Number = parseInt(strN1);
         var n2:Number = parseInt(strN2);
         var var2:Number = n1 * n2 * local1 + local1;
         var strToPass:String = local3 + "," + local1 + "," + var5 + "," + var2;
         var md5:MD5 = new MD5(strToPass);
         var variables:URLVariables = new URLVariables();
         variables.attr1 = "score=" + local1 + "|gameId=" + local3 + "|timestamp=" + var5 + "|key=" + md5._hash;
         trace("score=" + local1 + "|gameId=" + local3 + "|timestamp=" + var5 + "|key=" + md5._hash);
         var request:URLRequest = new URLRequest(strURI);
         request.data = variables;
         try
         {
            navigateToURL(request,"_self");
         }
         catch(e:Error)
         {
         }
      }
   }
}
