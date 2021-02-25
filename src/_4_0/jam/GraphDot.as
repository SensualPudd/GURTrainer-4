package _4_0.jam
{
   import _4_0.FP;
   import _4_0.punk.Actor;
   
   public class GraphDot extends Actor
   {
       
      
      public var _goto_Y:uint;
      
      public function GraphDot()
      {
         super();
      }
      
      override public function update() : void
      {
         y = _4_0.FP.approach(y,this._goto_Y,Math.max(0.5,Math.abs(y - this._goto_Y) / 4));
      }
      
      override public function render() : void
      {
         drawRect(x - 1,y - 1,2,2,(_4_0.FP.world as StatsMenu).color);
      }
   }
}
