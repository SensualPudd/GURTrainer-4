package _4_0
{
	import _4_0.FP;
	import _4_0.Library;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import _4_0.jam.Assets;
	import _4_0.jam.FuzzTransition;
	import _4_0.jam.Level;
	import _4_0.jam.MainMenu;
	import _4_0.jam.Stats;
	import _4_0.jam.SubmitMenu;
	import _4_0.punk.core.Engine;
	import _4_0.punk.core.World;
	import _4_0.punk.util.Input;
	import _4_0.punk.util.Key;
	
	public class Main extends Engine
	{
		static public var instance:Main = null;
		
		public function get Height():uint
		{
			return 480;
		}
		
		public function get Width():uint
		{
			return 640;
		}
		
		public var config:Object = null;
		
		public var main_menu:MainMenu = null;
		
		public var statz:Object = null;
		
		public var v:Object = null;
		
		public var MC_BUTTON_BUY_ME_A_COFFEE:MovieClip = null;
		
		public var MC_ELIGIBLE_FOR_IL_LEADERBOARDS:MovieClip = null;
		
		public var MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS:MovieClip = null;
		
		public var MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS:MovieClip = null;
		
		public var MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS:MovieClip = null;
		
		public function Main()
		{
			Main.instance = this;
			
			Main.instance.CheckUp ("CONFIG.txt", false);
			
			Main.instance.CheckUp ("STATZ.txt", false);
			
			Main.instance.config = Main.instance.Config(null);
			
			Main.instance.statz = Main.instance.Statz(null);
			
			Main.instance.stage.addEventListener(Event.ENTER_FRAME, this.HandleEvent);
			Main.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.HandleEvent);
			Main.instance.stage.addEventListener(KeyboardEvent.KEY_UP, this.HandleEvent);
			
			super(320, 240, 60, 2, MainMenu);
		}
		
		override public function init():void
		{
			Input.define("down", Key.DOWN);
			Input.define("grapple", Key.Z, Key.A);
			Input.define("jump", Key.X, Key.UP, Key.S);
			Input.define("left", Key.LEFT);
			Input.define("right", Key.RIGHT);
			Input.define("skip", Key.ENTER);
			Input.define("up", Key.UP);
			
			Assets.timer = ((Main.instance.config.OPTIONS.GAME_TIMER == null) ? Assets.timer : Main.instance.config.OPTIONS.GAME_TIMER);
			Assets.particles = ((Main.instance.config.OPTIONS.PARTICLES == null) ? Assets.particles : Main.instance.config.OPTIONS.PARTICLES);
			
			_4_0.FP.musicVolume = ((Main.instance.config.OPTIONS.MUSIC == null) ? _4_0.FP.musicVolume : Main.instance.config.OPTIONS.MUSIC);
			_4_0.FP.soundVolume = ((Main.instance.config.OPTIONS.SOUNDS == null) ? _4_0.FP.soundVolume : Main.instance.config.OPTIONS.SOUNDS);
			
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE = new MovieClip ();
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.HOVER = new _4_0.Library.IMAGE_BUY_ME_A_COFFEE_WHITE ();
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.HOVER.visible = false;
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.NORMAL = new _4_0.Library.IMAGE_BUY_ME_A_COFFEE_BLACK ();
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.NORMAL.visible = true;
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.addEventListener (MouseEvent.CLICK, this.HandleEvent, false, 0, false);
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.addEventListener (MouseEvent.MOUSE_OUT, this.HandleEvent, false, 0, false);
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.addEventListener (MouseEvent.MOUSE_OVER, this.HandleEvent, false, 0, false);
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.addChild (Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.HOVER);
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.addChild (Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.NORMAL);
			
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.x = 10.0;
			Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.y = 10.0;
			
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS = new MovieClip ();
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.rotation = -45.0;
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.scaleX = 0.86;
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.scaleY = 0.86;
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.visible = false;
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.IMAGE = new _4_0.Library.IMAGE_ELIGIBLE_FOR_IL_LEADERBOARDS ();
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.addChild (Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.IMAGE);
			
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.x = ((640.0 - Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.width) - 10.0);
			Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.y = ((480.0 - 0) - 30.0);
			
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS = new MovieClip ();
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.rotation = -45.0;
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.scaleX = 0.86;
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.scaleY = 0.86;
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.visible = false;
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.IMAGE = new _4_0.Library.IMAGE_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS ();
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.addChild (Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.IMAGE);
			
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.x = ((640.0 - Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.width) - 10.0);
			Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.y = ((480.0 - 0) - 30.0);
			
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS = new MovieClip ();
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.rotation = -45.0;
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.scaleX = 0.86;
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.scaleY = 0.86;
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.visible = false;
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.IMAGE = new _4_0.Library.IMAGE_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS ();
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.addChild (Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.IMAGE);
			
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.x = ((640.0 - Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.width) - 10.0);
			Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.y = ((480.0 - 0) - 30.0);
			
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS = new MovieClip ();
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.rotation = -45.0;
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.scaleX = 0.86;
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.scaleY = 0.86;
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.visible = false;
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.IMAGE = new _4_0.Library.IMAGE_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS ();
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.addChild (Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.IMAGE);
			
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.x = ((640.0 - Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.width) - 10.0);
			Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.y = ((480.0 - 0) - 30.0);
			
			Main.instance.v = new Object ();
			
			Main.instance.v.level_current = new Object ();
			Main.instance.v.level_segment = new String ();
			Main.instance.v.level_time = new Object ();
			
			Main.instance.stage.align = StageAlign.TOP;
			Main.instance.stage.displayState = ((Main.instance.config.OPTIONS.FULLSCREEN == false) ? StageDisplayState.NORMAL : StageDisplayState.FULL_SCREEN_INTERACTIVE);
			Main.instance.stage.scaleMode = StageScaleMode.SHOW_ALL;
			
			//_4_0.UIKeyboard.Instance.visible = false;
			//_4_0.UIKeyboard.Instance.Initialize (Main.instance.config.OPTIONS.UI.KEYBOARD);
			
			//Main.instance.addChild (_4_0.UIKeyboard.Instance);
			
			Main.instance.addChild (Main.instance.MC_BUTTON_BUY_ME_A_COFFEE);
			Main.instance.addChild (Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS);
			Main.instance.addChild (Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS);
			Main.instance.addChild (Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS);
			Main.instance.addChild (Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS);
		}
		
		public function CheckUp (x:String, backup:Boolean) : Main 
		{
			var file:File = File.applicationStorageDirectory.resolvePath(x);
			
			var file_x:File = File.applicationDirectory.resolvePath(x);
			
			var file_stream:FileStream = null;
			
			var object:Object = null;
			
			var object_x:Object = null;
			
			if (file.exists == false)
			{
			}
			else
			{
				file_stream = new FileStream();
				
				file_stream.open(file, FileMode.READ);
				object = JSON.parse (file_stream.readUTFBytes(file_stream.bytesAvailable));
				file_stream.close();
			}
			
			if (file_x.exists == false)
			{
			}
			else
			{
				file_stream = new FileStream();
				
				file_stream.open(file_x, FileMode.READ);
				object_x = JSON.parse (file_stream.readUTFBytes(file_stream.bytesAvailable));
				file_stream.close();
			}
			
			if ((object == null) ||
				(object_x == null))
			{
			}
			else
			{
				object.VERSION_DATE = Number (object.VERSION.split ("_") [0].split (".").join (""));
				object.VERSION_DATE_X = Number (object.VERSION.split ("_") [1]);
				
				object_x.VERSION_DATE = Number (object_x.VERSION.split ("_") [0].split (".").join (""));
				object_x.VERSION_DATE_X = Number (object_x.VERSION.split ("_") [1]);
				
				if ((object.VERSION_DATE < object_x.VERSION_DATE) || 
					((object.VERSION_DATE == object_x.VERSION_DATE) && (object.VERSION_DATE_X < object_x.VERSION_DATE_X)))
				{
					file.deleteFile ();
				}
			}
			
			return this;
		}
		
		public function Config(config:Object = null):Object
		{
			var file:File = File.applicationStorageDirectory.resolvePath("CONFIG.txt");
			
			var file_x:File = File.applicationDirectory.resolvePath("CONFIG.txt");
			
			var file_stream:FileStream = new FileStream();
			
			var object:Object = null;
			
			if (file.exists == false)
			{
				file_stream.open(file_x, FileMode.READ);
				object = file_stream.readUTFBytes(file_stream.bytesAvailable);
				file_stream.close();
				
				file_stream.open(new File(file.nativePath), FileMode.WRITE);
				file_stream.writeUTFBytes(String(object));
				file_stream.close();
			}
			
			if (config == null)
			{
			}
			else
			{
				file_stream.open(new File(file.nativePath), FileMode.WRITE);
				file_stream.writeUTFBytes(JSON.stringify(config, null, "\t"));
				file_stream.close();
			}
			
			file_stream.open(file, FileMode.READ);
			object = JSON.parse(file_stream.readUTFBytes(file_stream.bytesAvailable), null);
			file_stream.close();
			
			return object;
		}
		
		public function HandleEvent(event:Event):Main
		{
			switch (event.currentTarget)
			{
				case this.MC_BUTTON_BUY_ME_A_COFFEE :
				{
					switch (event.type)
					{
						case MouseEvent.CLICK :
						{
							_4_0.FP.play (Assets.SndSelect, 0.5);
							
							navigateToURL (new URLRequest ("https://www.buymeacoffee.com/sensualpudding"));
							
							break;
						}
						case MouseEvent.MOUSE_OUT :
						{
							Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.HOVER.visible = false;
							Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.NORMAL.visible = true;
							
							break;
						}
						case MouseEvent.MOUSE_OVER :
						{
							Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.HOVER.visible = true;
							Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.NORMAL.visible = false;
							
							_4_0.FP.play (Assets.SndMouse, 0.5);
							
							break;
						}
						default :
						{
							break;
						}
					}
					
					break;
				}
				case this.stage:
				{
					switch (event.type)
					{
						case Event.ENTER_FRAME:
						{
							var key:Object = null;
							
							var keys:Dictionary = null;
							
							if (!(TAS.Instance.read == null) && (TAS.Instance.virgin == !false))
							{
								trace (_4_0.FP.world is Level, !(TAS.Instance.read == null), TAS.Instance.virgin);
								
								//_4_0.UIKeyboard.Instance.InputDown (String (">"));
							}
							else
							{
								keys = new Dictionary (false);
								
								for (key in TAS.Instance.WRITE)
								{
									keys [TAS.Instance.WRITE [key]] = (((keys [TAS.Instance.WRITE [key]] == null) ? false : keys [TAS.Instance.WRITE [key]]) || Input.check (String (key), false));
								}
								
								for (key in keys)
								{
									if (keys [key] == false)
									{
										//_4_0.UIKeyboard.Instance.InputUp (String (key));
									}
									else
									{
										//_4_0.UIKeyboard.Instance.InputDown (String (key));
									}
								}
							}
							
							if (FP.world is MainMenu)
							{
								Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.visible = true;
							}
							else
							{
								Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.visible = false;
								Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.HOVER.visible = false;
								Main.instance.MC_BUTTON_BUY_ME_A_COFFEE.NORMAL.visible = true;
							}
							
							Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.visible = false;
							
							Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.visible = false;
							
							Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.visible = false;
							
							Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.visible = false;
							
							if (FP.world is ScoreScreen0)
							{
								Main.instance.MC_ELIGIBLE_FOR_IL_LEADERBOARDS.visible = true;
							}
							else if (FP.world is ScoreScreen1)
							{
								Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.visible = true;
							}
							else if (FP.world is ScoreScreen2)
							{
								Main.instance.MC_ELIGIBLE_FOR_IL_AND_SEGMENTED_LEADERBOARDS.visible = true;
							}
							else if (FP.world is ScoreScreen3)
							{
								Main.instance.MC_ELIGIBLE_FOR_SEGMENTED_LEADERBOARDS.visible = true;
							}
							else if (FP.world is ScoreScreen4)
							{
								Main.instance.MC_NOT_ELIGIBLE_FOR_FULL_LEADERBOARDS.visible = true;
							}
							
							break;
						}
						case KeyboardEvent.KEY_DOWN:
						{
							switch ((event as KeyboardEvent).keyCode)
							{
								case Keyboard.BACKSPACE :
								{
									if (FP.world is Level)
									{
										(FP.world as Level).add (new FuzzTransition (FuzzTransition.GOTO_PREVIOUS));
									}
									
									break;
								}
								case Keyboard.ENTER :
								{
									if ((FP.world is ScoreScreen0) ||
										(FP.world is ScoreScreen1) ||
										(FP.world is ScoreScreen2) ||
										(FP.world is ScoreScreen3) ||
										(FP.world is ScoreScreen4))
									{
										(FP.world as Object).Next ((FP.world as Object).menu_button);
									}
									
									break;
								}
								case Keyboard.ESCAPE:
								{
									event.preventDefault();
									event.stopImmediatePropagation();
									
									_4_0.FP.world.add(new FuzzTransition(FuzzTransition.MENU, MainMenu));
									
									Input.Default ();
									
									TAS.Instance.Initialize ();
									
									break;
								}
								case Keyboard.R :
								{
									if (FP.world is Level)
									{
										if (Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false)
										{
											(FP.world as Level).add (new FuzzTransition (FuzzTransition.RESTART));
										}
										else
										{
											(FP.world as Level).add (new FuzzTransition (FuzzTransition.NEW, null, false, Number (Main.instance.LevelSegmentText ((FP.world as Level).levelNum, ((Stats.saveData.mode == 0) ? 10 : 5)).split ("-").shift ())));
										}
									}
									
									break;
								}
								case Keyboard.TAB :
								{
									if (FP.world is Level)
									{
										(FP.world as Level).add (new FuzzTransition (FuzzTransition.GOTO_NEXT));
									}
									
									break;
								}
								default:
								{
									break;
								}
							}
							
							break;
						}
						default:
						{
							break;
						}
					}
					
					break;
				}
				default:
				{
					break;
				}
			}
			
			return this;
		}
		
		public function FuzzTransitionUpdate (fuzz_transition:FuzzTransition, mode:uint) : Main
		{
			return this;
		}
		
		public function InputWrite(input:Object):Main
		{
			TAS.Instance.Write(input);
			
			return this;
		}
		
		public function Level_goto_Next (level:Level) : Main 
		{
			level.levelNum++;
			
			if (level.levelNum > Assets.TOTAL_LEVELS[Stats.saveData.mode])
			{
				level.levelNum = 1;
			}
			
			level.getXML();
			level.restart();
			
			return this;
		}
		
		public function LevelBuild(level:Level):Main
		{
			var lvl:Object = null;
			
			var tas:Boolean = Main.instance.config.OPTIONS.TAS;
			
			//Main.instance.config = Main.instance.Config (null);
			//
			//Main.instance.config.OPTIONS.TAS = false;
			//
			//if (Main.instance.config.OPTIONS.TAS == false)
			//{
			//}
			//else
			//{
				//lvl = {mode: Assets.NAMES[Stats.saveData.mode].toUpperCase (), number: level.levelNum, time: level.time};
				//
				//TAS.Instance.Initialize ().Open(lvl);
				//
				//if (TAS.Instance.read == null)
				//{
					//if (tas == false)
					//{
					//}
					//else
					//{
						//Input.Default ();
					//}
				//}
				//else
				//{
					//Input.Default ();
				//}
				//
				//Main.instance.config.OPTIONS.TAS = ((TAS.Instance.read == null) ? false : true);
				//
				//trace ("BUILD");
			//}
			
			return this;
		}
		
		public function LevelDie(level:Level):Main
		{
			TAS.Instance.Initialize();
			
			return this;
		}
		
		public function LevelInit(level:Level):Main
		{
			TAS.Instance.Initialize();
			
			return this;
		}
		
		public function LevelRestart(level:Level):Main
		{
			TAS.Instance.Initialize();
			
			return this;
		}
		
		public function LevelSegmentText (level_number:Number, base:Number, max:Boolean = false) : String 
		{
			var a:int = Math.floor (Math.max (0.0, (level_number - 1.0)) / base);
			
			var b:int = (a + 1);
			
			var c:int = (b * base);
			
			var d:int = ((c - base) + 1);
			
			if (max == false)
			{
			}
			else
			{
				c = Math.min (c, Assets.TOTAL_LEVELS [Stats.saveData.mode]);
			}
			
			return (d.toString () + "-" + c.toString ());
		}
		
		public function LevelWin(level:Level):Main
		{
			var lvl:Object = null;
			
			if (TAS.Instance.read == null)
			{
			}
			else
			{
				level.time = TAS.Instance.read.index;
			}
			
			lvl = {mode: Assets.NAMES[Stats.saveData.mode].toUpperCase (), mode_prefix: Assets.PREFIXES[Stats.saveData.mode], name:level.levelText.text, number: level.levelNum, time: level.time};
			
			Main.instance.v.level_current = lvl;
			
			Main.instance.v.level_segment = Main.instance.LevelSegmentText (lvl.number, ((Stats.saveData.mode == 0) ? 10 : 5), true);
			
			if (Main.instance.v.level_time [lvl.mode] == null)
			{
				Main.instance.v.level_time [lvl.mode] = new Array ();
			}
			
			Main.instance.v.level_time [lvl.mode].length = Assets.TOTAL_LEVELS [Stats.saveData.mode];
			
			if (Main.instance.v.level_time [lvl.mode][lvl.number] == null)
			{
				Main.instance.v.level_time [lvl.mode][lvl.number] = lvl.time;
			}
			
			Main.instance.v.level_time [lvl.mode][lvl.number] = Math.min (Main.instance.v.level_time [lvl.mode][lvl.number], lvl.time);
			
			Main.instance.StatzSave (lvl);
			
			((Main.instance.config.OPTIONS.SAVE_REPLAY == false) ? null : TAS.Instance.Save(lvl));
			
			return this;
		}
		
		public function LevelWinSubmitMenu (level:Level) : Main 
		{
			var level_mode:uint = Stats.saveData.mode;
			
			var level_num:uint = level.levelNum;
			
			var level_segment:uint = 0;
			
			var level_total:uint = 0;
			
			var level_x:Array = null;
			
			Main.instance.statz = Main.instance.Statz (null);
			
			Main.instance.v.level_current.time_best = Main.instance.statz.LEVELS [Main.instance.v.level_current.mode][Main.instance.v.level_current.number];
			
			trace ("Show IL Time", Main.instance.config.OPTIONS.SHOW_IL_TIMES);
			trace ("Show Segment Time", Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME);
			trace ("Is Normal And 10", ((Stats.saveData.mode == 0) && (level.levelNum % 10 == 0)));
			trace ("Is Hard And 5", ((Stats.saveData.mode == 1) && (level.levelNum % 5 == 0)));
			
			if (level_mode == 0)
			{
				level_segment = 10;
				
				level_total = Assets.TOTAL_LEVELS [0];
			}
			else if (level_mode == 1)
			{
				level_segment = 5;
				
				level_total = Assets.TOTAL_LEVELS [1];
			}
			
			level_x = Main.instance.LevelSegmentText (11, 5).split ("-");
			
			level_x [0] = uint (level_x [0]);
			level_x [1] = uint (level_x [1]);
			
			trace (level_x);
			
			if ((Main.instance.config.OPTIONS.SHOW_IL_TIMES == true) && 
				(Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false))
			{
				// 0 score screen look for IL times on segment off
				level.add(new FuzzTransition(FuzzTransition.MENU, _4_0.ScoreScreen0));
			}
			else if ((Main.instance.config.OPTIONS.SHOW_IL_TIMES == true) && 
					 (Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == true) &&
					 (((level_num % level_segment == 0) == true) || (level_x [1] >= level_total)))
			{
				// 1 score screen look for IL times on segment on a 10,20,30,40,50 score screen
				level.add(new FuzzTransition(FuzzTransition.MENU, _4_0.ScoreScreen1));
			}
			else if ((Main.instance.config.OPTIONS.SHOW_IL_TIMES == true) && 
					 (Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == true) &&
					 (((level_num % level_segment == 0) == false) || (level_x [1] >= level_total)))
			{
				// 2 score screen look for IL times on segment on not on a 10,20,30,40,50 score screen
				level.add(new FuzzTransition(FuzzTransition.MENU, _4_0.ScoreScreen2));
			}
			else if ((Main.instance.config.OPTIONS.SHOW_IL_TIMES == false) && 
					 (Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == true) &&
					 (((level_num % level_segment == 0) == true) || (level_x [1] >= level_total)))
			{
				// 3 score screen look for IL times off segment on (only seen on level 10,20,30,40,50)
				level.add(new FuzzTransition(FuzzTransition.MENU, _4_0.ScoreScreen3));
			}
			else if ((Main.instance.config.OPTIONS.SHOW_IL_TIMES == false) && 
					 (Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false) &&
					 (((level_num % level_segment == 0) == true) || (level_x [1] >= level_total)))
			{
				// 4 score screen look for IL times off segment off (only seen on level 10,20,30,40,50)
				level.add(new FuzzTransition(FuzzTransition.MENU, _4_0.ScoreScreen4));
			}
			else
			{
				trace ("A", level.levelNum, Assets.TOTAL_LEVELS[Stats.saveData.mode]);
				if (level.levelNum < Assets.TOTAL_LEVELS[Stats.saveData.mode])
				{
					trace ("B");
					if (level.levelNum == 1 && Stats.saveData.mode == 0)
					{
						trace ("C");
						_4_0.FP.play(Assets.VcGiveUp10, Assets.VCVOL);
					}
					else
					{
						trace ("D");
						Assets.playGiveUp();
					}
					
					if (Stats.saveData.mode == 0 && level.levelNum % 10 == 0 || Stats.saveData.mode == 1 && level.levelNum == 5)
					{
						trace ("E");
						Input.Default();
						
						if (Main.instance.v.level_select_repeat == false)
						{
							trace ("F");
							level.add(new FuzzTransition(FuzzTransition.MENU, SubmitMenu));
						}
						else
						{
							trace ("G");
							level.add(new FuzzTransition(FuzzTransition.RESTART));
						}
					}
					else
					{
						trace ("H");
						if (Main.instance.v.level_select_repeat == false)
						{
							trace ("I");
							level.add(new FuzzTransition(FuzzTransition.GOTO_NEXT));
						}
						else
						{
							trace ("J");
							if (Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME == false)
							{
								trace ("K");
								level.add(new FuzzTransition(FuzzTransition.RESTART));
							}
							else
							{
								trace ("L");
								level.add(new FuzzTransition(FuzzTransition.GOTO_NEXT));
							}
						}
					}
				}
				else
				{
					trace ("M");
					_4_0.FP.play(Assets.VcEnding, Assets.VCVOL);
					
					Input.Default();
					
					if (Main.instance.v.level_select_repeat == false)
					{
						trace ("N");
						_4_0.FP.world.add(new FuzzTransition(FuzzTransition.GOTO_NEXT, null, false));
					}
					else
					{
						trace ("O");
						level.add(new FuzzTransition(FuzzTransition.RESTART));
					}
				}
			}
			
			return this;
		}
		
		public function Statz(config:Object = null):Object
		{
			var file:File = File.applicationStorageDirectory.resolvePath("STATZ.txt");
			
			var file_x:File = File.applicationDirectory.resolvePath("STATZ.txt");
			
			var file_stream:FileStream = new FileStream();
			
			var object:Object = null;
			
			if (file.exists == false)
			{
				file_stream.open(file_x, FileMode.READ);
				object = file_stream.readUTFBytes(file_stream.bytesAvailable);
				file_stream.close();
				
				file_stream.open(new File(file.nativePath), FileMode.WRITE);
				file_stream.writeUTFBytes(String(object));
				file_stream.close();
			}
			
			if (config == null)
			{
			}
			else
			{
				file_stream.open(new File(file.nativePath), FileMode.WRITE);
				file_stream.writeUTFBytes(JSON.stringify(config, null, "\t"));
				file_stream.close();
			}
			
			file_stream.open(file, FileMode.READ);
			object = JSON.parse(file_stream.readUTFBytes(file_stream.bytesAvailable), null);
			file_stream.close();
			
			return object;
		}
		
		public function StatzSave (level:Object) : Main 
		{
			Main.instance.statz = Main.instance.Statz (null);
			
			Main.instance.statz.LEVELS [level.mode].length = Math.max (Main.instance.statz.LEVELS [level.mode].length, level.number);
			
			Main.instance.statz.LEVELS [level.mode][level.number] = ((Main.instance.statz.LEVELS [level.mode][level.number] == null) ? level.time : Math.min (Main.instance.statz.LEVELS [level.mode][level.number], level.time));
			
			Main.instance.statz.LEVELS_SEGMENT [level.mode] = ((Main.instance.statz.LEVELS_SEGMENT [level.mode] == null) ? new Object () : Main.instance.statz.LEVELS_SEGMENT [level.mode]);
			
			if (((Stats.saveData.mode == 0) && (level.number % 10 == 0)) || ((Stats.saveData.mode == 1) && (level.number % 5 == 0)))
			{
				if (Main.instance.TimeLevelSegment (Main.instance.v.level_segment.split ("-") [0], Main.instance.v.level_segment.split ("-") [1], Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME) == null)
				{
				}
				else
				{
					if (Main.instance.statz.LEVELS_SEGMENT [level.mode]["_" + Main.instance.v.level_segment.split ("-").join ("_")] == null)
					{
						Main.instance.statz.LEVELS_SEGMENT [level.mode]["_" + Main.instance.v.level_segment.split ("-").join ("_")] = Main.instance.TimeLevelSegment (Main.instance.v.level_segment.split ("-") [0], Main.instance.v.level_segment.split ("-") [1], Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME);
					}
					
					Main.instance.statz.LEVELS_SEGMENT [level.mode]["_" + Main.instance.v.level_segment.split ("-").join ("_")] = 
					Math.min 
					(
						Main.instance.statz.LEVELS_SEGMENT [level.mode]["_" + Main.instance.v.level_segment.split ("-").join ("_")], 
						Main.instance.TimeLevelSegment (Main.instance.v.level_segment.split ("-") [0], Main.instance.v.level_segment.split ("-") [1], Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME)
					);
				}
			}
			
			Main.instance.statz = Main.instance.Statz (Main.instance.statz);
			
			return this;
		}
		
		public function Time(time:*):String
		{
			var string:String = null;
			
			if (time == null)
			{
				string = "?.??.??";
			}
			else
			{
				var sec:Number = time % (60 * 60);
				sec = sec / 60;
				var str:String = sec.toFixed(2);
				if (sec < 10)
				{
					str = "0" + str;
				}
				str = "." + str;
				var blah:uint = Math.floor(time / (60 * 60));
				str = String(blah) + str;
				
				string = str;
			}
			
			return string;
		}
		
		public function TimeLevelSegment (a:int, b:int, is_null:Boolean) : * 
		{
			var flag:Boolean = false;
			
			var i:int = 0;
			
			var t:Object = null;
			
			var time:Number = 0.0;
			
			for (i = a; i <= b; ++i)
			{
				flag = true;
				
				t = Main.instance.v.level_time [Main.instance.v.level_current.mode][i];
				
				if (is_null == false)
				{
				}
				else
				{
					if (t == null)
					{
						flag = false;
						
						t = 0.0;
						
						break;
					}
				}
				
				time = (time + t);
			}
			
			return ((flag == false) ? null : time);
		}
		
		public function WorldUpdateF(world:World):Main
		{
			var level:Level = (world as Level);
			
			//_4_0.UIKeyboard.Instance.visible = Main.instance.config.OPTIONS.KEYBOARD;
			
			if (level == null)
			{
			}
			else
			{
				TAS.Instance.Read(level.time).Write(null);
			}
			
			return this;
		}
	}
}
