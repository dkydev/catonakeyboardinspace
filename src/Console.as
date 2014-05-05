package  {
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	
	public class Console extends Sprite {

		private static var INSTANCE:Console;
		
		private var textField:TextField;
		private var count:uint;
		public function Console():void	{
			
			textField = new TextField();
			textField.x = 0;
			textField.y = 0;
			//textField.width = 150;
			textField.height = 0;		
			
			textField.defaultTextFormat = new TextFormat("_sans", 10, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.RIGHT);
			textField.text = "";
			textField.embedFonts = false;
			textField.textColor = 0xFFFFFF;
			textField.selectable = false;
			textField.mouseEnabled = false;
			textField.wordWrap = true;
			//textField.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(textField);
			
			count = 0;
			
			Console.INSTANCE = this;
			
		}
		public static function resetHeight():void {
			
			INSTANCE.textField.width = Math.max(100, INSTANCE.textField.textWidth + 5);			
			INSTANCE.x = 800 - INSTANCE.textField.width;
			INSTANCE.textField.height = INSTANCE.textField.textHeight + 5;
			
			INSTANCE.graphics.clear();
			
			if (INSTANCE.textField.text.length > 0) {
				INSTANCE.graphics.beginFill(0x000000, 0.6);
				INSTANCE.graphics.drawRect(0, 0, INSTANCE.textField.width, INSTANCE.textField.height);	
			}
		}
		public static function log(... args):Class {
			
			var newString:String = "";
			
			for (var i:int = 0; i < args.length; i++) {
				
				if (args[i] is Object && args[i] != null)
					newString = newString + args[i].toString();
				else
					newString = newString + args[i];				
				
				if (i < args.length-1)
					newString = newString + " ";
			}
			
			INSTANCE.textField.text = newString + "\r" + INSTANCE.textField.text;
			resetHeight();
			return Console;
			
		}
		public static function clear():Class {
			
			INSTANCE.textField.text = "";
			resetHeight();
			return Console;
			
		}		
	}
}