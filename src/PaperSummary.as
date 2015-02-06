package
{
	public class PaperSummary
	{
		public var numInterestingArticles:int = 0;
		public var numArticles:int = 0;
		public var articleCoveragePercentage:Number = 0;
		public var totalLoyaltyEffect:int = 0;
		
		public function PaperSummary()
		{
		}
		
		public function applyNewsItem(newsItem:NewsItem, articleSize:int):void
		{
			numArticles++;
			
			if (newsItem.interesting)
			{
				numInterestingArticles++;
			}
			
			var articleSizeMult:int = 1;
			if (articleSize == 1) articleSizeMult = 3;
			if (articleSize == 2) articleSizeMult = 6;			
			totalLoyaltyEffect += newsItem.loyaltyEffect * articleSizeMult;

			var maxArticleArea:Number = 4*5-1;
			if (articleSize == 0) articleCoveragePercentage += 1*2 / maxArticleArea;
			if (articleSize == 1) articleCoveragePercentage += 2*2 / maxArticleArea;
			if (articleSize == 2) articleCoveragePercentage += 3*3 / maxArticleArea;
		}
		
		public function toString():String
		{
			var str:String = "";
			str += "loy= " + totalLoyaltyEffect + " ";
			str += "int= " + numInterestingArticles + " ";
			str += "cov= " + String(articleCoveragePercentage).substr(0,6) + " ";
			return str;
		}
	}
}