/*
 * 
 *  Nicholas Robson
 * 
 *  Assignment 2
 * 
 *  March 22nd, 2013
 * 
 */
package {
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class Game extends Sprite {
		
		public var store:Store;
		
		// game vars
		public var mapSpeed:Number;
		public var hero:Hero;
		
		public var backgroundContainer:Sprite;
		public var detailContainer:Sprite;
		public var entityContainer:Sprite;
		public var uiContainer:Sprite;
		
		public var bg1:Background;
		public var bg2:Background;
		
		// subset vectors
		public var setCoins:Vector.<Entity>;
		public var setProjectiles:Vector.<Entity>;
		public var setEnemies:Vector.<Entity>;
		
		public var entities:Vector.<Entity>;
		
		public var soundHandler:SoundHandler;
		public var waveHandler:WaveHandler;
		
		// UI
		
		public var storeButton:Button;
		
		public var textCoins:TextField;
		public var textShield:TextField;
		public var textAsteroids:TextField;
		
		public static var instance:Game;
		
		public function Game():void {
			
			//touchable = false; // Don't check for touching			
			
			instance = this;
			
			initializeGameStage();
			
		}		
		public function initializeGameStage():void {
			
			// Handler for coins, enemies, etc
			waveHandler = new WaveHandler(this);
			soundHandler = new SoundHandler();
			
			// Game Vars
			
			mapSpeed = 0.005;
			
			// Vectors
			entities = new Vector.<Entity>();				
			setProjectiles = new Vector.<Entity>();
			setEnemies = new Vector.<Entity>();
			setCoins = new Vector.<Entity>();
			
			// Containers
			backgroundContainer = new Sprite();
			detailContainer = new Sprite();
			entityContainer = new Sprite();
			uiContainer = new Sprite();
			
			addChild(backgroundContainer);
			addChild(detailContainer);
			addChild(entityContainer);
			addChild(uiContainer);
			
			// Backgrounds			
			bg1 = new Background(Assets.BG1, mapSpeed, 0.8);
			bg2 = new Background(Assets.BG2, mapSpeed);
			
			backgroundContainer.addChild(bg1);
			backgroundContainer.addChild(bg2);			
			
			// Hero
			hero = newHero(20, 260);
			
			// UI
			storeButton = new Button(Assets.ASSETS.getTexture("button0000"), "The Store");
			storeButton.x = 5;
			storeButton.y = 5;
			storeButton.fontColor = 0xffffff;
			
			textCoins = new TextField(100, 20, "Coins: 0", "Verdana", 10, 0xffffff);
			textCoins.x = 100;
			textCoins.y = 15;
			
			textShield = new TextField(100, 20, "Shield: 100%", "Verdana", 10, 0xffffff);
			textShield.x = 200;
			textShield.y = 15;
			
			uiContainer.addChild(storeButton);
			uiContainer.addChild(textCoins);
			uiContainer.addChild(textShield);
			
			// Store
			
			store = new Store(this);
			store.visible = false;
			
			uiContainer.addChild(store);
			
			//
			addEventListener(EnterFrameEvent.ENTER_FRAME, updateGameStage);
			
			closeStore();
			
			soundHandler.playSound(Assets.SND_SONG_MAIN);
		
		}
		
		public function gameOver():void {
			
			soundHandler.stopSound();
			Main.instance.gameOver();
			
		}
		
		public function updateGameStage(e:Event):void {		
			
			if (!store.active) {
			
				bg1.update((300 - hero.y) * -0.0003);
				bg2.update((300 - hero.y) * -0.0003);			
			
				waveHandler.update();
			
				updateEntities();
			
			}
			
			updateUI();
			
		}
		public function updateEntities():void {
		
			var length:int, i:int;
			
			length = entities.length;
			for (i = 0; i < length; i++) {
				
				if (entities[i].active) {
					
					entities[i].update();
					
				} else {	
					
					if (entities[i].subset != null) {	
						entities[i].subset.splice(entities[i].subset.indexOf(entities[i]), 1);
					}					
					
					entityContainer.removeChild(entities[i]);
					entities.splice(i, 1);
					i--;
					length--;
					
					continue;
					
				}
				
			}
		
		}		
		public function updateUI():void {
			
			textCoins.text = "Coins: " + hero.coins;
			textShield.text = "Shield: " + hero.shieldPercent + "%";
			
		}
		
		public function closeStore():void {
			
			store.active = false;
			store.visible = false;
			
			Mouse.hide();
			storeButton.addEventListener(Event.TRIGGERED, openStore);
			
		}
		public function openStore():void {
			
			store.active = true;
			store.visible = true;
			Mouse.show();
			storeButton.removeEventListener(Event.TRIGGERED, openStore);
			
		}
		
		public function addEntity(e:Entity, x:Number, y:Number, subset:Vector.<Entity> = null):void {
			
			e.game = this;
			
			e.x = x;
			e.y = y;
			
			entities.push(e);
			entityContainer.addChild(e);			
			Starling.juggler.add(e.clip);
			
			if (subset != null) {
				e.subset = subset;
				e.subset.push(e);
			}
			
		}
		public function removeEntity(e:Entity):void {
			
			e.active = false; // set for deletion
			entityContainer.removeChild(e);						
			Starling.juggler.remove(e.clip);
			
		}
		
		public function newHero(newX:Number, newY:Number):Hero {
			
			var hero:Hero = new Hero();
			
			addEntity(hero, newX, newY);			
			return hero;
			
		}
		public function newCoin(newX:Number, newY:Number, velX:Number = 0, velY:Number = 0 ):Entity {
			
			var coin:Coin = new Coin();
			
			coin.velX = velX;
			coin.velY = velY;			
			
			addEntity(coin, newX, newY, setCoins);
			return coin;
			
		}
		public function newEnemy(enemyClass:Class, newX:Number, newY:Number):Entity {
			
			var enemy:Enemy = new enemyClass();	
			
			addEntity(enemy, newX, newY, setEnemies);			
			return enemy;
			
			
		}
		public function newProjectile(projectileClass:Class, heroDamage:Boolean, spdX:Number, spdY:Number, newX:Number, newY:Number, rotation:Number = 0):Entity {
			
			var projectile:Projectile = new projectileClass();
			
			projectile.heroDamage = heroDamage;
			projectile.spdX = spdX;
			projectile.spdY = spdY;
			projectile.rotation = rotation;
			
			addEntity(projectile, newX, newY, setProjectiles);			
			return projectile;
			
		}
		
		
		
	}
}