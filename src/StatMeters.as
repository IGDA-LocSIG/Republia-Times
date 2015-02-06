package  
{
	import org.flixel.*;
	
	public class StatMeters extends FlxGroup
	{
		//private var moraleMeter:StatMeter;
		//private var lawfulMeter:StatMeter;
		//private var trustMeter:StatMeter;
		private var loyaltyMeter:StatMeter;
		private var readerNameText:FlxText;
		private var readerCountText:FlxText;
		
		public function StatMeters(x:int, y:int, onWhite:Boolean=true)
		{
			var readerHeight:int = 25;
			
			loyaltyMeter = new StatMeter(x, y+readerHeight+0, LocaleClass.loc["statmeters_construct1"]);
			add(loyaltyMeter); 
			add(loyaltyMeter.subObjects);

			var width:int = loyaltyMeter.width;
			
			readerNameText = new FlxText(x - 10, y, width + 20);
			readerNameText.setFormat("DEFAULTF", 8, onWhite ? 0xff000000 : 0xffffffff, "center",0,0,true);
			readerNameText.text = LocaleClass.loc["statmeters_construct2"];
			add(readerNameText);
			
			readerCountText = new FlxText(x-10, y+10, width+20);
			readerCountText.setFormat("MISC", 8, onWhite ? 0xff000000 : 0xffffffff, "center");
			add(readerCountText);
		}
		
		public function setValues(readership:Readership, showDelta:Boolean=true):void
		{
			readerCountText.text = "" + readership.curReaderCount;
			if (showDelta)
			{
				var delta:int = readership.curReaderCount - readership.preReaderCount;
				if (delta < 0) readerCountText.text += " (" + delta + ")";
				if (delta > 0) readerCountText.text += " (+" + delta + ")";
			}
			//moraleMeter.setValue(readership.curNewsResults.morale, showDelta ? readership.deltaNewsResults.morale : 0);
			//lawfulMeter.setValue(readership.curNewsResults.lawful, showDelta ? readership.deltaNewsResults.lawful : 0);
			//trustMeter.setValue(readership.curNewsResults.trust, showDelta ? readership.deltaNewsResults.trust : 0);
			loyaltyMeter.setValue(readership.curLoyalty, showDelta ? (readership.curLoyalty - readership.preLoyalty) : 0);
		}
	}
}

import org.flixel.*;

class StatMeter extends FlxSprite
{
	public var subObjects:FlxGroup;

	private var needle:FlxSprite;
	private var nameText:FlxText;
	private var valueText:FlxText;

	public function StatMeter(x:int, y:int, name:String) 
	{
		super(x, y, Assets.statMeter);

		subObjects = new FlxGroup();
		
		needle = new FlxSprite(x-1,y-1);
		needle.makeGraphic(width, height, 0x00, true);
		subObjects.add(needle);
		
		valueText = new FlxText(x+4, y+24, width-10);
		valueText.setFormat("MISC", 8, 0xffffffff, "center");
		subObjects.add(valueText);

		nameText = new FlxText(x + 4, y + 34, width - 10);
		nameText.setFormat("DEFAULTF", 8, 0xffffffff, "center",0,0,true);
		nameText.text = name;
		subObjects.add(nameText);
		
		//setValue(5);
	}
	
	private function getAngleForValue(value:int):Number
	{
		return -Math.PI/2 + value/Const.statMax * Math.PI/2;
	}
	public function setValue(value:int, delta:int=0):void
	{
		valueText.text = "" + value;
		//if (delta > 0) valueText.text += " (+" + delta + ")";
		//if (delta < 0) valueText.text += " (" + delta + ")";
		
		var centerX:Number = width/2;
		var centerY:Number = 23;
		var radius:Number = width/2-10;
		var angle:Number = getAngleForValue(value);
		needle.fill(0x00);
		
		if (delta)
		{
			var color:uint = delta > 0 ? 0xff00ff00 : 0xffff0000;
			var angle0:Number = getAngleForValue(Math.min(value-delta, value));
			var angle1:Number = getAngleForValue(Math.max(value-delta, value));
			for (var i:int=0; i<10; i++)
			{
				var t:Number = i / 9.0;
				var a:Number = angle0 + (angle1 - angle0) * t;
				needle.drawLine(centerX, centerY, centerX+radius*Math.cos(a), centerY+radius*Math.sin(a), color, 2);			
			}
		}
		
		needle.drawLine(centerX, centerY, centerX+radius*Math.cos(angle), centerY+radius*Math.sin(angle), 0xff000000, 2);			
	}
}
