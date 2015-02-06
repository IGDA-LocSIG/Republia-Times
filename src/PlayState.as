package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		private var paper:Paper;
		private var feed:Feed;
		private var background:FlxSprite;

		private var time:Number;
		private var day:Day;
		private var clock:Clock;
		private var centerPopup:CenterPopup;
		
		private var endDayButton:FlxButton;
		private var speed:Number;
		
		private var dragText:FlxText;
		private var newsFeedText:FlxText;
		
		private var statMeters:StatMeters;	
		
		override public function create():void
		{
			FlxG.bgColor = 0xffffffff;
			FlxG.playMusic(Assets.nullSound);
			
			background = new FlxSprite(0,0);
			background.loadGraphic(Assets.backgroundImage);
			add(background);
			
			dragText = new FlxText(263, 50, 70);
			dragText.setFormat("DEFAULTF", 8, 0x000000, "left",0,0,true);
			dragText.text = LocaleClass.loc["playstate_create2"];
			add(dragText);
			
			newsFeedText = new FlxText(62, 3, 120);
			newsFeedText.setFormat("DEFAULTF", 8, 0xffffff, "left",0,0,true);
			newsFeedText.text = LocaleClass.loc["playstate_create3"];
			add(newsFeedText);

			paper = new Paper();
			
			clock = new Clock(GameStatus.instance.dayNumber);
			add(clock);
			add(clock.dayNumberText);
			
			endDayButton = new FlxButton(0, 94, "", onClickEndDay);
			//endDayButton.makeGraphic(60, 20, 0x00);
			endDayButton.loadGraphic(Assets.buttonTwoLinesSmall);
			endDayButton.label.setFormat("DEFAULTF", 8, 0x000000, "left", 0, 0, true);
			endDayButton.label.text = LocaleClass.loc["playstate_create1"];
			endDayButton.labelOffset = new FlxPoint((endDayButton.width - endDayButton.label.textWidth-4) / 2, (endDayButton.height - endDayButton.label.textHeight-4) / 2);
			add(endDayButton);
			
			statMeters = new StatMeters(3, 240);
			add(statMeters);
			
			statMeters.setValues(GameStatus.instance.readership, false);
			
			add(Util.createMuteButton(Util.kCornerCustom, 265, 5));
			Util.attachButtonSounds();
			
			feed = new Feed(paper);
			add(feed);
			add(feed.subObjects);

			add(paper);
			add(paper.subObjects);
			
			centerPopup = new CenterPopup();
			add(centerPopup);
			add(centerPopup.subObjects);

			time = 0;
			
			// slower on first day
			speed = (GameStatus.instance.dayNumber == 1) ? 0.5 : 1;
			
			day = new Day(GameStatus.instance.dayNumber);
		}
		
		override public function update():void
		{
			var prevTime:Number = time;
			time += FlxG.elapsed*speed;
			
			if (prevTime < 0.75 * Const.dayDuration && time >= 0.75 * Const.dayDuration)
			{
				FlxG.play(Assets.alarmSound, 0.25);
			}
			
			if (time > Const.dayDuration)
			{
				if (!centerPopup.visible)
				{
					paper.enabled = false;
					feed.enabled = false;
					FlxG.play(Assets.dayOverSound, 0.25);
					centerPopup.show(LocaleClass.loc["playstate_update1"], LocaleClass.loc["playstate_update2"], onClickDayOver);
				}
					
				time = Const.dayDuration;
			}
			
			// check for any new added newsItems
			for each (var newsItem:NewsItem in day.newsItems)
			{
				if (time > newsItem.appearTime && !feed.hasBlurb(newsItem))
				{
					// add blurb to feed for this news item
					//FlxG.log(time);
					feed.addBlurb(newsItem);
				}
			}
			
			if (FlxG.debug && FlxG.keys.pressed('K'))
			{
				GameStatus.instance.readership.applyPaperSummary(paper.getSummary());
				paper.markNewsItemsUsed();
				GameStatus.instance.dayNumber++;
				FlxG.switchState(new PlayState());
			}
			
			clock.setTime(time / Const.dayDuration);

			super.update();
		}
		
		protected function onClickEndDay():void
		{
			speed = 10;
		}
		
		protected function onClickDayOver():void
		{
			// apply paper summary to readership
			GameStatus.instance.readership.applyPaperSummary(paper.getSummary());
			paper.markNewsItemsUsed();
			
			FlxG.switchState(new NightState());
		}			
	}
}