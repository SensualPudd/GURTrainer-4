
package _4_0
{
	import _4_0.Main;
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import _4_0.jam.Level;
	import _4_0.jam.Stats;
	import _4_0.punk.util.Input;
	import _4_0.punk.util.Key;
	
	public class TAS extends Sprite
	{
		static public var instance:TAS = null;
		
		static public function get Instance():TAS
		{
			return (TAS.instance = ((TAS.instance == null) ? new TAS() : TAS.instance));
		}
		
		public const READ:Dictionary = new Dictionary(false);
		
		public const WRITE:Dictionary = new Dictionary(false);
		
		public var read:Object = null;
		
		public var virgin:Boolean = false;
		
		public var write:String = null;
		
		public function TAS()
		{
			super();
			
			this.READ["-"] = null;
			this.READ["+"] = {id: "down", keyCode: Key.DOWN};
			this.READ["Z"] = {id: "z", keyCode: Key.Z};
			this.READ["<"] = {id: "left", keyCode: Key.LEFT};
			this.READ[">"] = {id: "right", keyCode: Key.RIGHT};
			this.READ["~"] = {id: "skip", keyCode: Key.ENTER};
			this.READ["^"] = {id: "up", keyCode: Key.UP};
			
			this.WRITE[null] = "\r\n";
			this.WRITE["down"] = "+";
			this.WRITE["grapple"] = "Z";
			this.WRITE["jump"] = "^";
			this.WRITE["left"] = "<";
			this.WRITE["right"] = ">";
			this.WRITE["skip"] = "~";
			this.WRITE["up"] = "^";
			this.WRITE["z"] = "Z";
		}
		
		public function Initialize():TAS
		{
			this.read = null;
			
			this.virgin = true;
			
			this.write = new String();
			
			return this;
		}
		
		public function Open(level:Object):TAS
		{
			var file:File = null;
			
			var file_name:String = null;
			
			var file_name_split:Array = null;
			
			var file_stream:FileStream = null;
			
			var files:Array = null;
			
			var flag:Boolean = false;
			
			var read:String = null;
			
			this.Update (level);
			
			File.applicationStorageDirectory.resolvePath("TAS/" + level.mode + "/" + level.number).createDirectory();
			
			files = File.applicationStorageDirectory.resolvePath("TAS/" + level.mode + "/" + level.number).getDirectoryListing();
			
			files = files.sortOn("name");
			
			do
			{
				flag = false;
				
				for each (file in files)
				{
					if (file.isDirectory == false)
					{
					}
					else
					{
						files.splice(files.indexOf(file, 0), 1);
						
						flag = true;
						
						break;
					}
				}
				
				if (flag == false)
				{
					break;
				}
				else
				{
					continue;
				}
			}
			while (true);
			
			for each (file in files)
			{
				file_name = file.name;
				
				file_name_split = file_name.split("_");
				
				if ((file_name_split[0] == "TAS") && (file_name_split[2] == level.number.toString()))
				{
					break;
				}
				
				file = null;
			}
			
			this.Initialize();
			
			if ((file == null) || (file.exists == false))
			{
			}
			else
			{
				trace (file.name);
				
				file_stream = new FileStream();
				
				file_stream.open(file, FileMode.READ);
				{
					read = file_stream.readUTFBytes(file_stream.bytesAvailable);
				}
				file_stream.close();
				
				this.read = read.split("\r\n");
				
				this.read =
				{
					data:this.read,
					index:0,
					length:this.read.length,
					time:_4_0.Main.instance.Time (this.read.length)
				}
			}
			
			return this;
		}
		
		public function Read(index:uint):TAS
		{
			var r:Object = null;
			
			var read:Array = null;
			
			if (this.read == null)
			{
			}
			else
			{
				//this.read.index = Math.max (0, index);
				
				if (this.read.index < this.read.length)
				{
					if (this.read.index > 0)
					{
						read = this.read.data [this.read.index - 1].split ("");
						
						for each (r in read)
						{
							r = this.READ[r];
							
							((r == null) ? null : Input.onKeyUp(r));
						}
					}
					
					read = this.read.data [this.read.index].split ("");
					
					for each (r in read)
					{
						r = this.READ[r];
						
						if (r == null)
						{
						}
						else
						{
							if (this.virgin == false)
							{
							}
							else
							{
								this.virgin = false;
							}
							
							Input.onKeyDown(r);
						}
					}
					
					this.read.index++;
				}
			}
			
			return this;
		}
		
		public function Save(level:Object):TAS
		{
			var file:File = null;
			
			var file_stream:FileStream = null;
			
			var write:Object = null;
			
			//File.applicationStorageDirectory.resolvePath("TAS" + "/" + level.mode + "/" + level.number).createDirectory();
			File.applicationStorageDirectory.resolvePath("TAS" + "/" + level.mode_prefix).createDirectory();
			
			write = this.write.split("\r\n");
			
			do
			{
				if (write.length == level.time)
				{
					break;
				}
				else
				{
					write.pop();
				}
			}
			while (true);
			
			file_stream = new FileStream();
			
			file = File.applicationStorageDirectory.resolvePath("TAS/" + level.mode_prefix + "/" + "TAS_" + level.name + "_" + _4_0.Main.instance.Time (level.time) + ".txt");
			
			file = new File(file.nativePath);
			
			write = write.join("\r\n");
			
			file_stream.open(file, FileMode.WRITE);
			file_stream.writeUTFBytes(String(write));
			file_stream.close();
			
			return this;
		}
		
		public function Update (level:Object) : TAS
		{
			var file:File = null;
			
			var file_name:String = null;
			
			var file_name_split:Array = null;
			
			var file_stream:FileStream = null;
			
			var files:Array = null;
			
			var read:String = null;
			
			File.applicationStorageDirectory.resolvePath("TAS/" + level.mode + "/" + level.number).createDirectory();
			
			files = File.applicationStorageDirectory.resolvePath("TAS/" + level.mode + "/" + level.number).getDirectoryListing();
			
			for each (file in files)
			{
				// UPDATE TAS FILE NAME..
				
				file_name = file.name;
				
				file_name_split = file_name.split(" ");
				
				file_name = file_name_split.join ("_");
				
				file_name_split = file_name.split("_");
				
				if ((file_name_split [1] == "L") || (file_name_split [1] == "H"))
				{
				}
				else
				{
					file_stream = new FileStream();
					
					file_stream.open(file, FileMode.READ);
					{
						read = file_stream.readUTFBytes(file_stream.bytesAvailable);
					}
					file_stream.close();
					
					file.deleteFile ();
					
					level =
					{
						mode:file.parent.name,
						number:(isNaN (file_name_split [1]) ? file_name_split [2] : file_name_split [1]),
						time:read.split ("\r\n").length
					};
					
					file_stream = new FileStream();
					
					file = File.applicationStorageDirectory.resolvePath("TAS/" + level.mode + "/" + level.number + "/" + "TAS_" + level.mode + "_" + level.number + "_" + level.time + "_" + _4_0.Main.instance.Time (level.time) + ".txt");
					
					file = new File(file.nativePath);
					
					file_stream.open(file, FileMode.WRITE);
					file_stream.writeUTFBytes(read);
					file_stream.close();
				}
			}
			
			return this;
		}
		
		public function Write(input:Object):TAS
		{
			input = this.WRITE[input];
			
			input = ((input == null) ? "" : input);
			
			this.write = (this.write + input);
			
			return this;
		}
	}
}
