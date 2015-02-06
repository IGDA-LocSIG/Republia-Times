package
{
	import org.flixel.*;
	
	public class NewsItem
	{
		public var dayRangeStart:int;
		public var dayRangeEnd:int;
		public var topic:String;
		private var blurbText:String;
		private var articleText:String;
		public var appearTime:Number = 0;
		public var used:Boolean = false;
		public var loyaltyEffect:int;
		public var interesting:Boolean;
		
		public static const kLoyaltyUp:int = 1;
		public static const kLoyaltyDown:int = -1;
		public static const kLoyaltyNone:int = 0;
		
		public static const kInteresting:Boolean = true;
		public static const kUninteresting:Boolean = false;
		
		public static var allNewsItems:Array = new Array(

// plot
	// if '|' is in blurbText, region is selected based on current goal status: kStatusNotWorking | kStatusWorkingTowards | kStatusMet
	new NewsItem(1, 3, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct1_1"], LocaleClass.loc["newsitem_construct1_2"]),
	new NewsItem(3, -1, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct2"], null),
	new NewsItem(4, -1, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct3"], null),
	new NewsItem(6, -1, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct4"], null),
	new NewsItem(7, -1, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct5"], null),
	new NewsItem(8, -1, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct6"], null),
	new NewsItem(9, -1, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct7"], null),
	new NewsItem(10, -1, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct8"], null),

	new NewsItem(7, 100, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct9_1"], LocaleClass.loc["newsitem_construct9_2"]),
	new NewsItem(8, 100, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct10_1"], LocaleClass.loc["newsitem_construct10_2"]),
	new NewsItem(9, 100, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct11_1"], LocaleClass.loc["newsitem_construct11_2"]),
	new NewsItem(10, 100, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct12_1"], LocaleClass.loc["newsitem_construct12_2"]),

// war (always interesting)
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct13_1"], LocaleClass.loc["newsitem_construct13_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct14_1"], LocaleClass.loc["newsitem_construct14_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct15_1"], LocaleClass.loc["newsitem_construct15_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct16_1"], LocaleClass.loc["newsitem_construct16_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct17_1"], LocaleClass.loc["newsitem_construct17_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct18_1"], LocaleClass.loc["newsitem_construct18_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct19_1"], LocaleClass.loc["newsitem_construct19_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct20_1"], LocaleClass.loc["newsitem_construct20_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct21_1"], LocaleClass.loc["newsitem_construct21_2"]),
	
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct22_1"], LocaleClass.loc["newsitem_construct22_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct23_1"], LocaleClass.loc["newsitem_construct23_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct24_1"], LocaleClass.loc["newsitem_construct24_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct25_1"], LocaleClass.loc["newsitem_construct25_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct26_1"], LocaleClass.loc["newsitem_construct26_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct27_1"], LocaleClass.loc["newsitem_construct27_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct28_1"], LocaleClass.loc["newsitem_construct28_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct29_1"], LocaleClass.loc["newsitem_construct29_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct30_1"], LocaleClass.loc["newsitem_construct30_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct31_1"], LocaleClass.loc["newsitem_construct31_2"]),

// 	politics (never interesting)
	new NewsItem(0, 0, kLoyaltyUp, kUninteresting, LocaleClass.loc["newsitem_construct32_1"], LocaleClass.loc["newsitem_construct32_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kUninteresting, LocaleClass.loc["newsitem_construct33_1"], LocaleClass.loc["newsitem_construct33_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kUninteresting, LocaleClass.loc["newsitem_construct34_1"], LocaleClass.loc["newsitem_construct34_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kUninteresting, LocaleClass.loc["newsitem_construct35_1"], LocaleClass.loc["newsitem_construct35_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kUninteresting, LocaleClass.loc["newsitem_construct36_1"], LocaleClass.loc["newsitem_construct36_2"]),

	new NewsItem(0, 0, kLoyaltyDown, kUninteresting, LocaleClass.loc["newsitem_construct37_1"], LocaleClass.loc["newsitem_construct37_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kUninteresting, LocaleClass.loc["newsitem_construct38_1"], LocaleClass.loc["newsitem_construct38_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kUninteresting, LocaleClass.loc["newsitem_construct39_1"], LocaleClass.loc["newsitem_construct39_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kUninteresting, LocaleClass.loc["newsitem_construct40_1"], LocaleClass.loc["newsitem_construct40_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kUninteresting, LocaleClass.loc["newsitem_construct41_1"], LocaleClass.loc["newsitem_construct41_2"]),

// weather (no loyalty effect, always interesting)
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct42_1"], LocaleClass.loc["newsitem_construct42_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct43_1"], LocaleClass.loc["newsitem_construct43_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct44_1"], LocaleClass.loc["newsitem_construct44_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct45_1"], LocaleClass.loc["newsitem_construct45_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct46_1"], LocaleClass.loc["newsitem_construct46_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct47_1"], LocaleClass.loc["newsitem_construct47_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct48_1"], LocaleClass.loc["newsitem_construct48_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct49_1"], LocaleClass.loc["newsitem_construct49_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct50_1"], LocaleClass.loc["newsitem_construct50_2"]),
	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct51_1"], LocaleClass.loc["newsitem_construct51_2"]),

// sports (always interesting)
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct52_1"], LocaleClass.loc["newsitem_construct52_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct53_1"], LocaleClass.loc["newsitem_construct53_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct54_1"], LocaleClass.loc["newsitem_construct54_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct55_1"], LocaleClass.loc["newsitem_construct55_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct56_1"], LocaleClass.loc["newsitem_construct56_2"]),

	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct57_1"], LocaleClass.loc["newsitem_construct57_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct58_1"], LocaleClass.loc["newsitem_construct58_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct59_1"], LocaleClass.loc["newsitem_construct59_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct60_1"], LocaleClass.loc["newsitem_construct60_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct61_1"], LocaleClass.loc["newsitem_construct61_2"]),

// entertainment (always interesting)
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct62_1"], LocaleClass.loc["newsitem_construct62_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct63_1"], LocaleClass.loc["newsitem_construct62_2"]),
	new NewsItem(0, 0, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct64_1"], LocaleClass.loc["newsitem_construct64_2"]),
	new NewsItem(2, -1, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct65_1"], LocaleClass.loc["newsitem_construct65_2"]),
	new NewsItem(3, -1, kLoyaltyUp, kInteresting, LocaleClass.loc["newsitem_construct66_1"], LocaleClass.loc["newsitem_construct66_2"]),

	new NewsItem(0, 0, kLoyaltyNone, kInteresting, LocaleClass.loc["newsitem_construct67_1"], LocaleClass.loc["newsitem_construct67_2"]),

	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct68_1"], LocaleClass.loc["newsitem_construct68_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct69_1"], LocaleClass.loc["newsitem_construct69_2"]),
	new NewsItem(0, 0, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct70_1"], LocaleClass.loc["newsitem_construct70_2"]),
	new NewsItem(6, -1, kLoyaltyDown, kInteresting, LocaleClass.loc["newsitem_construct71_1"], LocaleClass.loc["newsitem_construct71_2"]));
		
		public function NewsItem(
			dayRangeStart_:int, dayRangeEnd_:int, loyaltyEffect_:int,
			interesting_:Boolean, blurbText_:String, articleText_:String) 
		{
			dayRangeStart = dayRangeStart_;
			dayRangeEnd = dayRangeEnd_;
			loyaltyEffect = loyaltyEffect_;
			interesting = interesting_;
			blurbText = blurbText_;
			articleText = articleText_;
		}
		
		public function isWeather():Boolean
		{
			return blurbText.indexOf(LocaleClass.loc["newsitem_isweather"]) >= 0;
		}
		
		private function getProcessedText(str:String):String
		{
			if (str.indexOf("|") >= 0)
			{
				var tokens:Array = str.split("|");
				var goalStatus:int = Goal.getCurGoalStatus();
				str = tokens[goalStatus-1];			
				FlxG.log("goal status = " + goalStatus);
				FlxG.log("token = " + str);	
			}
			return GameStatus.expandGovNames(str);
		}
		
		public function getBlurbText():String
		{
			return getProcessedText(blurbText);
		}
		
		public function getArticleText():String
		{
			return articleText ? getProcessedText(articleText) : "";
		}
		
		public function hasArticleText():Boolean
		{
			return articleText != null;
		}
		
		public function isRebelLeader():Boolean
		{
			return blurbText.indexOf("***") >= 0;
		}
		
		public static function resetAllNewsItems():void
		{
			for each (var newsItem:NewsItem in allNewsItems)
			{
				newsItem.used = false;
			}
		}
	}
}