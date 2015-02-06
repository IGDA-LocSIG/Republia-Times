package
{
	import org.flixel.*;
 
	public class NightState extends FlxState
	{
		private var time:Number;
		private var messageText:FlxText;
		private var nextButton:FlxButton;
		private var statMeters:StatMeters;
		//private var printedPapersGroup:FlxGroup;
		//private var printedPaperMasks:FlxGroup;
		//private const kPrintedPaperSpacingX:int = 70;
		//private const kPrintedPapersY:int = 40;
		//private const kPrintedPapersH:int = 100;
		private var printedPaper:FlxSprite;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			FlxG.playMusic(Assets.nightMusic, 0.5);
			
			time = 0;
			
			/*
			printedPapersGroup = new FlxGroup();
			var i:int = 0;
			var numPrintedPapers:int = FlxG.width/kPrintedPaperSpacingX + 1;
			for (i=0; i<numPrintedPapers; i++)
			{
				var printedPaper:FlxSprite = new FlxSprite(0,0,Assets.printedPaperImage);
				printedPapersGroup.add(printedPaper);
			}			
			add(printedPapersGroup);
			
			var printedPaperMaskW:int = 120;
			var printedPaperMask:FlxSprite;
			printedPaperMask = new FlxSprite(0,kPrintedPapersY);
			printedPaperMask.makeGraphic(printedPaperMaskW, kPrintedPapersH, 0xff000000);
			add(printedPaperMask);
			printedPaperMask = new FlxSprite(FlxG.width-printedPaperMaskW,kPrintedPapersY);
			printedPaperMask.makeGraphic(printedPaperMaskW, kPrintedPapersH, 0xff000000);
			add(printedPaperMask);			
			*/
			
			printedPaper = new FlxSprite(0,0,Assets.printedPaperImage);
			printedPaper.x = FlxG.width/2 - printedPaper.width/2;
			printedPaper.y = 30;
			add(printedPaper);
			
			nextButton = new FlxButton(FlxG.width/2 - Const.buttonW/2, FlxG.height-50, "", onClickNext);
			nextButton.loadGraphic(Assets.button);
			nextButton.label.setFormat("DEFAULTF", 8, 0xff000000, "center",0,0,true);
			nextButton.label.text = LocaleClass.loc["nightstate_create1"];
			add(nextButton);
			
			messageText = new FlxText(100, 110, FlxG.width-200);
			messageText.setFormat("DEFAULTF", 8, 0xffffff, "left",0,0,true);
			add(messageText);
			
			statMeters = new StatMeters(FlxG.width-90, 120, false);
			add(statMeters);
			
			//rs.curNewsResults.dumpToLog("CUR");
			//rs.preNewsResults.dumpToLog("PRE");
			//rs.deltaNewsResults.dumpToLog("DELTA");
			
			var rs:Readership = GameStatus.instance.readership;

			statMeters.setValues(rs);
			
			var message:String = LocaleClass.loc["nightstate_create2"];
			message += "      " + formatResult(LocaleClass.loc["nightstate_create3"], rs.curLoyalty, rs.curLoyalty - rs.preLoyalty) + "\n";
			message += "      " + formatResult(LocaleClass.loc["nightstate_create4"], rs.curReaderCount, rs.curReaderCount - rs.preReaderCount) + "\n\n";
			message += rs.comments;
			
			messageText.text = message;
			messageText.y = 180 - messageText.height/2;
			
			add(Util.createMuteButton(Util.kCornerBL));
			Util.attachButtonSounds();
			//messageText += "You have lost "
		}
		
		private function formatResult(name:String, value:int, delta:int):String
		{
			var str:String = name + ": " + value;
			if (delta > 0) str += "   (+" + delta + ")";
			else if (delta < 0) str+= "   (" + delta + ")";
			else str += LocaleClass.loc["nightstate_formatres"];
			return str;
		}
		
		override public function update():void
		{
			var prevTime:Number = time;
			time += FlxG.elapsed;
			
			/*
			Scrolling these goes straight to siezure town. Collapsed into a single image.
			var i:int = 0;
			for each (var item:FlxBasic in printedPapersGroup.members)
			{
				var printedPaper:FlxSprite = item as FlxSprite;
				printedPaper.x = (0 %  1.0) * kPrintedPaperSpacingX + (printedPapersGroup.members.length-i-1) * kPrintedPaperSpacingX - 1*kPrintedPaperSpacingX;
				printedPaper.y = kPrintedPapersY;
				i += 1;
			}
			*/
			
			super.update();
		}
		
		protected function onClickNext():void
		{
			GameStatus.instance.dayNumber++;
			FlxG.switchState(new MorningState());
		}			
	}
}
