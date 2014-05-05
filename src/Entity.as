package {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Entity extends Sprite {
		
		public var spdX:Number;
		public var spdY:Number;
		
		public var velX:Number;
		public var velY:Number;
		
		public var friction:Number;
		
		public var clip:MovieClip;
		public var game:Game;
		public var active:Boolean;
		
		public var hitRect:Rectangle;
		
		public var subset:Vector.<Entity>;
		
		public var hitBox:Image;
		
		public function Entity():void {
			
			friction = 0.7;			
			spdX = 0;
			spdY = 0;			
			velX = 0;
			velY = 0;
			
			active = true;
			
		}
		public function init(asset:String, hitRect:Rectangle):void {
			
			clip = new MovieClip(Assets.ASSETS.getTextures(asset), 24);
			addChild(clip);
			
			this.hitRect = hitRect;
			
			pivotX = width * 0.5;
			pivotY = height * 0.5;
			
			//hitbox

			/*hitBox = new Image(Assets.HITBOX);
			hitBox.x = width * 0.5 + hitRect.x;
			hitBox.y = height * 0.5 + hitRect.y;
			hitBox.width = hitRect.width;
			hitBox.height = hitRect.height;
			addChild(hitBox);*/
			
		}
		public function update():void {
			
			updateEntity();
			
		}
		public function updateEntity():void {
		
			x += velX;
			y += velY;
			
			velX *= friction;
			velY *= friction;
			
		}
		public function isTouching(e:Entity):Boolean {
			
			return (x + hitRect.x < e.x + e.hitRect.x + e.hitRect.width &&
					x + hitRect.x + hitRect.width > e.x + e.hitRect.x &&
					y + hitRect.y < e.y + e.hitRect.y + e.hitRect.height &&
					y + hitRect.y + hitRect.height > e.y + e.hitRect.y);
					
		}
	}
}