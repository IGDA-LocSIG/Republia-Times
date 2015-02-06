package
{
	import org.flixel.*;
	
	public class Clock extends FlxSprite
	{
		public var dayNumberText:FlxText;
		
		public function Clock(dayNumber:int) 
		{
			super(0,0,null);
			makeGraphic(40, 40, 0x00, true);
			x = 30-width/2;
			y = 50-height/2;
			
			dayNumberText = new FlxText(0, 10, 60);
			dayNumberText.setFormat("DEFAULTF", 8, 0xff000000, "center",0,0,true);
			dayNumberText.text = LocaleClass.loc["clock_dayno"] + " " + dayNumber;
		}
		
		public function setTime(perc:Number):void
		{
			fill(0x00);
			
			var radius:Number = width*0.5;
			var centerX:Number = width*0.5;
			var centerY:Number = height*0.5;
			
			var hourPerc:Number = perc;
			var minutePerc:Number = perc * 60.0;
			var hourAngle:Number = Math.PI/2 + 2*Math.PI*hourPerc;
			var minuteAngle:Number = -Math.PI/2 + 2*Math.PI*minutePerc;
			var hourColor:uint = 0xff000000;
			var minuteColor:uint = 0xff000000;
			
			if (perc >= 0.75)
			{
				if ((int)(perc * 300) % 2 == 0) 
					hourColor = 0xffff0000;
			}
			
			drawLine(centerX, centerY, centerX+radius*0.75*Math.cos(hourAngle), centerY+radius*0.75*Math.sin(hourAngle), hourColor, 2);
			drawLine(centerX, centerY, centerX+radius*Math.cos(minuteAngle), centerY+radius*Math.sin(minuteAngle), minuteColor, 1);
		}
	}
}