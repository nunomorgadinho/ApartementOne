package utils
{
	import com.YDreams.utils.FPSMeasure;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class FramerateSprite extends Sprite
	{
		public function FramerateSprite()
		{			
			var myFps:TextField = new TextField();
			myFps.textColor = 0xffffff;
			var fps:FPSMeasure = new FPSMeasure(myFps);
			addChild(myFps);
		}
	}
}