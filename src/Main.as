/*
 * 
 *  Nicholas Robson
 * 
 *  Assignment 2
 * 
 *  March 22nd, 2013
 * 
 */
package {
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import starling.core.Starling;

	[SWF(width = "800", height = "600", frameRate = "60", backgroundColor = "#000000")]
	
	public class Main extends Sprite {
		
		private var starling:Starling;
		private var console:Console;
		
		public static var instance:Main;
		
		private var sTitle:scene_title;
		private var sInstructions:scene_instructions;
		private var sGameover:scene_gameover;
		
		
		public function Main():void {
			
			sTitle = new scene_title();
			sTitle.x = 20;
			sTitle.y = 130;						
			sTitle.startBtn.addEventListener(MouseEvent.CLICK, clickStart);
			sTitle.instructionsBtn.addEventListener(MouseEvent.CLICK, clickInstructions);
			addChild(sTitle);
			
			sInstructions = new scene_instructions();
			sInstructions.x = 240;
			sInstructions.y = 140;
			sInstructions.backBtn.addEventListener(MouseEvent.CLICK, clickBack);
			//addChild(sInstructions);
			
			instance = this; // to get global mouseX/Y
			
		}
		public function gameOver():void {
			
			Mouse.show();
			
			starling.stop();
			starling.stage3D.visible = false;
			
			sGameover = new scene_gameover();
			sGameover.x = 300;
			sGameover.y = 250;
			sGameover.replayBtn.addEventListener(MouseEvent.CLICK, clickReplay);
			addChild(sGameover);
			
		}
		private function clickStart(e:MouseEvent):void {
			
			removeChild(sTitle);					
			sTitle.startBtn.removeEventListener(MouseEvent.CLICK, clickStart);
			sTitle.instructionsBtn.removeEventListener(MouseEvent.CLICK, clickInstructions);
			sTitle = null;
						
			sInstructions.backBtn.removeEventListener(MouseEvent.CLICK, clickBack);
			sInstructions = null;	
				
			startGame();
			
		}
		private function clickReplay(e:MouseEvent):void {
			
			removeChild(sGameover);
			sGameover.replayBtn.removeEventListener(MouseEvent.CLICK, clickReplay);
			sGameover = null;
			
			starling.stage3D.visible = true;
			starling.start();
			
			Game.instance.initializeGameStage(); // GOOD ENOUGH FOR REPLAY
			
		}
		private function clickInstructions(e:MouseEvent):void {
			
			removeChild(sTitle);
			addChild(sInstructions);
			
		}
		private function clickBack(e:MouseEvent):void {

			removeChild(sInstructions);
			addChild(sTitle);
			
		}
		
		private function startGame():void {
			
			//console = new Console();			
			//Input.initialize(stage);
			
			starling = new Starling(Game, stage);
			//starling.showStatsAt("right", "bottom");
			starling.start();
			
			//addChild(console);
			
			//Input.callback_keyDown.push(function(keyCode:int):void { if (keyCode == Key.SPACEBAR) Console.clear(); } );
			
		}
	}
}