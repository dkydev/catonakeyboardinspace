package {
	
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Hero extends Entity {
		
		public var leftBound:int = 30;
		public var rightBound:int = 760;
		public var topBound:int = 10;
		public var bottomBound:int = 570;
		
		public var keyLeft:uint;
		public var keyRight:uint;
		public var keyUp:uint;
		public var keyDown:uint;
		public var keyPrimary:uint;
		public var keySecondary:uint;
		
		public var shootTimer:int;
		public var shootTimerMax:int;
		
		public var shieldPercent:int;
		public var coins:int;
		
		// addons
		
		public var ammo:String;
		
		public var shield:Image;
		public var hat:Image;
		
		public var magnet:Boolean;
		public var nyan:Boolean;
		
		public var rainbows:Vector.<Image>;
		public var rainbowTimer:Number;
		
		//
		
		public function Hero():void {
			
			keyLeft = Key.LEFT;
			keyRight = Key.RIGHT;
			keyUp = Key.UP;
			keyDown = Key.DOWN;
			keyPrimary = Key.Z;
			keySecondary = Key.X;
			
			spdX = 2;
			spdY = 2;
			
			shootTimer = 0;
			shootTimerMax = 15;
			
			shieldPercent = 100;
			coins = 0;
			
			init("cat", new Rectangle( -35, -10, 85, 50));
			
			// addons			
			
			ammo = "laser";
			magnet = false;
			nyan = false;
			
			shield = new Image(Assets.ASSETS.getTexture("shield0000"));
			shield.alpha = 0;
			shield.y = 20;
			addChild(shield);
			
			rainbows = new Vector.<Image>();
			rainbowTimer = 0;
			
			hat = new Image(Assets.ASSETS.getTexture('tophat0000'));
			addChild(hat);
			hat.x = 66;
			hat.y = 12;
			hat.visible = false;
			
		}
		public function shoot():void {
			
			game.soundHandler.playSound(Assets.SND_LASER);
			
			if (ammo == "laser") {
				
				game.newProjectile(Laser, false, 10, 0, x + 50, y - 4);
				
			}
			if (ammo == "doublelaser") {
				
				game.newProjectile(Laser, false, 10, 0, x + 50, y - 8);
				game.newProjectile(Laser, false, 10, 0, x + 50, y);
				
			}
			if (ammo == "morelaser") {
				
				game.newProjectile(Laser, false, Math.cos(-0.2) * 10, Math.sin(-0.2) * 10, x + 50, y - 8, -0.2);			
				game.newProjectile(Laser, false, 10, 0, x + 50, y - 4);
				game.newProjectile(Laser, false, Math.cos(0.2) * 10, Math.sin(0.2) * 10, x + 50, y - 0, 0.2);
				
			}
			
		}
		public function damage(val:int):void {
			
			shieldPercent -= val;			
			
			velX -= 5;
			
			shield.alpha = 1;
			
			if (shieldPercent <= 0) {
				
				shieldPercent = 0;
				destroy();
				
			}
			
		}
		public function destroy():void {
			
			// GAMEOVER
			
			game.gameOver();
			
		}
		public function giveCoin():void {
			
			coins++;
			
			game.soundHandler.playSound(Assets.SND_COIN);
			// play coin get sound
			
			
		}
		override public function update():void {			
			
			velX -= (x - Main.instance.mouseX) / 20;
			velY -= (y - Main.instance.mouseY) / 20;
			
			//velX += (Input.key[keyRight] ? spdX : 0);
			//velX += (Input.key[keyLeft] ? -spdX : 0);
			//velY += (Input.key[keyDown] ? spdY : 0);
			//velY += (Input.key[keyUp] ? -spdY : 0);			
			
			updateEntity();
			
			if (x < leftBound) { 
				x = leftBound;
				velX = 0;
			}
			if (x > rightBound) { 
				x = rightBound;
				velX = 0;
			}
			if (y < topBound) { 
				y = topBound;
				velY = 0;
			}
			if (y > bottomBound) { 
				y = bottomBound;
				velY = 0;
			}
			
			rotation = (velX - velY) * 0.02;
			
			if (shootTimer > 0)
				shootTimer --;
			
			//if (Input.key[keyPrimary] && shootTimer == 0) {			
			if (shootTimer == 0) {
				
				shoot();
				shootTimer = shootTimerMax;
				
			}
			
			// addon updates
			
			if (magnet) {
				//if (Input.key[keySecondary]) {
					
					var e:Entity;
					var dx:Number, dy:Number;
					var d:Number;
					var length:int = game.setCoins.length;
					for (var i:int = 0; i < length; i++) {
						
						e = game.setCoins[i];
						if (e.active) {					
							
							dx = x - e.x;
							dy = y - e.y;
							d = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2));
							d = d * d;
							
							if (d != 0) {
								e.velX += (1 / d) * dx * 40;
								e.velY += (1 / d) * dy * 40;
							}
								
						}
						
					}
					
				//}
			}
			
			// shield alpha
			
			if (shield.alpha > 0) {
				
				shield.alpha -= 0.05;
				
			}
			
			// rainbow trail
			
			if (nyan) {
			
				rainbowTimer += 0.05;
				if (rainbowTimer > 6.28) {
					rainbowTimer = 0;
				}
					
				//var dis:int = Math.sqrt(Math.pow(velX, 2) + Math.pow(velY, 2));	
				//var ang:Number = Math.atan2(velY, velX);
				
				//for (var k:int = 0; k < dis+1; k ++) {
					
				var rainbow:Image = new Image(Assets.ASSETS.getTexture("rainbow0000"));
				rainbow.x = x-20;
				rainbow.y = y-12;
				game.detailContainer.addChild(rainbow);
				rainbows.push(rainbow);		
					
				//}
				
				for (var j:int = 0; j < rainbows.length; j++) {
					
					rainbows[j].x -= 4;
					rainbows[j].y += Math.sin(rainbowTimer) * 0.5;
					if (rainbows[j].x < -20) {
						game.detailContainer.removeChild(rainbows[j]);
						rainbows.splice(j, 1);
						j--;
					}
					
				}
			
			}
			
		}
		
	}
}