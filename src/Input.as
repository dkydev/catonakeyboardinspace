package  {

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;

	public class Input {
		
		public static var key:Vector.<Boolean> = new Vector.<Boolean>(255);
		public static var mouseIsDown:Boolean;
		public static var mousePoint:Point;
		
		public static var callback_keyDown:Vector.<Function>;
		public static var callback_keyUp:Vector.<Function>;
		public static var callback_click:Vector.<Function>;
		public static var callback_mouseWheel:Vector.<Function>;
		
		public static function initialize(mainStage:Stage):void {
			
			mouseIsDown = false;
			mousePoint = new Point();
			
			for (var i:int = 0; i < key.length; i++)				
				key[i] = false;				
			
			clear_callbacks();
			
			mainStage.addEventListener(MouseEvent.CLICK, mouseClick);
			mainStage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			mainStage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			mainStage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			mainStage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			mainStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			mainStage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
		}
		
		public static function clear_callbacks():void {
			
			callback_keyDown = new <Function>[];
			callback_keyUp = new <Function>[];
			callback_click = new <Function>[];
			callback_mouseWheel = new <Function>[];
			
		}
		private static function mouseMove(e:MouseEvent):void {
			
			mousePoint.x = e.stageX;
			mousePoint.y = e.stageY;
			
		}
		private static function mouseWheel(e:MouseEvent):void {
			
			for each (var callback:Function in callback_mouseWheel)
				callback(e.delta);
			
		}
		private static function mouseClick(e:MouseEvent):void {
			
			for each (var callback:Function in callback_click)
				callback();
			
		}		
		private static function mouseDown(e:MouseEvent):void {
			
			mouseIsDown = true;
			
		}		
		private static function mouseUp(e:MouseEvent):void {
			
			mouseIsDown = false;
			
		}		
		private static function keyDown(e:KeyboardEvent):void {
			
			if (key[e.keyCode] != true) {
				
				for each (var callback:Function in callback_keyDown)
					callback(e.keyCode);
				
			}
			
			key[e.keyCode] = true;	
			
		}		
		private static function keyUp(e:KeyboardEvent):void {
			
			if (key[e.keyCode] != false) {
					
				for each (var callback:Function in callback_keyUp)
					callback(e.keyCode);
				
			}
			
			key[e.keyCode] = false;
			
		}
	
	}
}