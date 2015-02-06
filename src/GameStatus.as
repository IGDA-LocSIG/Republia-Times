package
{
	public class GameStatus
	{
		public var readership:Readership;
		public var dayNumber:int;
		public var stateInControl:Boolean = true;
		public var haveWonAtLeastOnce:Boolean = false;
		
		public static var instance:GameStatus = new GameStatus();
		
		public function GameStatus()
		{
			instance = this;
			reset();
		}
		
		public function reset():void
		{
			readership = new Readership();
			dayNumber = 1;
			//readership = new Readership(30, 400);
			//dayNumber = 6;			
			NewsItem.resetAllNewsItems();
		}
		
		public static function getGovName():String
		{
			return instance.stateInControl ? LocaleClass.loc["gamestatus_rep"] : LocaleClass.loc["gamestatus_demo"];
		}
		
		public static function expandGovNames(str:String):String
		{
			var myPattern:RegExp = /\[GOV\]/g;  
			return str.replace(myPattern, getGovName());
		}
	}
}
