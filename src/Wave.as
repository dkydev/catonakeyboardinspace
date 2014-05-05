package {

	public class Wave {
		
		public var random:Boolean;
		public var count:int;
		public var entityFunction:Function;
		public var mX:int;
		public var mY:int;
		public var duration:int;
		public var coords:Vector.<int>;
		public var offsetY:Boolean;
		
		public function Wave(	random:Boolean = false,
								entityFunction:Function = null,
								count:int = 0,
								duration:int = 100,
								mX:int = 0,
								mY:int = 0,
								coords:Vector.<int> = null,
								offsetY:Boolean = true):void {
			
			this.random = random;
			this.entityFunction = entityFunction;		
			this.count = count;
			
			this.mX = mX;
			this.mY = mY;
			this.duration = duration;
			this.coords = coords;
			this.offsetY = offsetY;
			
		}		
	}
}