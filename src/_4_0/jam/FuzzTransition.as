package _4_0.jam
{
	import _4_0.FP;
	import _4_0.Main;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import _4_0.punk.Textplus;
	import _4_0.punk.core.Entity;
	
	public class FuzzTransition extends Entity
	{
		
		public static const NEW:uint = 4;
		
		public static const MENU:uint = 2;
		
		public static const GOTO_NEXT:uint = 0;
		
		public static const GOTO_PREVIOUS:uint = uint.MAX_VALUE;
		
		public static const LOAD:uint = 3;
		
		public static const RESTART:uint = 1;
		
		private var bitmapData:BitmapData;
		
		private var lvl:uint;
		
		private var _goto_:Class;
		
		private var colorTransform:ColorTransform;
		
		private var mode:uint;
		
		private var long:Boolean;
		
		private var up:Boolean = true;
		
		private var alpha:Number = 0;
		
		public function FuzzTransition(mode:uint, _goto_:Class = null, long:Boolean = false, lvl:uint = 1)
		{
			var t:Textplus = null;
			super();
			this.mode = mode;
			this._goto_ = _goto_;
			this.long = long;
			this.lvl = lvl;
			this.bitmapData = new BitmapData(320, 240);
			this.colorTransform = new ColorTransform(1, 1, 1, 0);
			depth = -500000000;
			if ((mode == GOTO_NEXT) || (mode == GOTO_PREVIOUS) || (mode == RESTART))
			{
				t = new Textplus("Give Up, ROBOT", _4_0.FP.camera.x + 160, _4_0.FP.camera.y + 120);
				t.size = 36;
				t.angle = 290 + Math.random() * 140;
				t.color = 16777215;
				t.depth = -500000001;
				t.center();
				_4_0.FP.world.add(t);
			}
		}
		
		override public function update():void
		{
			_4_0.Main.instance.FuzzTransitionUpdate (this, this.mode);
			
			if (this.up)
			{
				if (this.long)
				{
					this.alpha = this.alpha + 0.02;
				}
				else
				{
					this.alpha = this.alpha + 0.1;
				}
				if (this.alpha >= 1.5)
				{
					this.up = false;
					Assets.fuzz = this;
					if (this.mode == GOTO_NEXT)
					{
						(_4_0.FP.world as Level)._goto_Next();
					}
					else if (this.mode == GOTO_PREVIOUS)
					{
						(_4_0.FP.world as Level)._goto_Previous();
					}
					else if (this.mode == RESTART)
					{
						((_4_0.FP.world is Level) ? (_4_0.FP.world as Level).restart () : null);
						
						_4_0.FP.world.add(this);
					}
					else if (this.mode == MENU)
					{
						_4_0.FP._goto_ = new this._goto_();
					}
					else if (this.mode == LOAD)
					{
						_4_0.FP._goto_ = new Level(Stats.saveData.levelNum);
					}
					else if (this.mode == NEW)
					{
						_4_0.FP._goto_ = new Level(this.lvl);
					}
				}
			}
			else
			{
				if (this.long)
				{
					this.alpha = this.alpha - 0.02;
				}
				else
				{
					this.alpha = this.alpha - 0.1;
				}
				if (this.alpha <= 0)
				{
					_4_0.FP.world.remove(this);
				}
			}
		}
		
		override public function render():void
		{
			this.bitmapData.noise(Math.random() * 100);
			this.colorTransform.alphaMultiplier = this.alpha;
			_4_0.FP.screen.draw(this.bitmapData, null, this.colorTransform);
		}
	}
}
