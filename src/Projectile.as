package {
	
	import flash.geom.Rectangle;

	public class Projectile extends Entity {
		
		public var heroDamage:Boolean;
		
		public function Projectile():void {
			
		}		
		override public function update():void {
			
			velX = spdX;
			velY = spdY;
			
			updateEntity();
			
			if (x < -50 || x > 850 || y < -50 || y > 650)
				game.removeEntity(this);
				
		}
		
	}
}