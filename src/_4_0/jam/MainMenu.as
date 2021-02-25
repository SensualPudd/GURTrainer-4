package _4_0.jam
{
	import _4_0.FP;
	import _4_0.Library;
	import _4_0.Main;
	import flash.display.StageDisplayState;
	import _4_0.punk.Acrobat;
	import _4_0.punk.Backdrop;
	import _4_0.punk.Text;
	import _4_0.punk.Textplus;
	import _4_0.punk.core.Alarm;
	import _4_0.punk.core.Engine;
	import _4_0.punk.core.Entity;
	import _4_0.punk.core.Spritemap;
	
	public class MainMenu extends MenuWorld
	{
		public static var instance:MainMenu = null;
		
		private static const ImgFP:Class = _4_0.Library.MainMenu_ImgFP;
		
		private static const ImgMMG:Class = _4_0.Library.MainMenu_ImgMMG;
		
		private static const SprMMG:Spritemap = _4_0.FP.getSprite(ImgMMG, 90, 32, false, false, 45, 16);
		
		private static const SprFP:Spritemap = _4_0.FP.getSprite(ImgFP, 89, 31, false, false, 45, 15);
		
		private var presAlarm:Alarm;
		
		private var bg:Backdrop;
		
		private var sss:Number = 0;
		
		private var title:FlashingText;
		
		private var canGo:Boolean = true;
		
		private var toRemove:Vector.<Entity>;
		
		private var pres:uint = 0;
		
		private var presents:Text;
		
		public function MainMenu()
		{
			this.presAlarm = new Alarm(120, this.onPres, Alarm.PERSIST);
			
			_4_0.FP.camera.setBounds(0, 0, 320.0, 240.0);
			_4_0.FP.camera.setOrigin(160, 120);
			_4_0.FP.camera.moveTo(0.0, 0.0);
			
			MainMenu.instance = this;
			
			super();
		}
		
		private function newGameNormal(m:MenuButton = null):void
		{
			Stats.resetStats();
			Stats.saveData.mode = 0;
			/*
			 * virandi
			 * 2021.02.06
			   if (Stats.exists())
			   {
			   this._goto_MenuConfirm();
			   }
			   else
			   {
			   this.newGame();
			   }
			 */
			this.newGame();
		}
		
		override public function update():void
		{
			super.update();
			this.sss = (this.sss + Math.PI / 16) % (Math.PI * 8);
			this.title.angle = Math.sin(this.sss / 4) * 10;
			this.title.scaleX = this.title.scaleY = Math.sin(this.sss / 2) * 0.2 + 0.8;
		}
		
		private function clearMenu():void
		{
			removeVector(this.toRemove);
			this.toRemove = new Vector.<Entity>();
		}
		
		override public function init():void
		{
			var a:Acrobat = null;
			var _loc2_:Text = null;
			super.init();
			addAlarm(this.presAlarm);
			//this.presents = new Text("Adult Swim Games Presents", 160, 40);
			this.presents = new Text("SensualPudding Presents", 160, 40);
			this.presents.color = 6710886;
			this.presents.depth = 1050;
			this.presents.size = 16;
			this.presents.center();
			add(this.presents);
			//this.title = new FlashingText("Give Up, ROBOT", 160, 64);
			//this.title = new FlashingText("Give Up Robot", 160, 72);
			this.title = new FlashingText("GUR Trainer 4.0", 160, 72);
			this.title.size = 36;
			this.title.depth = 1000;
			this.title.center();
			add(this.title);
			a = new Acrobat();
			a.sprite = DiscoBall.SprBall;
			a.scaleX = 4;
			a.scaleY = 4;
			a.alpha = 0.1;
			a.delay = 6;
			a.depth = 1000;
			a.x = 160;
			a.y = 120;
			add(a);
			a = new Acrobat();
			a.sprite = SprMMG;
			a.color = 16777215;
			a.x = 46;
			a.y = 223;
			a.scaleX = 1;
			a.scaleY = 1;
			add(a);
			a = new Acrobat();
			a.sprite = SprFP;
			a.color = 16777215;
			a.x = 274;
			a.y = 224;
			a.scaleX = 1;
			a.scaleY = 1;
			add(a);
			_4_0.FP.musicPlay(Assets.MusMenu);
			this.toRemove = new Vector.<Entity>();
			this._goto_MenuMain();
			
			Engine.flash = true;
			
			Main.instance.v.level_select = false;
			Main.instance.v.level_select_number = null;
			Main.instance.v.level_select_repeat = false;
			
			var i:int = 0;
			
			for (i = 0; i != Assets.NAMES.length; ++i)
			{
				Main.instance.v.level_time [Assets.NAMES[i]] = new Array ();
				Main.instance.v.level_time [Assets.NAMES[i]].length = Assets.TOTAL_LEVELS [i];
			}
			
			MainMenu.instance = this;
		}
		
		private function toggleTimer(m:MenuButton):void
		{
			Assets.timer = !Assets.timer;
			if (Assets.timer)
			{
				m.text = "Game Timer : On";
			}
			else
			{
				m.text = "Game Timer : Off";
			}
			m.center();
			
			_4_0.Main.instance.config.OPTIONS.GAME_TIMER = Assets.timer;
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
		}
		
		private function loadStats(m:MenuButton = null):void
		{
			if (!Stats.exists() || !this.canGo)
			{
				return;
			}
			Stats.load();
			this._goto_MenuContinue();
		}
		
		private function _goto_MenuLevelSelect(m:MenuButton = null):void
		{
			Main.instance.v.level_select = false;
			Main.instance.v.level_select_repeat = false;
			
			this.clearMenu();
			
			this.title.visible = true;
			this.presents.visible = true;
			
			this.toRemove.push(this.add(new MenuButton("Normal", 160, 140, this._goto_LevelNormalSelect)));
			this.toRemove.push(this.add(new MenuButton("Hard", 160, 160, this._goto_LevelHardSelect)));
			//this.toRemove.push(this.add(new MenuButton("Custom", 160, 180, this._goto_LevelCustomSelect)));
			this.toRemove.push(this.add(new MenuButton("Back", 160, 220, this._goto_MenuMain)));
		}
		
		public function _goto_LevelNormalSelect(m:MenuButton = null):void
		{
			var n = 0;
			
			var x:int = 0;
			
			var y:int = 0;
			
			this.clearMenu();
			
			for (var i:int = n; i != Math.min ((n + 50), Assets.TOTAL_LEVELS[0]); ++i)
			{
				x = (((i - n) % 10) * 20);
				
				y = int(Math.floor((i - n) / 10) * 20.0);
				
				this.toRemove.push (this.add(new MenuButton((i + 1).toString(), x + 70, y + 90, this._goto_LevelNormal, 12, 10)));
			}
			
			this.toRemove.push(this.add(new MenuButton((Main.instance.v.level_select_repeat ? this.RepeatLevelText (true) : this.RepeatLevelText (false)), 160, 200, function(m:MenuButton = null):void
			{
				Main.instance.v.level_select_repeat = !Main.instance.v.level_select_repeat;
				
				m._text.text = Main.instance.v.level_select_repeat ? MainMenu.instance.RepeatLevelText (true) : MainMenu.instance.RepeatLevelText (false);
				
				m.prepare();
				m.center();
				
				return;
			}, 12, 60)));
			
			this.toRemove.push(this.add(new MenuButton("Back", 160, 220, this._goto_MenuLevelSelect)));
			
			return;
		}
		
		public function _goto_LevelHardSelect(m:MenuButton = null):void
		{
			var n = 0;
			
			var x:int = 0;
			
			var y:int = 0;
			
			this.clearMenu();
			
			for (var i:int = n; i != Math.min ((n + 50), Assets.TOTAL_LEVELS[1]); ++i)
			{
				x = (((i - n) % 10) * 20);
				
				y = int(Math.floor((i - n) / 10) * 20.0);
				
				this.toRemove.push(this.add(new MenuButton((i + 1).toString(), x + 70, y + 90, this._goto_LevelHard, 12, 10)));
			}
			
			this.toRemove.push(this.add(new MenuButton((Main.instance.v.level_select_repeat ? this.RepeatLevelText (true) : this.RepeatLevelText (false)), 160, 200, function(m:MenuButton = null):void
			{
				Main.instance.v.level_select_repeat = !Main.instance.v.level_select_repeat;
				
				m._text.text = Main.instance.v.level_select_repeat ? MainMenu.instance.RepeatLevelText (true) : MainMenu.instance.RepeatLevelText (false);
				
				m.prepare();
				m.center();
				
				return;
			}, 12, 60)));
			
			this.toRemove.push(this.add(new MenuButton("Back", 160, 220, this._goto_MenuLevelSelect)));
			
			return;
		}
		
		public function _goto_LevelNormal(m:MenuButton = null):void
		{
			_4_0.Main.instance.v.level_select = true;
			_4_0.Main.instance.v.level_select_number = int (m._text.text);
			
			Stats.resetStats();
			Stats.saveData.mode = 0;
			
			this.newGameSelect();
			
			return;
		}
		
		public function _goto_LevelHard(m:MenuButton = null):void
		{
			_4_0.Main.instance.v.level_select = true;
			_4_0.Main.instance.v.level_select_number = int (m._text.text);
			
			Stats.resetStats();
			Stats.saveData.mode = 1;
			
			this.newGameSelect();
			
			return;
		}
		
		public function newGameSelect(m:MenuButton = null):void
		{
			if (!this.canGo)
			{
				return;
			}
			
			if (Stats.saveData.mode == 0)
			{
				_4_0.FP.play(Assets.SndNewGame);
			}
			else
			{
				_4_0.FP.play(Assets.SndHardGame);
			}
			
			this.canGo = false;
			
			_4_0.FP.musicStop();
			_4_0.FP.musicPlay(Assets.MusGame);
			
			Engine.flash = true;
			
			this.add(new FuzzTransition(FuzzTransition.NEW, null, true, _4_0.Main.instance.v.level_select_number));
			
			return;
		}
		
		private function _goto_MenuOptions(m:MenuButton = null):void
		{
			var text:Text = new Text ("OPTIONS", 160.0, 20.0);
			
			text.color = 6710886;
			text.depth = 1050;
			text.size = 16;
			text.center();
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(null);
			
			this.presents.visible = false;
			
			this.title.visible = false;
			
			this.clearMenu();
			this.toRemove.push (add (text));
			this.toRemove.push(add(new MenuButton("Music : " + (_4_0.FP.musicVolume * 100).toFixed(0) + "%", 160, 60, this.musicVolume)));
			this.toRemove.push(add(new MenuButton("Sounds : " + (_4_0.FP.soundVolume * 100).toFixed(0) + "%", 160, 80, this.soundVolume)));
			this.toRemove.push(add(new MenuButton("Particles : " + (!!Assets.particles ? "On" : "Off"), 160, 100, this.toggleParticles)));
			this.toRemove.push(add(new MenuButton("Game Timer : " + (!!Assets.timer ? "On" : "Off"), 160, 120, this.toggleTimer)));
			this.toRemove.push(add(new MenuButton (this.ScoreScreenText (), 160, 140, this.ScoreScreen)));
			this.toRemove.push(add(new MenuButton("Save Replay : " + (!!(_4_0.Main.instance.config.OPTIONS.SAVE_REPLAY == true) ? "On" : "Off"), 160, 160, this.SaveReplay)));
			this.toRemove.push(add(new MenuButton("Fullscreen : " + (!!(_4_0.Main.instance.config.OPTIONS.FULLSCREEN == true) ? "On" : "Off"), 160, 180, this.Fullscreen)));
			//this.toRemove.push(add(new MenuButton("Show IL Times : " + (!!(_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES == true) ? "On" : "Off"), 160, 160, this.ShowILTimes)));
			//this.toRemove.push(add(new MenuButton("Show Segment Time : " + (!!(_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == true) ? "On" : "Off"), 160, 180, this.ShowSegmentTime)));
			//this.toRemove.push(add(new MenuButton("Level Clear Sound : " + (!!(_4_0.Main.instance.config.OPTIONS.LEVEL_CLEAR_SOUND == true) ? "On" : "Off"), 160, 190, this.LevelClearSound)));
			//this.toRemove.push(add(new MenuButton("Keyboard : " + (!!(Main.instance.config.OPTIONS.KEYBOARD == true) ? "On" : "Off"), 160, 160, this.Keyboard)));
			//this.toRemove.push(add(new MenuButton("TAS : " + (!!(Main.instance.config.OPTIONS.TAS == true) ? "On" : "Off"), 160, 180, this.T_A_S)));
			this.toRemove.push(add(new MenuButton("Back", 160, 220, this._goto_MenuMain)));
		}
		
		public function Fullscreen(m:MenuButton):void
		{
			switch (_4_0.Main.instance.stage.displayState)
			{
			case StageDisplayState.NORMAL: 
			{
				m.text = "Fullscreen : On";
				
				_4_0.Main.instance.config.OPTIONS.FULLSCREEN = true;
				
				_4_0.Main.instance.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				
				break;
			}
			case StageDisplayState.FULL_SCREEN_INTERACTIVE: 
			{
				m.text = "Fullscreen : Off";
				
				_4_0.Main.instance.config.OPTIONS.FULLSCREEN = false;
				
				_4_0.Main.instance.stage.displayState = StageDisplayState.NORMAL;
				
				break;
			}
			default: 
			{
				break;
			}
			}
			
			m.center();
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
			
			return;
		}
		
		public function RepeatLevelText (flag:Boolean) : String 
		{
			var string:String = null;
			
			if (Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false)
			{
				string = "Repeat Level ";
			}
			else
			{
				string = "Repeat Segment ";
			}
			
			if (flag == false)
			{
				string = (string + "[ ]");
			}
			else
			{
				string = (string + "[V]");
			}
			
			return string;
		}
		
		public function SaveReplay(m:MenuButton):void
		{
			_4_0.Main.instance.config.OPTIONS.SAVE_REPLAY = !_4_0.Main.instance.config.OPTIONS.SAVE_REPLAY;
			
			switch (_4_0.Main.instance.config.OPTIONS.SAVE_REPLAY)
			{
				case false: 
				{
					m.text = "Save Replay : Off";
					
					break;
				}
				case true: 
				{
					m.text = "Save Replay : On";
					
					break;
				}
				default: 
				{
					break;
				}
			}
			
			m.center();
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
			
			return;
		}
		
		public function ScoreScreen (m:Object) : void 
		{
			if ((_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES == true) && (_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false))
			{
				_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES = false;
				_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME = true;
			}
			else if ((_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES == false) && (_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == true))
			{
				_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES = false;
				_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME = false;
			}
			else if ((_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES == false) && (_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false))
			{
				_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES = true;
				_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME = false;
			}
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
			
			m.text = this.ScoreScreenText ();
			
			m.center ();
			
			trace (m.text);
			
			return;
		}
		
		public function ScoreScreenText () : String 
		{
			var text:String = null;
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config (null);
			
			if ((_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES == true) && (_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false))
			{
				text = "IL";
			}
			else if ((_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES == false) && (_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == true))
			{
				text = "Segment";
			}
			else if ((_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES == false) && (_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false))
			{
				text = "Normal";
			}
			
			text = ("Score Screen : " + text);
			
			return text;
		}
		
		public function ShowILTimes(m:Object):void
		{
			_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES = !_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES;
			
			switch (_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES)
			{
				case false: 
				{
					m.text = "Show IL Times : Off";
					
					break;
				}
				case true: 
				{
					m.text = "Show IL Times : On";
					
					break;
				}
				default: 
				{
					break;
				}
			}
			
			m.center();
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
			
			switch (_4_0.Main.instance.config.OPTIONS.SHOW_IL_TIMES)
			{
				case false: 
				{
					break;
				}
				case true: 
				{
					for each (m in this.toRemove)
					{
						if (m is MenuButton)
						{
							if (m.text == "Show Segment Time : On")
							{
								this.ShowSegmentTime (m);
								
								break;
							}
						}
					}
					
					break;
				}
				default: 
				{
					break;
				}
			}
			
			return;
		}
		
		public function ShowSegmentTime(m:Object):void
		{
			_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME = !_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME;
			
			switch (_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME)
			{
				case false: 
				{
					m.text = "Show Segment Time : Off";
					
					break;
				}
				case true: 
				{
					m.text = "Show Segment Time : On";
					
					break;
				}
				default: 
				{
					break;
				}
			}
			
			m.center();
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
			
			switch (_4_0.Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME)
			{
				case false: 
				{
					break;
				}
				case true: 
				{
					for each (m in this.toRemove)
					{
						if (m is MenuButton)
						{
							if (m.text == "Show IL Times : On")
							{
								this.ShowILTimes (m);
								
								break;
							}
						}
					}
					
					break;
				}
				default: 
				{
					break;
				}
			}
			
			return;
		}
		
		public function LevelClearSound(m:MenuButton):void
		{
			_4_0.Main.instance.config.OPTIONS.LEVEL_CLEAR_SOUND = !_4_0.Main.instance.config.OPTIONS.LEVEL_CLEAR_SOUND;
			
			switch (_4_0.Main.instance.config.OPTIONS.LEVEL_CLEAR_SOUND)
			{
				case false: 
				{
					m.text = "Level Clear Sound : Off";
					
					break;
				}
				case true: 
				{
					m.text = "Level Clear Sound : On";
					
					break;
				}
				default: 
				{
					break;
				}
			}
			
			m.center();
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
			
			return;
		}
		
		public function Keyboard(m:MenuButton):void
		{
			_4_0.Main.instance.config.OPTIONS.KEYBOARD = !_4_0.Main.instance.config.OPTIONS.KEYBOARD;
			
			switch (_4_0.Main.instance.config.OPTIONS.KEYBOARD)
			{
				case false: 
				{
					m.text = "Keyboard : Off";
					
					break;
				}
				case true: 
				{
					m.text = "Keyboard : On";
					
					break;
				}
				default: 
				{
					break;
				}
			}
			
			m.center();
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
			
			return;
		}
		
		public function T_A_S(m:MenuButton):void
		{
			_4_0.Main.instance.config.OPTIONS.TAS = !_4_0.Main.instance.config.OPTIONS.TAS;
			
			switch (_4_0.Main.instance.config.OPTIONS.TAS)
			{
			case false: 
			{
				m.text = "TAS : Off";
				
				break;
			}
			case true: 
			{
				m.text = "TAS : On";
				
				break;
			}
			default: 
			{
				break;
			}
			}
			
			m.center();
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
			
			return;
		}
		
		private function _goto_MenuCredits(m:MenuButton = null):void
		{
			var t:Text = null;
			this.clearMenu();
			this.title.visible = false;
			this.presents.visible = false;
			t = new Text("graphics, audio,", 160, 22);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("programming and design by", 160, 28);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("Matt Thorson", 160, 40);
			t.size = 16;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("with additional graphics,", 160, 60);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("design and testing by", 160, 66);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("Coriander Dickinson", 160, 78);
			t.size = 16;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("and voices by", 160, 98);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("Rachel Williamson", 160, 110);
			t.size = 16;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("based on a prototype", 160, 130);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("developed at", 160, 138);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("Edmonton Game Jam 2010", 160, 150);
			t.size = 16;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("presented by", 160, 170);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("Adult Swim Games", 160, 182);
			t.size = 16;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			this.toRemove.push(add(new MenuButton("Back", 160, 220, this._goto_MenuMain)));
		}
		
		private function musicVolume(m:MenuButton):void
		{
			if (_4_0.FP.musicVolume == 0)
			{
				_4_0.FP.musicVolume = 1;
			}
			else
			{
				_4_0.FP.musicVolume = _4_0.FP.musicVolume - 0.25;
			}
			if (_4_0.FP.musicVolume == 0)
			{
				m.text = "Music : Off";
			}
			else
			{
				m.text = "Music : " + (_4_0.FP.musicVolume * 100).toFixed(0) + "%";
			}
			m.center();
			
			_4_0.Main.instance.config.OPTIONS.MUSIC = _4_0.FP.musicVolume;
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
		}
		
		private function soundVolume(m:MenuButton):void
		{
			if (_4_0.FP.soundVolume == 0)
			{
				_4_0.FP.soundVolume = 1;
			}
			else
			{
				_4_0.FP.soundVolume = _4_0.FP.soundVolume - 0.25;
			}
			if (_4_0.FP.soundVolume == 0)
			{
				m.text = "Sounds : Off";
			}
			else
			{
				m.text = "Sounds : " + (_4_0.FP.soundVolume * 100).toFixed(0) + "%";
			}
			m.center();
			
			_4_0.Main.instance.config.OPTIONS.SOUNDS = _4_0.FP.soundVolume;
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
		}
		
		private function _goto_MenuContinue(m:MenuButton = null):void
		{
			var t:Text = null;
			this.clearMenu();
			t = new Text(Assets.NAMES[Stats.saveData.mode] + " Mode", 160, 120);
			t.size = 16;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("Level " + Stats.saveData.levelNum, 160, 135);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text(Stats.saveData.deaths + " Deaths", 160, 145);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text(Stats.saveData.formattedTime, 160, 155);
			t.size = 8;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			this.toRemove.push(add(new MenuButton("Continue", 160, 180, this.loadGame)));
			this.toRemove.push(add(new MenuButton("Cancel", 160, 200, this._goto_MenuMain)));
		}
		
		private function onPres():void
		{
			if (!this.canGo)
			{
				return;
			}
			if (this.pres == 0)
			{
				_4_0.FP.play(Assets.VcPresents, Assets.VCVOL);
				this.presAlarm.totalFrames = 140;
				this.presAlarm.start();
				this.pres++;
			}
			else if (this.pres == 1)
			{
				_4_0.FP.play(Assets.VcBestEver, Assets.VCVOL);
				removeAlarm(this.presAlarm);
			}
		}
		
		private function newGame(m:MenuButton = null):void
		{
			if (!this.canGo)
			{
				return;
			}
			if (Stats.saveData.mode == 0)
			{
				_4_0.FP.play(Assets.SndNewGame);
			}
			else
			{
				_4_0.FP.play(Assets.SndHardGame);
			}
			this.canGo = false;
			_4_0.FP.musicStop();
			add(new FuzzTransition(FuzzTransition.MENU, Intro, true));
		}
		
		private function loadGame(m:MenuButton = null):void
		{
			if (!this.canGo)
			{
				return;
			}
			if (Stats.saveData.mode == 0)
			{
				_4_0.FP.play(Assets.SndNewGame);
			}
			else
			{
				_4_0.FP.play(Assets.SndHardGame);
			}
			this.canGo = false;
			Assets.playLoad();
			_4_0.FP.musicPlay(Assets.MusGame);
			add(new FuzzTransition(FuzzTransition.LOAD));
		}
		
		private function toggleParticles(m:MenuButton):void
		{
			Assets.particles = !Assets.particles;
			if (Assets.particles)
			{
				m.text = "Particles : On";
			}
			else
			{
				m.text = "Particles : Off";
			}
			m.center();
			
			_4_0.Main.instance.config.OPTIONS.PARTICLES = Assets.particles;
			
			_4_0.Main.instance.config = _4_0.Main.instance.Config(_4_0.Main.instance.config);
		}
		
		private function _goto_MenuMain(m:MenuButton = null):void
		{
			var t:Text = null;
			this.clearMenu();
			this.title.visible = true;
			this.presents.visible = true;
			this.toRemove.push(add(new MenuButton("New Game", 160, 120, this.newGameNormal)));
			if (Stats.haveHardMode())
			{
				this.toRemove.push(add(new MenuButton("New HARD Game", 160, 140, this.newGameHard)));
			}
			else
			{
				t = new Text("New HARD Game", 160, 140);
				t.color = 3355443;
				t.size = 16;
				t.center();
				this.toRemove.push(add(t));
			}
			
			/*
			 * virandi
			 * 2021.02.06
			   if (Stats.exists())
			   {
			   this.toRemove.push(add(new MenuButton("Continue", 160, 160, this.loadStats)));
			   }
			   else
			   {
			   t = new Text("Continue", 160, 160);
			   t.color = 3355443;
			   t.size = 16;
			   t.center();
			   this.toRemove.push(add(t));
			   }
			 */
			
			this.toRemove.push(add(new MenuButton("Level Select", 160, 180, this._goto_MenuLevelSelect)));
			
			this.toRemove.push(add(new MenuButton("Options", 160, 200, this._goto_MenuOptions)));
			//this.toRemove.push(add(new MenuButton("Credits", 160, 210, this._goto_MenuCredits)));
		}
		
		private function newGameHard(m:MenuButton = null):void
		{
			//Stats.resetStats();
			//Stats.saveData.mode = 1;
			//if (Stats.exists())
			//{
				//this._goto_MenuConfirm();
			//}
			//else
			//{
				//this.newGame();
			//}
			
			Stats.resetStats();
			Stats.saveData.mode = 1;
			
			this.newGame();
		}
		
		private function _goto_MenuConfirm(m:MenuButton = null):void
		{
			this.clearMenu();
			var t:Text = new Text("Are You Sure?", 160, 120);
			t.size = 24;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			t = new Text("Current savefile will be deleted!", 160, 140);
			t.size = 16;
			t.color = 16777215;
			t.center();
			this.toRemove.push(add(t));
			this.toRemove.push(add(new MenuButton("Do It!", 160, 180, this.newGame)));
			this.toRemove.push(add(new MenuButton("Cancel", 160, 200, this._goto_MenuMain)));
		}
	}
}
