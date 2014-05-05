package {
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class StoreItem extends Button {
		
		public var title:String;
		public var description:String;
		public var infinite:Boolean;
		public var cost:int;
		public var callback:Function;
		
		public function StoreItem(title:String, description:String, cost:int, callback:Function, infinite:Boolean = false):void {
			
			this.title = title;
			this.description = description;
			this.cost = cost;
			this.callback = callback;
			this.infinite = infinite;
			
			super(Assets.ASSETS.getTexture("button0000"), title);
			fontColor = 0xffffff;
			
		}
			
	}
}