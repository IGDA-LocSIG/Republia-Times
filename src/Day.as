package
{
	import org.flixel.*;

	public class Day
	{
		public var newsItems:Array = new Array();
		
		public function Day(dayIndex:int) 
		{
			var criticalNewsItems:Array = new Array();
			var weatherNewsItem:NewsItem = null;
			var nonCriticalNewsItems:Array = new Array();
			
			// shuffle
			Util.shuffleArray(NewsItem.allNewsItems);
			
			var containsRebelMessage:Boolean = false;
			
			// collect items as weather/critical/nonCritical
			for each (var newsItem:NewsItem in NewsItem.allNewsItems)
			{
				if (newsItem.used) continue;
				
				if (newsItem.isWeather())
				{
					if (!weatherNewsItem) weatherNewsItem = newsItem;
					continue;
				}
				
				if (newsItem.dayRangeStart || newsItem.dayRangeEnd)
				{
					if (
						(dayIndex >= newsItem.dayRangeStart && dayIndex <= newsItem.dayRangeEnd) ||
						(dayIndex == newsItem.dayRangeStart && newsItem.dayRangeEnd < 0) 
					){
						// critical item
						if (newsItem.isRebelLeader()) containsRebelMessage = true;
						criticalNewsItems.push(newsItem);
					}
				}
				else
				{
					// non-critical item
					nonCriticalNewsItems.push(newsItem);
				}
			}		

			// coallesce and splice
			var i:int;
			for (i=0; i<criticalNewsItems.length; i++) newsItems.push(criticalNewsItems[i]);
			if (weatherNewsItem) newsItems.push(weatherNewsItem);
			for (i=0; i<nonCriticalNewsItems.length; i++) newsItems.push(nonCriticalNewsItems[i]);

			// choose the first 7 to 10 entries (9 to 10 if containsRebelMessage)
			var maxNumItems:int = 10;
			var randomNumItems:int = containsRebelMessage ? 2 : 3;
			
			newsItems = newsItems.splice(0, (maxNumItems-randomNumItems) + Math.floor(Math.random()*randomNumItems));

			// shuffle again
			Util.shuffleArray(newsItems);
			
			FlxG.log("Day: " + newsItems.length + " newsItems");
			
			// choose random appearTime before noon
			i = 0;
			for each (var newsItem2:NewsItem in newsItems)
			{
				var t:Number = 0.75 * i / newsItems.length;
				if (dayIndex == 1) t *= 0.5;
				newsItem2.appearTime = Math.random() * t * Const.dayDuration;
				i++;
			}
		}
	}
}