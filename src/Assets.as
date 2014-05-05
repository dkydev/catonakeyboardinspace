package {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets {
		
		[Embed(source = "../data/sprites/assets.png")] 
		private static const PNG_ASSETS:Class;
		[Embed(source = '../data/sprites/assets.xml', mimeType = "application/octet-stream")] 
		private static const XML_ASSETS:Class;
		
		[Embed(source = "../data/sprites/bg1.png")] 
		private static const PNG_BG1:Class;
		[Embed(source = "../data/sprites/bg2.png")] 
		private static const PNG_BG2:Class;
		
		public static var ASSETS:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new PNG_ASSETS(), false), XML(new XML_ASSETS()));
		
		// Backgrounds must be seperate textures to allow for repeating
		public static var BG1:Texture = Texture.fromBitmap(new PNG_BG1());
		public static var BG2:Texture = Texture.fromBitmap(new PNG_BG2());
		
		//

		//public static var HITBOX:Texture = Texture.fromBitmapData(new BitmapData(100, 100, true, 0x5000ff00), false);
		
		[Embed(source = "../data/sounds/newcoin.mp3")]
		public static var SND_COIN:Class;
		[Embed(source = "../data/sounds/newlaser.mp3")]
		public static var SND_LASER:Class;
		[Embed(source = "../data/sounds/newmainsong.mp3")]
		public static var SND_SONG_MAIN:Class;
		[Embed(source = "../data/sounds/newnyansong.mp3")]
		public static var SND_SONG_NYAN:Class;
		[Embed(source="../data/sounds/register.mp3")]
		public static var SND_REGISTER:Class;

	}

}