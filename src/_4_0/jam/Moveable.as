package _4_0.jam
{
   import _4_0.punk.Actor;
   import _4_0.punk.core.Entity;
   
   public class Moveable extends Actor
   {
       
      
      private var hCounter:Number = 0;
      
      private var vCounter:Number = 0;
      
      public function Moveable()
      {
         super();
      }
      
      public function moveV(num:Number, onCollide:Function = null) : void
      {
         var s:Entity = null;
         this.vCounter = this.vCounter + num;
         var go:int = Math.round(this.vCounter);
         this.vCounter = this.vCounter - go;
         var sign:int = go > 0?1:-1;
         while(go != 0)
         {
            if((s = collide("solid",x,y + sign)) != null)
            {
               if(onCollide != null)
               {
                  onCollide(s as Block);
               }
               return;
            }
            y = y + sign;
            go = go - sign;
         }
      }
      
      public function moveH(num:Number, onCollide:Function = null) : void
      {
         var go:int = 0;
         var sign:int = 0;
         var s:Entity = null;
         this.hCounter = this.hCounter + num;
         go = Math.round(this.hCounter);
         this.hCounter = this.hCounter - go;
         sign = go > 0?1:-1;
         while(go != 0)
         {
            if((s = collide("solid",x + sign,y)) != null)
            {
               if(onCollide != null)
               {
                  onCollide(s as Block);
               }
               return;
            }
            x = x + sign;
            go = go - sign;
         }
      }
      
      protected function getBelow() : Block
      {
         var obj:Entity = null;
         if((obj = collide("solid",x,y + 1)) != null)
         {
            return obj as Block;
         }
         return null;
      }
   }
}
