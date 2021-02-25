package _4_0.jam
{
   import _4_0.FP;
   import _4_0.Library;
   import flash.display.Stage;

   public class Assets
   {

      private static const VcBye1:Class =_4_0.Library.Assets_VcBye1;

      private static const VcBye4:Class =_4_0.Library.Assets_VcBye4;

      public static const SndNewGame:Class =_4_0.Library.Assets_SndNewGame;

      public static var currentMusic:Class;

      public static const MusGame:Class =_4_0.Library.Assets_MusGame;

      public static const SndGrappleSaw:Class =_4_0.Library.Assets_SndGrappleSaw;

      private static var lastGoodJob:int = -1;

      public static var fuzz:FuzzTransition = null;

      public static const VcEnding:Class =_4_0.Library.Assets_VcEnding;

      private static const VcGoodJob1:Class =_4_0.Library.Assets_VcGoodJob1;

      private static const VcGoodJob2:Class =_4_0.Library.Assets_VcGoodJob2;

      private static const VcGoodJob3:Class =_4_0.Library.Assets_VcGoodJob3;

      private static const VcGoodJob4:Class =_4_0.Library.Assets_VcGoodJob4;

      private static const VcGoodJob5:Class =_4_0.Library.Assets_VcGoodJob5;

      private static const VcGoodJob6:Class =_4_0.Library.Assets_VcGoodJob6;

      public static const SndFall:Class =_4_0.Library.Assets_SndFall;

      private static const VcGoodJob8:Class =_4_0.Library.Assets_VcGoodJob8;

      private static const VcGoodJob9:Class =_4_0.Library.Assets_VcGoodJob9;

      public static const H10:Class =_4_0.Library.Assets_H10;

      public static const H11:Class =_4_0.Library.Assets_H11;

      public static const SndGrappleElec:Class =_4_0.Library.Assets_SndGrappleElec;

      public static const VcIntro1:Class =_4_0.Library.Assets_VcIntro1;

      private static const VcGoodJob7:Class =_4_0.Library.Assets_VcGoodJob7;

      public static const VcIntro3:Class =_4_0.Library.Assets_VcIntro3;

      public static const VcIntro4:Class =_4_0.Library.Assets_VcIntro4;

      public static const VcIntro5:Class =_4_0.Library.Assets_VcIntro5;

      public static const SndDie:Class =_4_0.Library.Assets_SndDie;

      public static const VcIntro6:Class =_4_0.Library.Assets_VcIntro6;

      public static const VcIntro2:Class =_4_0.Library.Assets_VcIntro2;

      private static const VcGiveUp1:Class =_4_0.Library.Assets_VcGiveUp1;

      public static const SndStart:Class =_4_0.Library.Assets_SndStart;

      private static const VcGiveUp3:Class =_4_0.Library.Assets_VcGiveUp3;

      private static const VcGiveUp4:Class =_4_0.Library.Assets_VcGiveUp4;

      private static const VcGiveUp5:Class =_4_0.Library.Assets_VcGiveUp5;

      private static const VcGiveUp6:Class =_4_0.Library.Assets_VcGiveUp6;

      private static const VcGiveUp7:Class =_4_0.Library.Assets_VcGiveUp7;

      private static const VcGiveUp8:Class =_4_0.Library.Assets_VcGiveUp8;

      private static const VcGiveUp2:Class =_4_0.Library.Assets_VcGiveUp2;

      private static const VcGiveUp12:Class =_4_0.Library.Assets_VcGiveUp12;

      private static const VcGiveUp13:Class =_4_0.Library.Assets_VcGiveUp13;

      private static const VcGiveUp14:Class =_4_0.Library.Assets_VcGiveUp14;

      private static const VcGiveUp15:Class =_4_0.Library.Assets_VcGiveUp15;

      private static const VcGiveUp16:Class =_4_0.Library.Assets_VcGiveUp16;

      private static const VcGiveUp17:Class =_4_0.Library.Assets_VcGiveUp17;

      private static const VcGiveUp9:Class =_4_0.Library.Assets_VcGiveUp9;

      private static const VcGiveUp11:Class =_4_0.Library.Assets_VcGiveUp11;

      private static const VcGiveUp18:Class =_4_0.Library.Assets_VcGiveUp18;

      public static const VcGiveUp10:Class =_4_0.Library.Assets_VcGiveUp10;

      public static var particles:Boolean = true;

      private static const VcGiveUp20:Class =_4_0.Library.Assets_VcGiveUp20;

      private static const VcGiveUp21:Class =_4_0.Library.Assets_VcGiveUp21;

      private static const VcGiveUp19:Class =_4_0.Library.Assets_VcGiveUp19;

      private static const VcGiveUp23:Class =_4_0.Library.Assets_VcGiveUp23;

      private static const VcGiveUp24:Class =_4_0.Library.Assets_VcGiveUp24;

      private static const VcGiveUp25:Class =_4_0.Library.Assets_VcGiveUp25;

      private static const VcGiveUp26:Class =_4_0.Library.Assets_VcGiveUp26;

      private static const VcGiveUp27:Class =_4_0.Library.Assets_VcGiveUp27;

      private static const VcGiveUp28:Class =_4_0.Library.Assets_VcGiveUp28;

      public static const PREFIXES:Array = ["L","H"];

      private static const VcGiveUp29:Class =_4_0.Library.Assets_VcGiveUp29;

      private static const VcGiveUp22:Class =_4_0.Library.Assets_VcGiveUp22;

      public static const SndLand:Class =_4_0.Library.Assets_SndLand;

      public static const SndEnd:Class =_4_0.Library.Assets_SndEnd;

      public static const SndMouse:Class =_4_0.Library.Assets_SndMouse;

      public static const VCVOL:Number = 10;

      private static const VcGiveUp32:Class =_4_0.Library.Assets_VcGiveUp32;

      public static const H1:Class =_4_0.Library.Assets_H1;

      public static const TOTAL_LEVELS:Array = [50,11];

      public static const H3:Class =_4_0.Library.Assets_H3;

      public static const H4:Class =_4_0.Library.Assets_H4;

      public static const H7:Class =_4_0.Library.Assets_H7;

      public static const H8:Class =_4_0.Library.Assets_H8;

      public static const H9:Class =_4_0.Library.Assets_H9;

      private static const VcGiveUp34:Class =_4_0.Library.Assets_VcGiveUp34;

      private static const VcGiveUp35:Class =_4_0.Library.Assets_VcGiveUp35;

      public static const H5:Class =_4_0.Library.Assets_H5;

      public static const H6:Class =_4_0.Library.Assets_H6;

      private static const VcGiveUp30:Class =_4_0.Library.Assets_VcGiveUp30;

      public static const H2:Class =_4_0.Library.Assets_H2;

      private static const VcGiveUp33:Class =_4_0.Library.Assets_VcGiveUp33;

      private static const VcGiveUp36:Class =_4_0.Library.Assets_VcGiveUp36;

      private static const VcGiveUp31:Class =_4_0.Library.Assets_VcGiveUp31;

      public static const VcPresents:Class =_4_0.Library.Assets_VcPresents;

      public static const VcBestEver:Class =_4_0.Library.Assets_VcBestEver;

      public static const SndJump:Class =_4_0.Library.Assets_SndJump;

      public static const SndThrow:Class =_4_0.Library.Assets_SndThrow;

      public static const NAMES:Array = ["Normal","HARD"];

      public static const SndDeselect:Class =_4_0.Library.Assets_SndDeselect;

      public static const SndStatic:Class =_4_0.Library.Assets_SndStatic;

      public static const SndShake:Class = _4_0.Library.Assets_SndShake;

      public static var timer:Boolean = false;

      public static const L1:Class = _4_0.Library.Assets_L1;

      public static const L2:Class = _4_0.Library.Assets_L2;

      public static const L3:Class = _4_0.Library.Assets_L3;

      public static const L4:Class = _4_0.Library.Assets_L4;

      public static const L5:Class = _4_0.Library.Assets_L5;

      public static const L6:Class = _4_0.Library.Assets_L6;

      public static const L7:Class = _4_0.Library.Assets_L7;

      public static const L8:Class = _4_0.Library.Assets_L8;

      public static const L9:Class = _4_0.Library.Assets_L9;

      public static const L13:Class = _4_0.Library.Assets_L13;

      public static const L14:Class = _4_0.Library.Assets_L14;

      public static const L15:Class = _4_0.Library.Assets_L15;

      public static const L16:Class = _4_0.Library.Assets_L16;

      public static const L17:Class = _4_0.Library.Assets_L17;

      public static const L18:Class = _4_0.Library.Assets_L18;

      public static const L19:Class = _4_0.Library.Assets_L19;

      public static const L10:Class = _4_0.Library.Assets_L10;

      public static const L11:Class = _4_0.Library.Assets_L11;

      public static const L12:Class = _4_0.Library.Assets_L12;

      public static const MusIntro:Class = _4_0.Library.Assets_MusIntro;

      public static const L20:Class = _4_0.Library.Assets_L20;

      public static const L21:Class = _4_0.Library.Assets_L21;

      public static const L22:Class = _4_0.Library.Assets_L22;

      public static const L23:Class = _4_0.Library.Assets_L23;

      public static const L25:Class = _4_0.Library.Assets_L25;

      public static const L26:Class = _4_0.Library.Assets_L26;

      public static const L27:Class = _4_0.Library.Assets_L27;

      public static const L28:Class = _4_0.Library.Assets_L28;

      public static const L29:Class = _4_0.Library.Assets_L29;

      public static const L24:Class = _4_0.Library.Assets_L24;

      private static const VcGoodJob14:Class = _4_0.Library.Assets_VcGoodJob14;

      private static const VcGoodJob16:Class = _4_0.Library.Assets_VcGoodJob16;

      private static const VcGoodJob12:Class = _4_0.Library.Assets_VcGoodJob12;

      public static const SndSelect:Class = _4_0.Library.Assets_SndSelect;

      public static const L30:Class = _4_0.Library.Assets_L30;

      public static const L31:Class = _4_0.Library.Assets_L31;

      public static const L32:Class = _4_0.Library.Assets_L32;

      public static const L33:Class = _4_0.Library.Assets_L33;

      public static const L34:Class = _4_0.Library.Assets_L34;

      public static const L35:Class = _4_0.Library.Assets_L35;

      public static const L36:Class = _4_0.Library.Assets_L36;

      public static const L37:Class = _4_0.Library.Assets_L37;

      public static const L38:Class = _4_0.Library.Assets_L38;

      public static const L39:Class = _4_0.Library.Assets_L39;

      public static const MusMenu:Class = _4_0.Library.Assets_MusMenu;

      private static const VcGoodJob22:Class = _4_0.Library.Assets_VcGoodJob22;

      private static const VcGoodJob17:Class = _4_0.Library.Assets_VcGoodJob17;

      public static const SndRank1:Class = _4_0.Library.Assets_SndRank1;

      public static const SndRank2:Class = _4_0.Library.Assets_SndRank2;

      public static const SndRank3:Class = _4_0.Library.Assets_SndRank3;

      public static const SndRank4:Class = _4_0.Library.Assets_SndRank4;

      public static const SndRank5:Class = _4_0.Library.Assets_SndRank5;

      public static const SndRank6:Class = _4_0.Library.Assets_SndRank6;

      private static const VcGoodJob13:Class = _4_0.Library.Assets_VcGoodJob13;

      private static const VcGoodJob23:Class = _4_0.Library.Assets_VcGoodJob23;

      private static const VcGoodJob15:Class = _4_0.Library.Assets_VcGoodJob15;

      private static const VcBye2:Class = _4_0.Library.Assets_VcBye2;

      public static const SndGrapple:Class = _4_0.Library.Assets_SndGrapple;

      public static const GIVEUPVOL:Number = 9;

      public static const L40:Class = _4_0.Library.Assets_L40;

      public static const L41:Class = _4_0.Library.Assets_L41;

      public static const L42:Class = _4_0.Library.Assets_L42;

      public static const L43:Class = _4_0.Library.Assets_L43;

      public static const L45:Class = _4_0.Library.Assets_L45;

      public static const L46:Class = _4_0.Library.Assets_L46;

      public static const L47:Class = _4_0.Library.Assets_L47;

      public static const L48:Class = _4_0.Library.Assets_L48;

      public static const L49:Class = _4_0.Library.Assets_L49;

      public static const SndWin:Class = _4_0.Library.Assets_SndWin;

      private static const VcBye5:Class = _4_0.Library.Assets_VcBye5;

      public static const SndDrop:Class = _4_0.Library.Assets_SndDrop;

      private static const VcGoodJob11:Class = _4_0.Library.Assets_VcGoodJob11;

      public static const L44:Class = _4_0.Library.Assets_L44;

      private static const VcGoodJob19:Class = _4_0.Library.Assets_VcGoodJob19;

      public static const SndHardGame:Class = _4_0.Library.Assets_SndHardGame;

      public static const L50:Class = _4_0.Library.Assets_L50;

      private static const VcBye6:Class = _4_0.Library.Assets_VcBye6;

      private static const VcGoodJob20:Class = _4_0.Library.Assets_VcGoodJob20;

      private static const VcGoodJob18:Class = _4_0.Library.Assets_VcGoodJob18;

      public static const SUBMIT_IDS:Array = ["3172","3173"];

      private static const VcGoodJob10:Class = _4_0.Library.Assets_VcGoodJob10;

      private static const VcBye3:Class = _4_0.Library.Assets_VcBye3;

      private static const VcGoodJob21:Class = _4_0.Library.Assets_VcGoodJob21;

      private static const VcGoodLuck1:Class = _4_0.Library.Assets_VcGoodLuck1;

      private static const VcGoodLuck2:Class = _4_0.Library.Assets_VcGoodLuck2;

      private static var lastGiveUp:int = -1;

      private static const ARR_BYE:Array = [VcBye1,VcBye2,VcBye3,VcBye4,VcBye5,VcBye6];

      private static const ARR_GIVEUP:Array = [VcGiveUp1,VcGiveUp2,VcGiveUp3,VcGiveUp4,VcGiveUp5,VcGiveUp6,VcGiveUp7,VcGiveUp8,VcGiveUp9,VcGiveUp10,VcGiveUp11,VcGiveUp12,VcGiveUp13,VcGiveUp14,VcGiveUp15,VcGiveUp16,VcGiveUp17,VcGiveUp18,VcGiveUp19,VcGiveUp20,VcGiveUp21,VcGiveUp22,VcGiveUp23,VcGiveUp24,VcGiveUp25,VcGiveUp26,VcGiveUp27,VcGiveUp28,VcGiveUp29,VcGiveUp30,VcGiveUp31,VcGiveUp32,VcGiveUp33,VcGiveUp34,VcGiveUp35,VcGiveUp36];

      private static const ARR_GOODJOB:Array = [VcGoodJob1,VcGoodJob2,VcGoodJob3,VcGoodJob4,VcGoodJob5,VcGoodJob6,VcGoodJob7,VcGoodJob8,VcGoodJob9,VcGoodJob10,VcGoodJob11,VcGoodJob12,VcGoodJob13,VcGoodJob14,VcGoodJob15,VcGoodJob16,VcGoodJob17,VcGoodJob18,VcGoodJob19,VcGoodJob20,VcGoodJob21,VcGoodJob22,VcGoodJob23];

      private static const ARR_GOODLUCK:Array = [VcGoodLuck1,VcGoodLuck2];


      public function Assets()
      {
         super();
      }

      public static function playGiveUp() : void
      {
         var c:int = 0;
         if(lastGiveUp == -1)
         {
            lastGiveUp = Math.floor(Math.random() * ARR_GIVEUP.length);
         }
         else
         {
            c = lastGiveUp;
            while(c == lastGiveUp)
            {
               lastGiveUp = Math.floor(Math.random() * ARR_GIVEUP.length);
            }
         }
         _4_0.FP.play(ARR_GIVEUP[lastGiveUp],GIVEUPVOL);
      }

      public static function playGoodJob() : void
      {
         var c:int = 0;
         if(_4_0.FP.choose(true,false,false,false))
         {
            return;
         }
         if(lastGoodJob == -1)
         {
            lastGoodJob = Math.floor(Math.random() * ARR_GOODJOB.length);
         }
         else
         {
            c = lastGoodJob;
            while(c == lastGoodJob)
            {
               lastGoodJob = Math.floor(Math.random() * ARR_GOODJOB.length);
            }
         }
         _4_0.FP.play(ARR_GOODJOB[lastGoodJob],VCVOL);
      }

      public static function checkDomain(stage:Stage, domain:String) : Boolean
      {
         var url:String = stage.loaderInfo.url;
         var startCheck:int = url.indexOf("ot.") + 3;
         var domainLen:int = url.indexOf("q",startCheck) - startCheck;
         var d:String = url.substr(startCheck,domainLen);
         var splits:Array = d.split(".");
         d = splits[splits.length - 2] + "." + splits[splits.length - 1];
         if(d == domain)
         {
            return true;
         }
         return false;
      }

      public static function playLoad() : void
      {
         _4_0.FP.play(ARR_GOODLUCK[Math.floor(Math.random() * ARR_GOODLUCK.length)],VCVOL);
      }

      public static function playBye() : void
      {
         _4_0.FP.play(ARR_BYE[Math.floor(Math.random() * ARR_BYE.length)],VCVOL);
      }
   }
}
