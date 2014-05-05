package {
	
	import flash.geom.Rectangle;

	public class Coin extends Entity {
		
		public function Coin():void { 
				
			spdX = -0.5;
			spdY = 0;
			
			friction = 0.9;
			
			init("coin", new Rectangle( -10, -10, 20, 20));
			
		}
		
		override public function update():void {
			
			velX += spdX;
			velY += spdY;
			
			updateEntity();
			
			if (isTouching(game.hero)) {
				game.removeEntity(this);
				game.hero.giveCoin();
			}
			
			if (x < -50 || y < -50 || y > 650)
				game.removeEntity(this);
			
		}
	}
}