package  
{
	import org.flixel.*;
	import flash.events.MouseEvent;
	
	public class CenterPopup extends FlxSprite
	{
		public var subObjects:FlxGroup;
		private var nextButton:FlxButton;
		private var messageText:FlxText;
		
		public function CenterPopup() 
		{
			super(0, 0, Assets.centerPopup);
			
			x = FlxG.width/2 - width/2;
			y = FlxG.height/2 - height/2;
			
			subObjects = new FlxGroup();
			
			messageText = new FlxText(x + 40, y + 70, width - 80);
			messageText.setFormat("DEFAULTF", 8, 0xffffffff, "left",0,0,true);
			subObjects.add(messageText);
			
			nextButton = new FlxButton(x + width / 2 - Const.buttonW / 2, y + height - 50, "");
			nextButton.loadGraphic(Assets.button);
			nextButton.label.setFormat("DEFAULTF", 8, 0xff000000, "center",0,0,true);
			subObjects.add(nextButton);

			this.visible = false;
			nextButton.visible = false;
			messageText.visible = false;			
		}
		
		public function show(message:String, buttonText:String, onClick:Function):void
		{
			messageText.text = message;
			nextButton.label.text = buttonText;
			nextButton.onUp = onClick;
			
			this.visible = true;
			nextButton.visible = true;
			messageText.visible = true;
		}
		
		public function hide():void
		{
			this.visible = false;
			nextButton.visible = false;
			messageText.visible = false;
		}
	}
}
