package {

	import flash.geom.Rectangle;
	
	public class Asteroid extends Enemy {
		
		public static const NAMES:Vector.<String> = new < String > [
								"asteroid10000", 
								"asteroid20000", 
								"asteroid30000"		];
		public static const RECTS:Vector.<Rectangle> = new < Rectangle > [	
								new Rectangle( -20, -20, 40, 40),
								new Rectangle( -18, -18, 36, 36),
								new Rectangle( -15, -15, 30, 30)	];
		public static const HEALTH:Vector.<int> = new <int> [5, 3, 1];
								
		public var velRotation:Number;
		public var health:int;
		
		public var asteroidLevel:int;
		
		private var colorVal:int;
		
		public function Asteroid():void {		
		
			asteroidLevel = Math.floor(Math.random() * 3);
			
			init(Asteroid.NAMES[asteroidLevel], Asteroid.RECTS[asteroidLevel]);
			
			health = HEALTH[asteroidLevel];
			
			spdX = -Math.random() - 0.5;
			spdY = 0;
			
			velRotation = Math.random() * 0.1 - 0.05;			
			
			colorVal = 255;
			
		}
		public function damage(val:int):void {
			
			health -= val;
			velX += 10;
			spdX += 0.2;
			colorVal = 0;
			if (health <= 0) {
				
				health = 0;				
				destroy(true);
				
			}
			
		}
		public function destroy(createCoins:Boolean):void {
			
			// create explosion images in detailcontainer on main
			
			game.removeEntity(this);
			
			if (createCoins) {
			
				for (var i:int = 0; i < (5 - asteroidLevel); i++) {
					game.newCoin(x, y, Math.random() * 20 - 10, Math.random() * 20 - 10);
				}
			
			}
			
		}
		override public function update():void {
			
			rotation += velRotation;
			
			velX += spdX;
			velY += spdY;
			
			updateEntity();
			
			if (isTouching(game.hero)) {
				destroy(false);
				game.hero.damage(5);
			}
			
			var length:int = game.setProjectiles.length;
			for (var i:int = 0; i < length; i ++) {
				
				if (game.setProjectiles[i].active && isTouching(game.setProjectiles[i])) {
					
					game.removeEntity(game.setProjectiles[i]);
					damage(1);
					
					break;
					
				}
				
			}
			
			if (x < -50 || y < -50 || y > 650)
				game.removeEntity(this);
				
			// color update
			
			colorVal += 100;
			if (colorVal >= 255) {
				colorVal = 255;				
			}
			clip.color = colorVal + (colorVal << 8) + (255 << 16);
			
		}
	}
}