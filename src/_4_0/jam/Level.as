package _4_0.jam
{
	import _4_0.FP;
	import _4_0.Library;
	import _4_0.Main;
	import flash.system.System;
	import flash.utils.ByteArray;
	import _4_0.punk.Backdrop;
	import _4_0.punk.Text;
	import _4_0.punk.core.Alarm;
	import _4_0.punk.core.Entity;
	import _4_0.punk.core.World;
	import _4_0.punk.util.Input;
	
	public class Level extends World
	{
		
		public static const ImgBG:Class =_4_0.Library.Preloader_ImgBG;
		
		private var bg:Backdrop;
		
		public var shake:Boolean = false;
		
		private var countTime:Boolean = true;
		
		public var width:uint;
		
		public var levelText:Text;
		
		public var time:uint;
		
		public var shakeAmount:uint;
		
		private var xml:XML;
		
		private var timer:Text;
		
		public var player:Player;
		
		public var levelNum:uint;
		
		public var height:uint;
		
		public var particles:Vector.<Particle>;
		
		private var alarmShake:Alarm;
		
		private var alarmRestart:Alarm;
		
		public function Level(num:uint)
		{
			this.alarmShake = new Alarm(1, this.onAlarmShake, Alarm.PERSIST);
			this.alarmRestart = new Alarm(40, this.onAlarmRestart, Alarm.PERSIST);
			super();
			this.particles = new Vector.<Particle>();
			this.levelNum = num;
			this.getXML();
			addAlarm(this.alarmRestart, false);
			addAlarm(this.alarmShake, false);
		}
		
		public function die():void
		{
			if (this.player == null)
			{
				return;
			}
			_4_0.Main.instance.LevelDie(this);
			
			Assets.playGoodJob();
			remove(this.player);
			this.player = null;
			Stats.saveData.addDeath();
			Stats.saveData.addTime((_4_0.FP.world as Level).time);
			this.time = 0;
			this.countTime = false;
			this.alarmRestart.start();
		}
		
		override public function update():void
		{
			if (this.countTime)
			{
				this.time++;
			}
			this.bg.x = this.bg.x - 0.25;
			this.bg.y = this.bg.y - 0.25;
			this.levelText.x = 20 + _4_0.FP.camera.x;
			this.levelText.y = 20 + _4_0.FP.camera.y;
			if (Assets.timer)
			{
				this.timer.text = Stats.saveData.getTimePlus(this.time);
				this.timer.x = 20 + _4_0.FP.camera.x;
				this.timer.y = 60 + _4_0.FP.camera.y;
			}
		}
		
		public function restart():void
		{
			_4_0.Main.instance.LevelRestart(this);
			
			this.clearParticles();
			removeAll();
			System.gc();
			this.build();
		}
		
		override public function init():void
		{
			_4_0.Main.instance.LevelInit(this);
			
			this.build();
		}
		
		private function onAlarmRestart():void
		{
			add(new FuzzTransition(FuzzTransition.RESTART));
		}
		
		public function createParticles(amount:uint, x:uint, y:uint, posRand:uint, color:uint, size:uint, sizeRand:uint, speed:Number, speedRand:Number, direction:Number, dirRand:Number, life:uint, lifeRand:uint, delay:uint = 0):void
		{
			var p:Particle = null;
			if (!Assets.particles)
			{
				return;
			}
			for (var i:int = 0; i < amount; i++)
			{
				if (this.particles.length == 0)
				{
					p = new Particle();
				}
				else
				{
					p = this.particles.pop();
				}
				p.setDraw(x - posRand + Math.random() * posRand * 2, y - posRand + Math.random() * posRand * 2, color, size - sizeRand + Math.random() * sizeRand * 2, speed - speedRand + Math.random() * speedRand * 2, direction - dirRand + Math.random() * dirRand * 2, life - lifeRand + Math.random() * lifeRand * 2, delay);
				add(p);
			}
		}
		
		public function win():void
		{
			if (this.player == null)
			{
				return;
			}
			
			_4_0.Main.instance.LevelWin(this);
			
			remove(this.player);
			this.player = null;
			Stats.saveData.addTime(this.time);
			this.time = 0;
			this.countTime = false;
			
			_4_0.FP.play (Assets.SndWin);
			
			/*
			   if (this.levelNum < Assets.TOTAL_LEVELS[Stats.saveData.mode])
			   {
			   if (this.levelNum == 1 && Stats.saveData.mode == 0)
			   {
			   FP.play(Assets.VcGiveUp10, Assets.VCVOL);
			   }
			   else
			   {
			   Assets.playGiveUp();
			   }
			   if (Stats.saveData.mode == 0 && this.levelNum % 10 == 0 || Stats.saveData.mode == 1 && this.levelNum == 5)
			   {
			   Input.Default ();
			
			   add(new FuzzTransition(FuzzTransition.MENU, SubmitMenu));
			   }
			   else
			   {
			   add(new FuzzTransition(FuzzTransition.GOTO_NEXT));
			   }
			   }
			   else
			   {
			   FP.play(Assets.VcEnding, Assets.VCVOL);
			   add(new FuzzTransition(FuzzTransition.GOTO_NEXT, null, true));
			   }
			 */
			
			// virandi
			// 2021.02.06
			
			_4_0.Main.instance.LevelWinSubmitMenu (this);
		}
		
		private function clearParticles():void
		{
			var p:Particle = null;
			var vec:Vector.<Entity> = getClass(Particle);
			for each (p in vec)
			{
				p.die();
			}
		}
		
		public function getXML():void
		{
			var file:ByteArray = new Assets[Assets.PREFIXES[Stats.saveData.mode] + this.levelNum]();
			this.xml = new XML(file.readUTFBytes(file.length));
		}
		
		private function onAlarmShake():void
		{
			this.shake = false;
		}
		
		public function _goto_Next():void
		{
			Main.instance.Level_goto_Next (this);
			
			return;
			
			this.levelNum++;
			if (this.levelNum > Assets.TOTAL_LEVELS[Stats.saveData.mode])
			{
				_4_0.FP._goto_ = new EndMenu();
				return;
			}
			this.getXML();
			this.restart();
		}
		
		public function _goto_Previous():void
		{
			this.levelNum = Math.max (1, --this.levelNum);
			
			this.getXML();
			this.restart();
		}
		
		public function screenShake(time:uint, amount:uint = 2):void
		{
			this.shake = true;
			this.shakeAmount = amount;
			this.alarmShake.totalFrames = time;
			this.alarmShake.start();
		}
		
		private function build():void
		{
			var o:XML = null;
			var h:int = 0;
			var vec:Vector.<Entity> = null;
			var e:Block = null;
			var yy:int = 0;
			var t:Text = null;
			Stats.saveData.levelNum = this.levelNum;
			Stats.save();
			this.width = this.xml.width[0];
			this.height = this.xml.height[0];
			for each (o in this.xml.solids[0].rect)
			{
				if (int(o.@y) + int(o.@h) == this.height)
				{
					h = int(o.@h) + 24;
				}
				else
				{
					h = int(o.@h);
				}
				add(new Block(o.@x, o.@y, o.@w, h));
			}
			for each (o in this.xml.objects[0].children())
			{
				if (o.localName() == "player")
				{
					yy = int(o.@y) + 3;
					add(this.player = new Player(this, o.@x, yy));
					add(new Spawn(o.@x, yy));
				}
				else if (o.localName() == "electricBlock")
				{
					if (int(o.@y) + int(o.@height) == this.height)
					{
						h = int(o.@height) + 24;
					}
					else
					{
						h = int(o.@height);
					}
					add(new ElectricBlock(o.@x, o.@y, o.@width, h));
				}
				else if (o.localName() == "saw")
				{
					add(new Saw(o.@x, o.@y, o.@flip == "true"));
				}
				else if (o.localName() == "fallingPlat")
				{
					add(new FallingPlat(o.@x, o.@y, o.@width, o.@height));
				}
				else if (o.localName() == "movingPlat")
				{
					add(new MovingPlat(o.@x, o.@y, o.@width, o.@height, o.node[0].@x, o.node[0].@y, o.@speed, o.@dontMove == "true", o.@stopAtEnd == "true"));
				}
			}
			add(new Block(-8, 0, 8, this.height));
			add(new Block(0, -8, this.width, 8));
			_4_0.FP.camera.setBounds(0, 0, this.width, this.height);
			_4_0.FP.camera.setOrigin(160, 120);
			_4_0.FP.camera.moveTo(this.player.x, this.player.y);
			vec = getClass(Block);
			for each (e in vec)
			{
				e.player = this.player;
				if (e is FallingPlat)
				{
					(e as FallingPlat).getEndY();
				}
			}
			if (Stats.saveData.mode == 0)
			{
				this.levelText = new Text("Level " + this.levelNum, 20, 20);
			}
			else
			{
				this.levelText = new Text("Hard " + this.levelNum, 20, 20);
			}
			this.levelText.depth = 100000;
			this.levelText.color = 3355443;
			this.levelText.size = 48;
			this.levelText.x = 20 + _4_0.FP.camera.x;
			this.levelText.y = 20 + _4_0.FP.camera.y;
			add(this.levelText);
			if (Assets.timer)
			{
				this.timer = new Text(Stats.saveData.formattedTime, 20, 60);
				this.timer.size = 24;
				this.timer.depth = 100000;
				this.timer.color = 2236962;
				this.timer.x = 20 + _4_0.FP.camera.x;
				this.timer.y = 60 + _4_0.FP.camera.y;
				add(this.timer);
			}
			if (Stats.saveData.mode == 0)
			{
				if (this.levelNum == 1)
				{
					t = new Text("LEFT / RIGHT to move\nX or S or UP to jump", 32, 146);
					t.depth = 100000;
					t.color = 3355443;
					t.size = 16;
					add(t);
					t = new Text("when jumping, hold it\nfor maximum height", 324, 128);
					t.depth = 100000;
					t.color = 3355443;
					t.size = 16;
					add(t);
					t = new Text("Z or A to grapple, then\nUP / DOWN to adjust\nand LEFT / RIGHT to swing", 704, 96);
					t.depth = 100000;
					t.color = 3355443;
					t.size = 16;
					add(t);
				}
				else if (this.levelNum == 2)
				{
					t = new Text("REMEMBER:\nZ or A to grapple, then\nUP / DOWN to adjust\nand LEFT / RIGHT to swing", 32, 116);
					t.depth = 100000;
					t.color = 3355443;
					t.size = 16;
					add(t);
				}
				else if (this.levelNum == 3)
				{
					t = new Text("RECALL:\nZ or A to grapple, then\nUP / DOWN to adjust\nand LEFT / RIGHT to swing", 56, 128);
					t.depth = 100000;
					t.color = 3355443;
					t.size = 16;
					add(t);
				}
				else if (this.levelNum == 4)
				{
					t = new Text("SERIOUSLY:\nZ or A to grapple, then\nUP / DOWN to adjust\nand LEFT / RIGHT to swing", 24, 116);
					t.depth = 100000;
					t.color = 3355443;
					t.size = 16;
					add(t);
				}
				else if (this.levelNum == 49)
				{
					t = new Text("Go for distance!", 128, 160);
					t.depth = 100000;
					t.color = 3355443;
					t.size = 16;
					add(t);
				}
			}
			add(this.bg = new Backdrop(ImgBG));
			add(new EndLine());
			if (Assets.fuzz != null)
			{
				add(Assets.fuzz);
				Assets.fuzz = null;
			}
			this.time = 0;
			this.countTime = true;
			
			_4_0.Main.instance.LevelBuild(this);
		}
	}
}
