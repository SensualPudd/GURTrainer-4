package _4_0.jam
{
   import flash.net.SharedObject;
   
   public class Stats
   {
      
      public static var saveData:SaveData;
       
      
      public function Stats()
      {
         super();
      }
      
      public static function resetStats() : void
      {
         saveData = new SaveData();
      }
      
      public static function clear() : void
      {
         var obj:SharedObject = SharedObject.getLocal("Data");
         obj.data.saveData = null;
      }
      
      public static function haveHardMode() : Boolean
      {
         var obj:SharedObject = SharedObject.getLocal("Hard");
         return obj.data.unlock;
      }
      
      public static function load() : void
      {
         var obj:SharedObject = SharedObject.getLocal("Data");
         saveData = new SaveData(obj.data.saveData);
         saveData.validateChecksum();
      }
      
      public static function exists() : Boolean
      {
         var obj:SharedObject = SharedObject.getLocal("Data");
         return obj.data.saveData != null;
      }
      
      public static function save() : void
      {
         var obj:SharedObject = SharedObject.getLocal("Data");
         saveData.updateChecksum();
         obj.data.saveData = saveData;
      }
      
      public static function setHardMode(to:Boolean) : void
      {
         var obj:SharedObject = SharedObject.getLocal("Hard");
         obj.data.unlock = to;
      }
   }
}
