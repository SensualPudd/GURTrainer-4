package _4_0.punk.core
{
   public class Alarm
   {
      
      public static const ONESHOT:int = 0;
      
      public static const PERSIST:int = 2;
      
      public static const LOOPING:int = 1;
       
      
      var _running:Boolean;
      
      var _added:Boolean;
      
      var _entity:Core;
      
      public var totalFrames:int;
      
      public var remainingFrames:int;
      
      var _prev:Alarm;
      
      var _next:Alarm;
      
      public var call:Function;
      
      public var type:int;
      
      public function Alarm(frames:int, call:Function, type:int = 0)
      {
         super();
         this._added = this._running = false;
         this.set(frames,call,type);
      }
      
      public function get isFinished() : Boolean
      {
         return !this._running && !this.remainingFrames;
      }
      
      function update() : void
      {
         var a:Alarm = this;
         var n:Alarm = this;
         while(a)
         {
            n = a._next;
            if(a._running)
            {
               a.remainingFrames--;
               if(!a.remainingFrames)
               {
                  a._entity.alarmLast = a;
                  if(a.type == ONESHOT)
                  {
                     if(a._next)
                     {
                        a._next._prev = a._prev;
                     }
                     if(a._prev)
                     {
                        a._prev._next = a._next;
                     }
                     if(a._entity._alarmFirst == a)
                     {
                        a._entity._alarmFirst = a._next;
                     }
                     a._next = a._prev = null;
                     a._entity = null;
                     a._added = a._running = false;
                  }
                  else if(a.type == LOOPING)
                  {
                     a.remainingFrames = a.totalFrames;
                  }
                  else if(a.type == PERSIST)
                  {
                     a._running = false;
                  }
                  a.call();
               }
            }
            a = n;
         }
      }
      
      public function stop() : Alarm
      {
         this._running = false;
         return this;
      }
      
      public function set(frames:int, call:Function, type:int = 0) : Alarm
      {
         this.remainingFrames = this.totalFrames = frames;
         this.call = call;
         this.type = type;
         return this;
      }
      
      public function start() : Alarm
      {
         this._running = true;
         this.remainingFrames = this.totalFrames;
         return this;
      }
      
      public function resume() : Alarm
      {
         if(this.type == LOOPING && !this.remainingFrames)
         {
            this.remainingFrames = this.totalFrames;
         }
         this._running = true;
         return this;
      }
      
      public function get isRunning() : Boolean
      {
         return this._running;
      }
   }
}
