package {
	
	public class WaveHandler {
		
		private var timer:int;
		private var counter:int;
		private var counterMax:int;
		private var game:Game;
		 
		public function WaveHandler(game:Game):void {
			
			this.game = game;
			
			timer = 0;
			counter = 0;
			counterMax = 50;
			
		}		
		public function update():void {
			
			timer ++;
			if (timer > 400) {
				
				timer = 0
				counterMax --;
				
				if (counterMax < 5) counterMax = 5;
				
			}
			
			counter ++;
			if (counter >= counterMax) {
			
				//game.newCoin(850, Math.random() * 600);
				game.newEnemy(Asteroid, 850, Math.random() * 600);
				game.newEnemy(Asteroid, 850, Math.random() * 600);
				
				counter = 0;
				
			}
		}		
	}
}