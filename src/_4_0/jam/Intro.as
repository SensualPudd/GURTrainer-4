package _4_0.jam
{
   import _4_0.FP;
   import _4_0.punk.Text;
   import _4_0.punk.core.Alarm;
   import _4_0.punk.core.Engine;
   import _4_0.punk.util.Input;
   
   public class Intro extends MenuWorld
   {
       
      
      private var underscore:Boolean = true;
      
      private var mode:uint = 0;
      
      private var alarmUnderscore:Alarm;
      
      private var textGoto:String = "";
      
      private var alarm:Alarm;
      
      private var textCur:String = "";
      
      private var canGo:Boolean = true;
      
      private var text:Text;
      
      private var alarmText:Alarm;
      
      public function Intro()
      {
         this.alarmUnderscore = new Alarm(30,this.onAlarmUnderscore,Alarm.LOOPING);
         this.alarmText = new Alarm(4,this.onAlarmText,Alarm.LOOPING);
         this.alarm = new Alarm(120,this.onAlarm,Alarm.PERSIST);
         super();
      }
      
      private function onAlarmUnderscore() : void
      {
         this.underscore = !this.underscore;
      }
      
      private function onAlarmText() : void
      {
         if(this.textCur == this.textGoto)
         {
            return;
         }
         _4_0.FP.play(Assets.SndMouse,0.5);
         for(var i:int = 0; i < this.textCur.length; i++)
         {
            if(this.textCur.charAt(i) != this.textGoto.charAt(i))
            {
               this.textCur = this.textCur.substr(0,this.textCur.length - 1);
               this.alarmText.totalFrames = 2;
               return;
            }
         }
         this.alarmText.totalFrames = 4;
         this.textCur = this.textCur + this.textGoto.charAt(this.textCur.length);
      }
      
      override public function update() : void
      {
         super.update();
         this.text.text = this.textCur + (!!this.underscore?"_":"");
         if(this.canGo && Input.pressed("skip"))
         {
            this.canGo = false;
            _4_0.FP.musicPlay(Assets.MusGame);
            Engine.flash = true;
            add(new FuzzTransition(FuzzTransition.NEW,null,true));
         }
      }
      
      private function onAlarm() : void
      {
         if(this.mode == 0)
         {
            this.textGoto = "Wake uo Ro";
            this.alarm.totalFrames = 90;
         }
         else if(this.mode == 1)
         {
            this.textGoto = "Wake up Robot";
            _4_0.FP.play(Assets.VcIntro1,Assets.VCVOL);
            this.alarm.totalFrames = 200;
         }
         else if(this.mode == 2)
         {
            this.textGoto = "";
            this.alarm.totalFrames = 84;
         }
         else if(this.mode == 3)
         {
            this.textGoto = "WAKE UP ROBOT!!1!";
            _4_0.FP.play(Assets.VcIntro2,Assets.VCVOL);
            this.alarm.totalFrames = 113;
         }
         else if(this.mode == 4)
         {
            this.textGoto = "WAKE UP ROBOT!!!!";
            this.alarm.totalFrames = 180;
         }
         else if(this.mode == 5)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt ia time t";
            this.alarm.totalFrames = 90;
         }
         else if(this.mode == 6)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to";
            _4_0.FP.play(Assets.VcIntro3,Assets.VCVOL);
            this.alarm.totalFrames = 90;
         }
         else if(this.mode == 7)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to.";
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 8)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to..";
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 9)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...";
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 10)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n\n";
            this.alarm.totalFrames = 50;
         }
         else if(this.mode == 11)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n";
            this.alarm.totalFrames = 30;
         }
         else if(this.mode == 12)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nV";
            this.alarm.totalFrames = 30;
         }
         else if(this.mode == 13)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nb";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 14)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegun ";
            this.alarm.totalFrames = 60;
         }
         else if(this.mode == 15)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Te";
            _4_0.FP.play(Assets.VcIntro4,Assets.VCVOL);
            this.alarm.totalFrames = 60;
         }
         else if(this.mode == 16)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Tes";
            this.alarm.totalFrames = 10;
         }
         else if(this.mode == 17)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Tesr";
            this.alarm.totalFrames = 8;
         }
         else if(this.mode == 18)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Testk";
            this.alarm.totalFrames = 7;
         }
         else if(this.mode == 19)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Testk/{asdSD&&jfa\n!%lasjdt)\n,<ashvh\n>\';as[\nSEGMENTATION FAULT";
            this.alarm.totalFrames = 260;
         }
         else if(this.mode == 20)
         {
            if(this.canGo)
            {
               _4_0.FP.musicStop();
            }
            this.alarm.totalFrames = 120;
         }
         else if(this.mode == 21)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Testk";
            this.alarm.totalFrames = 240;
         }
         else if(this.mode == 22)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Test";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 23)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Tes";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 24)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin Te";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 25)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin T";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 26)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin ";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 27)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegin";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 28)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBegi";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 29)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBeg";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 30)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nBe";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 31)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\nB";
            this.alarm.totalFrames = 20;
         }
         else if(this.mode == 32)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n";
            this.alarm.totalFrames = 90;
         }
         else if(this.mode == 33)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n.";
            _4_0.FP.play(Assets.VcIntro3,Assets.VCVOL);
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 34)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n..";
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 35)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...";
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 36)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\n";
            this.alarm.totalFrames = 160;
         }
         else if(this.mode == 37)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEee";
            _4_0.FP.play(Assets.VcIntro5,Assets.VCVOL);
            if(Stats.saveData.mode == 0)
            {
               _4_0.FP.musicPlay(Assets.MusGame);
               Engine.flash = true;
            }
            this.alarm.totalFrames = 80;
         }
         else if(this.mode == 38)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeee";
            this.alarm.totalFrames = 8;
         }
         else if(this.mode == 39)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeee";
            this.alarm.totalFrames = 7;
            if(Stats.saveData.mode == 0)
            {
               add(new FuzzTransition(FuzzTransition.NEW,null,true));
            }
         }
         else if(this.mode == 40)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeee";
            this.alarm.totalFrames = 12;
         }
         else if(this.mode == 41)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeo";
            this.alarm.totalFrames = 6;
         }
         else if(this.mode == 42)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeoooOOOooo";
            this.alarm.totalFrames = 160;
         }
         else if(this.mode == 43)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeoooOOOooo\n";
            this.alarm.totalFrames = 60;
         }
         else if(this.mode == 44)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeoooOOOooo\noooooo";
            this.alarm.totalFrames = 120;
         }
         else if(this.mode == 45)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeoooOOOooo\noooooo\n\n.";
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 46)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeoooOOOooo\noooooo\n\n..";
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 47)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeoooOOOooo\noooooo\n\n...";
            this.alarm.totalFrames = 40;
         }
         else if(this.mode == 48)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeoooOOOooo\noooooo\n\n...\n";
            this.alarm.totalFrames = 160;
         }
         else if(this.mode == 49)
         {
            this.textGoto = "WAKE UP ROBOT!!!!\n\nIt is time to...\n...\nDAAANNCEEeeeeeoooOOOooo\noooooo\n\n...\nHARD!";
            _4_0.FP.play(Assets.VcIntro6,Assets.VCVOL);
            _4_0.FP.musicPlay(Assets.MusGame);
            Engine.flash = true;
            this.alarm.totalFrames = 90;
         }
         else if(this.mode == 50)
         {
            add(new FuzzTransition(FuzzTransition.NEW,null,true));
         }
         this.mode++;
         this.alarm.start();
      }
      
      override public function init() : void
      {
         var t:Text = null;
         super.init();
         _4_0.FP.musicPlay(Assets.MusIntro);
         Engine.flash = false;
         addAlarm(this.alarmUnderscore);
         addAlarm(this.alarmText);
         addAlarm(this.alarm);
         this.text = new Text("",16,16);
         this.text.size = 16;
         this.text.color = 16777215;
         add(this.text);
         t = new Text("ENTER - skip",160,232);
         t.size = 8;
         t.color = 16777215;
         t.center();
         add(t);
      }
   }
}
