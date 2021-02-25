
package _4_0.punk.logo
{
	import _4_0.FP;
	import _4_0.punk.core.World;
	
	public class Splash extends World
	{
		
		public static var front:uint = 16724838;
		
		public static var link:Boolean = false;
		
		public static var back:uint = 2105376;
		
		public static var volume:Number;
		
		public static var show:Boolean = false;
		
		private var _text:LogoText;
		
		private var _logoY:int;
		
		private var _world:Class = null;
		
		private var _logoX:int;
		
		private var _cogs:LogoCogs;
		
		private var _pow:LogoPow;
		
		public function Splash(world:Class = null)
		{
			super();
			if (world == null)
			{
				world = World;
			}
			this._world = world;
		}
		
		override public function update():void
		{
			if (this._text._fadeOut)
			{
				this._cogs.alpha = this._text.alpha;
			}
			if (this._text._endWait > 9)
			{
				_4_0.FP._goto_ = new this._world();
			}
		}
		
		override public function init():void
		{
			_4_0.FP.screen.color = back;
			this._logoX = _4_0.FP.screen.width / 2 - 34;
			this._logoY = _4_0.FP.screen.height / 1.5 - 27;
			this._cogs = new LogoCogs();
			this._cogs.x = this._cogs.x + this._logoX;
			this._cogs.y = this._cogs.y + this._logoY;
			this._text = new LogoText();
			this._text.x = this._text.x + this._logoX;
			this._text.y = this._text.y + this._logoY;
			this._pow = new LogoPow(this._cogs, this._text);
			this._pow.x = this._pow.x + this._logoX;
			this._pow.y = this._pow.y + this._logoY;
			add(this._pow);
		}
		
		override public function render():void
		{
		}
	}
}
