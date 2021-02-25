package _4_0.jam
{
	import _4_0.FP;
	import _4_0.punk.Textplus;
	import _4_0.punk.util.Input;
	
	public class MenuButton extends Textplus
	{
		
		private var mouseOn:Boolean = false;
		
		private var callback:Function;
		
		private var sine:Number;
		
		public var w:int = 0;
		
		public function MenuButton(str:String, x:int, y:int, callback:Function, size:int = 16, width:int = 60)
		{
			super(str, x, y);
			this.callback = callback;
			this.w = width;
			this.size = size;
			this.sine = _4_0.FP.choose(0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5) * Math.PI;
			center();
		}
		
		private function particleBurst():void
		{
			var ax:int = 0;
			for (var i:int = 0; i < 2; i++)
			{
				ax = _4_0.FP.choose(-60, -45, -30, -15, 0, 15, 30, 45, 60);
				(_4_0.FP.world as MenuWorld).createParticles(1, x + ax, y, 10, 16777215, 2, 1, 1.5, 0.5, 0, 180, 12, 4);
			}
		}
		
		override public function update():void
		{
			if (Input.mouseX > x - this.w && Input.mouseX < x + this.w && Input.mouseY > y - 9 && Input.mouseY < y + 9)
			{
				if (!this.mouseOn)
				{
					this.mouseOn = true;
					_4_0.FP.play(Assets.SndMouse);
				}
				this.particleBurst();
				color = 16777215;
				this.sine = (this.sine + Math.PI / 32) % (Math.PI * 4);
				angle = Math.sin(this.sine) * 6;
				scaleX = scaleY = 1.3 + Math.sin(this.sine / 2) * 0.1;
				if (Input.mousePressed && this.callback != null)
				{
					this.callback(this);
					if (text == "Cancel")
					{
						_4_0.FP.play(Assets.SndDeselect);
					}
					else
					{
						_4_0.FP.play(Assets.SndSelect);
					}
				}
			}
			else
			{
				this.mouseOn = false;
				this.sine = (this.sine + Math.PI / 64) % (Math.PI * 4);
				color = 8947848;
				angle = Math.sin(this.sine) * 2;
				scaleX = scaleY = 1 + Math.sin(this.sine / 2) * 0.05;
			}
		}
	}
}
