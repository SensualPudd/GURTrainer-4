package _4_0.punk
{
	import _4_0.FP;
	import _4_0.Library;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import _4_0.punk.core.Entity;
	
	public class Text extends Entity
	{
		
		public static var size:int = 8;
		
		public static var color:uint = 0;
		
		public static var align:String = TextFormatAlign.LEFT;
		
		public static const LEFT:String = TextFormatAlign.LEFT;
		
		public static var font:String = "04b03";
		
		public static const CENTER:String = TextFormatAlign.CENTER;
		
		public static const RIGHT:String = TextFormatAlign.RIGHT;
		
		var _rect:Rectangle;
		
		var _data:BitmapData;
		
		public var _text:TextField;
		
		var _point:Point;
		
		private const FontDefault:Class =_4_0.Library.Text_04b03;
		
		var _form:TextFormat;
		
		public function Text(str:String = "", x:int = 0, y:int = 0)
		{
			this._point = _4_0.FP.point;
			super();
			this._form = new TextFormat(Text.font, Text.size, Text.color, null, null, null, null, null, Text.align, null);
			this._text = new TextField();
			this._rect = new Rectangle();
			this._text.embedFonts = true;
			this._text.text = str;
			this.prepare();
			this.x = x;
			this.y = y;
		}
		
		public static function format(font:String = "", size:int = 0, color:uint = 0, align:String = ""):void
		{
			if (font)
			{
				Text.font = font;
			}
			if (size)
			{
				Text.size = size;
			}
			if (color)
			{
				Text.color = color;
			}
			if (align)
			{
				Text.align = align;
			}
		}
		
		public function get size():int
		{
			return int(this._form.size);
		}
		
		public function set size(value:int):void
		{
			this._form.size = value;
			this.prepare();
		}
		
		public function get align():String
		{
			return String(this._form.align);
		}
		
		public function set color(value:uint):void
		{
			this._form.color = value;
			this._text.textColor = value;
			this._data.draw(this._text);
		}
		
		public function prepare():void
		{
			this._text.setTextFormat(this._form);
			width = this._text.textWidth + 4;
			height = this._text.textHeight + 4;
			if (!this._data || width > this._data.width || height > this._data.height)
			{
				if (this._data)
				{
					this._data.dispose();
				}
				this._data = new BitmapData(width, height, true, 0);
				this._rect.width = this._text.width = width;
				this._rect.height = this._text.height = height;
			}
			else
			{
				this._data.fillRect(this._rect, 0);
			}
			this._data.draw(this._text);
		}
		
		public function set align(value:String):void
		{
			this._form.align = value;
			this.prepare();
		}
		
		public function get font():String
		{
			return String(this._form.font);
		}
		
		public function center():void
		{
			originX = width / 2;
			originY = height / 2;
		}
		
		override public function render():void
		{
			this._point.x = x - originX - _4_0.FP.camera.x;
			this._point.y = y - originY - _4_0.FP.camera.y;
			_4_0.FP.screen.copyPixels(this._data, this._rect, this._point);
		}
		
		public function set text(value:String):void
		{
			this._text.text = value;
			this.prepare();
		}
		
		public function set font(value:String):void
		{
			this._form.font = value;
			this.prepare();
		}
		
		public function get color():uint
		{
			return uint(this._form.color);
		}
		
		public function get text():String
		{
			return this._text.text;
		}
		
		public function format(font:String = "", size:int = 0, color:uint = 0, align:String = ""):void
		{
			if (font)
			{
				this._form.font = font;
			}
			if (size)
			{
				this._form.size = size;
			}
			if (align)
			{
				this._form.align = align;
			}
			if (color)
			{
				this._form.color = color;
				this._text.textColor = color;
			}
			this.prepare();
		}
	}
}
