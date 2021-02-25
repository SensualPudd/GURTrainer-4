package _4_0.jam
{
   public class SaveData
   {
       
      
      public var deaths_stage:Vector.<uint>;
      
      public var check:int;
      
      public var time_stage:Vector.<uint>;
      
      public var tcheck:uint;
      
      public var levelNum:uint;
      
      public var mode:uint;
      
      public var _time:uint;
      
      public var deaths:uint;
      
      public function SaveData(obj:Object = null)
      {
         super();
         if(obj == null)
         {
            this.init();
         }
         else
         {
            this.levelNum = obj.levelNum;
            this.mode = obj.mode;
            this.deaths = obj.deaths;
            this.time = obj.time;
            this.deaths_stage = obj.deaths_stage;
            this.time_stage = obj.time_stage;
            this.check = obj.check;
         }
      }
      
      public function validateChecksum() : void
      {
         if(this.getChecksum() != this.check)
         {
            this.init();
         }
      }
      
      public function get time() : uint
      {
         if(this._time % 479 != this.tcheck)
         {
            this._time = 50000000;
         }
         return this._time;
      }
      
      public function addTime(amount:uint) : void
      {
         this.time = this.time + amount;
         this.time_stage[this.levelNum - 1] = this.time_stage[this.levelNum - 1] + amount;
      }
      
      public function addDeath() : void
      {
         this.deaths++;
         this.deaths_stage[this.levelNum - 1]++;
      }
      
      private function init() : void
      {
         this.levelNum = 1;
         this.deaths = 0;
         this.time = 0;
         this.deaths_stage = new Vector.<uint>();
         this.time_stage = new Vector.<uint>();
         for(var i:int = 0; i < Assets.TOTAL_LEVELS[this.mode]; i++)
         {
            this.deaths_stage.push(0);
            this.time_stage.push(0);
         }
      }
      
      public function set time(to:uint) : void
      {
         this._time = to;
         this.tcheck = to % 479;
      }
      
      public function get formattedTime() : String
      {
         var sec:Number = this.time % (60 * 60);
         sec = sec / 60;
         var str:String = sec.toFixed(2);
         if(sec < 10)
         {
            str = "0" + str;
         }
         str = ":" + str;
         var blah:uint = Math.floor(this.time / (60 * 60));
         str = String(blah) + str;
         return str;
      }
      
      private function getChecksum() : int
      {
         var c:int = 101;
         c = c + this.time % (this.deaths + 7);
         c = c - this.time;
         c = c + this.deaths % 149;
         c = c + this.time % 3571;
         c = c + this.levelNum * this.deaths % 41;
         c = c + (this.mode + 3) * 1279;
         c = c + this.levelNum % (this.mode + 1) * 7;
         for(var i:int = 0; i < Assets.TOTAL_LEVELS[this.mode]; i++)
         {
            c = c + (this.deaths_stage[i] + this.time_stage[i]) % 239;
            c = c - this.deaths_stage[i] * i;
            c = c + this.time_stage[i] % Math.pow(i + 1,2);
            c = c + this.time_stage[i] % this.deaths_stage[i];
         }
         return c;
      }
      
      public function updateChecksum() : void
      {
         this.check = this.getChecksum();
      }
      
      public function getTimePlus(num:uint) : String
      {
         var time:uint = this.time + num;
         var sec:Number = time % (60 * 60);
         sec = sec / 60;
         var str:String = sec.toFixed(2);
         if(sec < 10)
         {
            str = "0" + str;
         }
         str = ":" + str;
         var blah:uint = Math.floor(time / (60 * 60));
         str = String(blah) + str;
         return str;
      }
   }
}
