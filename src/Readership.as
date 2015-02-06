package
{
	import org.flixel.*;
	
	public class Readership
	{
		public var curReaderCount:int;
		public var preReaderCount:int;
		public var curLoyalty:int;
		public var preLoyalty:int;		
		public var comments:String;
		
		public function Readership(loyalty:int=0, readers:int=Const.readershipStartCount) 
		{
			curLoyalty = loyalty;
			preLoyalty = loyalty;
			curReaderCount = readers;
			preReaderCount = readers;
		}
		
		private static function getReadershipBonus(readerCount:int):Number
		{
			return 1 + 0.1 * (Math.floor((readerCount - Const.readershipStartCount) / Const.readershipBonusThresh));
		}
		
		public function getReaderCountDelta():int
		{
			return curReaderCount - preReaderCount;
		}

		public function getLoyaltyDelta():int
		{
			return curLoyalty - preLoyalty;
		}
		
		public function toString():String
		{
			var str:String = LocaleClass.loc["readership_tostr1"] + curLoyalty + "(" + getLoyaltyDelta() + ") ";
			str += LocaleClass.loc["readership_tostr2"] + curReaderCount + "(" + getReaderCountDelta() + ") ";
			return str;
		}
		
		public function applyPaperSummary(paperSummary:PaperSummary):void
		{
			preLoyalty = curLoyalty;
			preReaderCount = curReaderCount;
			
			comments = "";
			curLoyalty += paperSummary.totalLoyaltyEffect * getReadershipBonus(preReaderCount);
			if (curLoyalty > Const.statMax) curLoyalty = Const.statMax;
			if (curLoyalty < -Const.statMax) curLoyalty = -Const.statMax;
			
			if (paperSummary.articleCoveragePercentage == 0)
			{
				comments += LocaleClass.loc["readership_aplpapsum1"];
				curReaderCount *= 0.5;
			}
			else if (paperSummary.articleCoveragePercentage < 0.75)
			{
				comments += LocaleClass.loc["readership_aplpapsum2"];
				curReaderCount *= 0.75;
			}
			if (paperSummary.numInterestingArticles < 2)
			{
				comments += LocaleClass.loc["readership_aplpapsum3"];
				curReaderCount *= 0.9;
			}
			else if (paperSummary.numInterestingArticles > 2)
			{
				comments += LocaleClass.loc["readership_aplpapsum4"];
				curReaderCount *= 1.25;
			}
			
			if (curLoyalty > preLoyalty)
			{
				comments += LocaleClass.loc["readership_aplpapsum5"];
			}
			if (curLoyalty< preLoyalty)
			{
				comments += LocaleClass.loc["readership_aplpapsum6"];
			}
			
			var preReadershipBonus:Number = getReadershipBonus(preReaderCount);
			var curReadershipBonus:Number = getReadershipBonus(curReaderCount);
			if (curReadershipBonus > preReadershipBonus)
			{
				comments += LocaleClass.loc["readership_aplpapsum7"];
			}
			else if (curReadershipBonus > preReadershipBonus)
			{
				comments += LocaleClass.loc["readership_aplpapsum8"];
			}
		}
	}
}