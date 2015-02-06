package
{
	import org.flixel.*;
		
	public class Goal
	{
		// goals must be fulfilled by the end of targetDayNumber
		public var id:String;
		public var targetDayNumber:int;
		public var targetLoyalty:int;
		public var targetReaderCount:int;
		
		public static const kStatusNone:int = 0;
		public static const kStatusNotWorking:int = 1;
		public static const kStatusWorkingTowards:int = 2;
		public static const kStatusMet:int = 3;	
		
		public static var allGoals:Array = new Array(
			new Goal("first-state", 3, 20, 0),
			new Goal("second-state", 5, 20, 400),
			new Goal("last-rebel", 10, -30, 1000)
		);
		
		public function Goal(id_:String, targetDayNumber_:int,targetLoyalty_:int,targetReaderCount_:int)
		{
			id = id_;
			targetDayNumber = targetDayNumber_;
			targetLoyalty = targetLoyalty_;
			targetReaderCount = targetReaderCount_;
		}
		
		public function isMet():Boolean
		{
			var gs:GameStatus = GameStatus.instance;
			if (targetLoyalty < 0 && gs.readership.curLoyalty > targetLoyalty)
				return false;
			if (targetLoyalty > 0 && gs.readership.curLoyalty < targetLoyalty)
				return false;
			if (targetReaderCount && gs.readership.curReaderCount < targetReaderCount)
				return false;			
			return true;
		}
		
		public function getStatus():int
		{
			if (isMet()) return kStatusMet;
		
			var gs:GameStatus = GameStatus.instance;
			if (targetLoyalty < 0 && gs.readership.curLoyalty > targetLoyalty)
			{
				// working towards negative loyalty
				if (gs.readership.getLoyaltyDelta() < 0) return kStatusWorkingTowards;
				else return kStatusNotWorking;
			}
			if (targetLoyalty > 0 && gs.readership.curLoyalty < targetLoyalty)
			{
				// working towards positive loyalty
				if (gs.readership.getLoyaltyDelta() > 0) return kStatusWorkingTowards;
				else return kStatusNotWorking;				
			}
			if (targetReaderCount && gs.readership.curReaderCount < targetReaderCount)
			{
				if (gs.readership.getReaderCountDelta() > 0) return kStatusWorkingTowards;
				else return kStatusNotWorking;
			}
			
			return kStatusNone;
		}
		
		public function toString():String
		{
			return "day=" + targetDayNumber + " loy="  + targetLoyalty + " cnt=" + targetReaderCount;
		}
		
		public static function getGoalForDay(dayNumber:int):Goal
		{
			for each (var goal:Goal in allGoals)
			{
				if (goal.targetDayNumber >= dayNumber) return goal;
			}
			return null;
		}
		
		public static function getCurGoalStatus():int
		{
			var goal:Goal = getGoalForDay(GameStatus.instance.dayNumber);
			FlxG.log("cur goal = " + goal.toString());
			return goal.getStatus();
		}
	}
}
