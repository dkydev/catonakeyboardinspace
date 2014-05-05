package {
	
	import flash.geom.Rectangle;

	public class Laser extends Projectile {
		
		public function Laser():void {
			
			init("laser", new Rectangle( -10, -4, 40, 8));
			
		}		
	}
}