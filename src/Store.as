package {
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Store extends Sprite {
		
		// ** Buy Items **
		
		// lasers
		// more lasers
		// missiles
		// repair shield
		// coin magnet
		// tophat
		// nyancat
		
		
		// layout settings
		private const storeWidth:int = 400;
		private const storeHeight:int = 550;
		
		private const cols:int = 2;
		private const colWidth:int = 110;
		private const rowHeight:int = 50;
		
		//private const colStart:int = 40;
		private const rowStart:int = 100;
		
		//
		
		private var game:Game;
		private var selectedItem:StoreItem;
		
		private var items:Vector.<StoreItem>;
		
		public var active:Boolean;
		
		private var descriptionTextfield:TextField;
		
		public function Store(game:Game):void {
			
			this.game = game;
			active = false;
			items = new Vector.<StoreItem>();		
			
			x = (800 - storeWidth) / 2 ;
			y = (600 - storeHeight) / 2 ;
			
			var bg:Quad = new Quad(storeWidth, storeHeight, 0x000000);
			bg.alpha = 0.5;
			var title:TextField = new TextField(100, 30, "The Store", "Verdana", 12, 0xffffff, true);
			title.x = storeWidth * 0.5 - 50;
			title.y = 10;			
			
			addChild(bg);
			addChild(title);
			
			addItem(new StoreItem("Repair Shield", "+25% to shield", 20, buyShield, true));
			addItem(new StoreItem("Double Lasers","add double lasers", 30, buyDoubleLaser));			
			addItem(new StoreItem("Coin Magnet","attract coins to you", 50, buyCoinMagnet));
			addItem(new StoreItem("More Lasers","more lasers", 300, buyMoreLaser));
			addItem(new StoreItem("A Hat","a nice hat", 500, buyHat));
			addItem(new StoreItem("Special","□□□□□ □□□□□□□□□□ □□□□□□□□ □□□□", 1000, buyNyan));			
			
			descriptionTextfield = new TextField(300, 40, "", "Verdana", 10, 0xffffff, false);
			descriptionTextfield.x = storeWidth * 0.5 - 150;
			descriptionTextfield.y = rowStart + (Math.floor(items.length / cols)) * rowHeight + 90;
			
			var buyButton:Button = new Button(Assets.ASSETS.getTexture("button0000"), "Buy");
			buyButton.x = 90;
			buyButton.y = rowStart + (Math.floor(items.length / cols)) * rowHeight + 150;
			buyButton.fontColor = 0xffffff;
			
			buyButton.addEventListener(Event.TRIGGERED, clickBuy);
			
			var cancelButton:Button = new Button(Assets.ASSETS.getTexture("button0000"), "Leave");
			cancelButton.x = 200;
			cancelButton.y = rowStart + (Math.floor(items.length / cols)) * rowHeight + 150;
			cancelButton.fontColor = 0xffffff;
			
			cancelButton.addEventListener(Event.TRIGGERED, clickCancel);			
						
			
			addChild(descriptionTextfield);
			addChild(buyButton);
			addChild(cancelButton);
			
		}
		private function addItem(newItem:StoreItem):void {
			
			newItem.x = (storeWidth - (colWidth * cols)) / 2 + colWidth * (items.length % cols);
			newItem.y = rowStart + Math.floor(items.length / cols) * rowHeight;
			
			items.push(newItem);
			addChild(newItem);
			
			newItem.addEventListener(Event.TRIGGERED, clickItem);
			
		}
		public function clickCancel(e:Event):void {
			
			game.closeStore();
			
		}
		public function clickBuy(e:Event):void {
			
			if (selectedItem != null) {
				
				if (game.hero.coins >= selectedItem.cost) {
			
					game.hero.coins -= selectedItem.cost;
					
					selectedItem.callback();
					
					if (selectedItem.infinite == false) {
						
						selectedItem.removeEventListener(Event.TRIGGERED, clickItem)
						removeChild(selectedItem);
						
					}
			
					game.soundHandler.playSound(Assets.SND_REGISTER);
					descriptionTextfield.text = "bought item";
					
				} else {
					
					descriptionTextfield.text = "not enough coins";
					
				}		
				
			} else {
				
				descriptionTextfield.text = "select an item first";
				
			}
			
		}		
		public function clickItem(e:Event):void {
			
			var item:StoreItem = (e.target as StoreItem);
			
			selectedItem = item;
			descriptionTextfield.text = item.description + "\nCost: " + item.cost + " coins";
			
		}
		
		// item callbacks
		private function buyShield():void {
			
			game.hero.shieldPercent += 15;
			
		}
		private function buyDoubleLaser():void {
			
			game.hero.ammo = "doublelaser";
			game.hero.shootTimerMax = 10;
			
		}
		private function buyMoreLaser():void {
			
			game.hero.ammo = "morelaser";
			game.hero.shootTimerMax = 5;
			
		}
		private function buyHat():void {
			
			game.hero.hat.visible = true;
			
		}
		private function buyNyan():void {
			
			game.hero.nyan = true;
			game.bg1.scrollSpeed = 0.02;
			game.bg2.scrollSpeed = 0.016;
			game.bg1.randomColors = true;
			game.bg2.randomColors = true;
			game.soundHandler.playSound(Assets.SND_SONG_NYAN);
			
			game.closeStore();
			
		}
		private function buyCoinMagnet():void {
			
			game.hero.magnet = true;
			
		}
		
		
	}
}