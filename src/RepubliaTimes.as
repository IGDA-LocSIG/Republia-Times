package 
{
	import org.flixel.*; //Allows you to refer to flixel objects in your code
 
	public class RepubliaTimes extends FlxGame
	{
		public function RepubliaTimes()
		{
			super(540,320,MorningState,2,60,30,true); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			//FlxG.debug = true;
			//this.useSystemCursor = true;
			//FlxG.mouse.show();//Assets.cursorImage, 2, 20, 20);
		}
	}
}