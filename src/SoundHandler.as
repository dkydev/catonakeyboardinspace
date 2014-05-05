package {
	
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class SoundHandler {
		
		public var musicChannel:SoundChannel;
		public var effectChannel:SoundChannel;
		
		public function SoundHandler():void {
			
			musicChannel = new SoundChannel();
			effectChannel = new SoundChannel();
			
		}
		public function playSound(soundClass:Class):void {
			
			var snd:Sound;
			
			if (soundClass == Assets.SND_SONG_MAIN ||
				soundClass == Assets.SND_SONG_NYAN) {
					
				musicChannel.stop();
				snd = new soundClass();
				musicChannel = snd.play(0,100);
					
					
			}else {
				
				//effectChannel.stop();
				snd = new soundClass();
				effectChannel = snd.play();
				
			}
			
		}
		public function stopSound():void {
			
			musicChannel.stop();
			effectChannel.stop();
			
		}
	}
}