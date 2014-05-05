package {

	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import flash.geom.Rectangle;
	import starling.utils.VertexData;
	
	public class Background extends Sprite {
		
		public var scrollSpeed:Number;
		public var scrollOffset:Number;
		
		public var image:Image;
		public var coords:Vector.<Point>;
		
		public var randomColors:Boolean;
		
		public var blue:uint;
		public var red:uint;
		public var green:uint;
		
		public var tblue:uint;
		public var tred:uint;
		public var tgreen:uint;
		
		public function Background(texture:Texture, scrollSpeed:Number, scrollOffset:Number = 1):void {			
			
			texture.repeat = true;
			image = new Image(texture);
			addChild(image);
			
			this.scrollSpeed = scrollSpeed;
			this.scrollOffset = scrollOffset;			
		
			image.width *= 2;
			image.height *= 2;
			
			coords = new <Point>[new Point(), new Point(2,0), new Point(0,2), new Point(2,2)];
			setCoords();
			
			//
			//
			
			randomColors = false;
			red = 255;
			blue = 255;
			green = 255;
			tred = 255;
			tblue = 255;
			tgreen = 255;
			
		}
		public function setCoords():void {
			
			image.setTexCoords(0, coords[0]);
			image.setTexCoords(1, coords[1]);
			image.setTexCoords(2, coords[2]);
			image.setTexCoords(3, coords[3]);
			
			coords[0].x = coords[0].x % 2;
			coords[1].x = 2 + coords[0].x % 2;
			coords[2].x = coords[0].x % 2;
			coords[3].x = 2 + coords[0].x % 2;
			
		}
		public function update(offsetY:Number):void {
			
			if (randomColors) {
				
				if (Math.abs(blue-tblue)<=2)
					tblue = Math.random() * 255;
				if (Math.abs(red-tred)<=2)
					tred = Math.random() * 255;
				if (Math.abs(green-tgreen)<=2)
					tgreen = Math.random() * 255;
					
				blue += blue < tblue ? 2 : -2;
				red += red < tred ? 2 : -2;
				green += green < tgreen ? 2 : -2;
				
				image.color = red + (green << 8) + (blue << 16);
			
			}
			
			for (var i:int = 0; i < 4; i++) {
				
				coords[i].x += scrollSpeed * scrollOffset;
			}
			
			coords[0].y = offsetY * scrollOffset;
			coords[1].y = offsetY * scrollOffset;
			coords[2].y = 2 + offsetY * scrollOffset;
			coords[3].y = 2 + offsetY * scrollOffset;
			
			setCoords();
			
		}
	}
}