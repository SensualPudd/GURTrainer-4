
package _4_0 
{
	import _4_0.FP;
	import _4_0.Main;
	import _4_0.jam.Assets;
	import _4_0.jam.FuzzTransition;
	import _4_0.jam.Level 
	import _4_0.jam.MainMenu;
	import _4_0.jam.MenuButton;
	import _4_0.jam.MenuWorld;
	import _4_0.jam.Stats;
	import _4_0.punk.Text;
	
	public class ScoreScreen1 extends MenuWorld
	{
		public var menu_button:MenuButton = null;
		
		public function ScoreScreen1 ()
		{
			super ();
		}
		
		override public function init () : void
		{
			super.init ();
			
			var text:Text = null;
			
			text = new Text ("Scoring Time!", 160, 10);
			text.color = 16777215;
			text.size = 16;
			text.center ();
			
			this.add (text);
			
			text = new Text ("You've Completed", 160, 40);
			text.color = 16777215;
			text.size = 8;
			text.center ();
			
			this.add (text);
			
			text = new Text ("Level" + " " + _4_0.Main.instance.v.level_current.number, 160, 55);
			text.color = 16777215;
			text.size = 16;
			text.center ();
			
			this.add (text);
			
			text = new Text ("Your IL time is", 160, 75);
			text.color = 16777215;
			text.size = 8;
			text.center ();
			
			this.add (text);
			
			trace (JSON.stringify (_4_0.Main.instance.v.level_current));
			
			text = new Text (_4_0.Main.instance.Time (_4_0.Main.instance.v.level_current.time), 160, 90);
			text.color = 16777215;
			text.size = 16;
			text.center ();
			
			this.add (text);
			
			text = new Text ("Your best IL time is", 160, 110);
			text.color = 16777215;
			text.size = 8;
			text.center ();
			
			this.add (text);
			
			text = new Text (_4_0.Main.instance.Time (_4_0.Main.instance.v.level_current.time_best), 160, 125);
			text.color = 16777215;
			text.size = 16;
			text.center ();
			
			this.add (text);
			
			text = new Text ("Segment " + _4_0.Main.instance.v.level_segment + " time", 160, 145);
			text.color = 16777215;
			text.size = 8;
			text.center ();
			
			this.add (text);
			
			text = new Text (_4_0.Main.instance.Time (_4_0.Main.instance.TimeLevelSegment (_4_0.Main.instance.v.level_segment.split ("-") [0], _4_0.Main.instance.v.level_segment.split ("-") [1], Main.instance.config.OPTIONS.SHOW_SEGMENT_TIME)), 160, 160);
			text.color = 16777215;
			text.size = 16;
			text.center ();
			
			this.add (text);
			
			text = new Text ("Best " + _4_0.Main.instance.v.level_segment + " Segment", 160, 180);
			text.color = 16777215;
			text.size = 8;
			text.center ();
			
			this.add (text);
			
			text = new Text (_4_0.Main.instance.Time (_4_0.Main.instance.statz.LEVELS_SEGMENT [_4_0.Main.instance.v.level_current.mode]["_" + _4_0.Main.instance.v.level_segment.split ("-").join ("_")]), 160, 195);
			text.color = 16777215;
			text.size = 16;
			text.center ();
			
			this.add (text);
			
			this.menu_button = new MenuButton ("Onward!", 160, 220, this.Next);
			
			this.add (this.menu_button);
			
			_4_0.FP.musicVolume = _4_0.FP.musicVolume / 2;
			
			return;
		}
		
		public function Next (menu_button:MenuButton) : ScoreScreen1 
		{
			_4_0.FP.play (Assets.SndWin);
			
			if (Main.instance.v.level_select_repeat == false)
			{
				if (_4_0.Main.instance.v.level_current.number >= Assets.TOTAL_LEVELS [Stats.saveData.mode])
				{
					Assets.playBye ();
					
					this.add (new FuzzTransition (FuzzTransition.MENU, MainMenu));
				}
				else
				{
					this.add (new FuzzTransition (FuzzTransition.NEW, null, false, (_4_0.Main.instance.v.level_current.number + 1)));
				}
			}
			else
			{
				this.add(new FuzzTransition(FuzzTransition.RESTART));
			}
			
			_4_0.FP.musicVolume = (_4_0.FP.musicVolume * 2.0);
			
			this.remove (menu_button);
			
			return this;
		}
	}
}
