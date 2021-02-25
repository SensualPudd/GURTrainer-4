package _4_0.punk.util
{
	import _4_0.FP;
	import _4_0.Main;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class Input
	{
		
		private static var _keyNum:int = 0;
		
		public static var mouseReleased:Boolean = false;
		
		public static var mousePressed:Boolean = false;
		
		private static var _enabled:Boolean = false;
		
		private static var _press:Vector.<int> = new Vector.<int>(256);
		
		private static var _releaseNum:int = 0;
		
		public static var mouseUp:Boolean = true;
		
		private static var _control:Array = [];
		
		public static var mouseDown:Boolean = false;
		
		private static var _pressNum:int = 0;
		
		private static var _release:Vector.<int> = new Vector.<int>(256);
		
		private static var _key:Vector.<Boolean> = new Vector.<Boolean>(256);
		
		public function Input()
		{
			super();
		}
		
		private static function onMouseUp(e:MouseEvent):void
		{
			mouseDown = false;
			mouseUp = true;
			mousePressed = false;
			mouseReleased = true;
		}
		
		public static function onKeyDown(e:Object):void
		{
			var code:int = e.keyCode;
			if (!_key[code])
			{
				_key[code] = true;
				_keyNum++;
				_press[_pressNum++] = code;
			}
		}
		
		public static function enable(stage:Stage):void
		{
			if (!_enabled)
			{
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				_enabled = true;
			}
		}
		
		public static function check(name:String, write:Boolean = true):Boolean
		{
			var v:Vector.<int> = _control[name];
			var i:int = 0;
			
			if (v == null)
			{
			}
			else
			{
				i = v.length;
				
				while (i--)
				{
					if (_key[v[i]])
					{
						((write == false) ? null : _4_0.Main.instance.InputWrite (String (name)));
						
						return true;
					}
				}
			}
			
			return false;
		}
		
		public static function define(name:String, ... keys):void
		{
			_control[name] = Vector.<int>(keys);
		}
		
		private static function onMouseDown(e:MouseEvent):void
		{
			if (!mouseDown)
			{
				mouseDown = true;
				mouseUp = false;
				mousePressed = true;
				mouseReleased = false;
			}
		}
		
		public static function update():void
		{
			while (true)
			{
				if (!_pressNum--)
				{
					break;
				}
				_press[_pressNum] = -1;
			}
			_pressNum = 0;
			while (true)
			{
				if (!_releaseNum--)
				{
					break;
				}
				_release[_releaseNum] = -1;
			}
			_releaseNum = 0;
			if (mousePressed)
			{
				mousePressed = false;
			}
			if (mouseReleased)
			{
				mouseReleased = false;
			}
		}
		
		public static function get mouseX():int
		{
			return _4_0.FP.stage.mouseX / _4_0.FP.screen.scale;
		}
		
		public static function get mouseY():int
		{
			return _4_0.FP.stage.mouseY / _4_0.FP.screen.scale;
		}
		
		public static function pressedKey(keyCode:int):Boolean
		{
			return _press.indexOf(keyCode) >= 0;
		}
		
		public static function pressed(name:String):Boolean
		{
			var v:Vector.<int> = _control[name];
			var i:int = null;
			
			if (v == null)
			{
			}
			else
			{
				i = v.length;
				
				while (i--)
				{
					if (_press.indexOf(v[i]) >= 0)
					{
						_4_0.Main.instance.InputWrite (String (name));
						
						return true;
					}
				}
			}
			
			return false;
		}
		
		public static function releasedKey(keyCode:int):Boolean
		{
			return _release.indexOf(keyCode) >= 0;
		}
		
		public static function keys(name:String):Vector.<int>
		{
			return _control[name] as Vector.<int>;
		}
		
		public static function checkKey(keyCode:int):Boolean
		{
			return _key[keyCode];
		}
		
		public static function onKeyUp(e:Object):void
		{
			var code:int = e.keyCode;
			if (_key[code])
			{
				_key[code] = false;
				_keyNum--;
				_release[_releaseNum++] = code;
			}
		}
		
		public static function released(name:String):Boolean
		{
			var v:Vector.<int> = _control[name];
			var i:int = null;
			
			if (v == null)
			{
			}
			else
			{
				i = v.length;
				
				while (i--)
				{
					if (_release.indexOf(v[i]) >= 0)
					{
						//Main.instance.InputWrite (String (name));
						
						return true;
					}
				}
			}
			
			return false;
		}
		
		public static function Default():void
		{
			_keyNum = 0;
			
			mouseReleased = false;
			
			mousePressed = false;
			
			_enabled = false;
			
			_press = new Vector.<int>(256);
			
			_releaseNum = 0;
			
			mouseUp = true;
			
			_control = _control;
			
			mouseDown = false;
			
			_pressNum = 0;
			
			_release = new Vector.<int>(256);
			
			_key = new Vector.<Boolean>(256);
			
			return;
		}
	}
}
