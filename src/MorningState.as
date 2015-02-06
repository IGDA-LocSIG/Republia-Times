package
{
	import org.flixel.*;
 
	public class MorningState extends FlxState
	{
		private var time:Number;
		private var backgroundSprite:FlxSprite;
		private var logoSprite:FlxSprite;
		private var messageText:FlxText;
		private var nextButton:FlxButton;
		private var dayText:FlxText;
		private var creditsText:FlxText;
		private var statMeters:StatMeters;
		
		override public function create():void
		{
			FlxG.bgColor = 0xffffffff;
			FlxG.playMusic(Assets.mainMusic, 0.5);
			
			time = 0;
			
			var gs:GameStatus = GameStatus.instance;
			var rs:Readership = gs.readership;
			var dayNumber:int = gs.dayNumber;
			var goal:Goal = Goal.getGoalForDay(dayNumber);
			var prevGoal:Goal = Goal.getGoalForDay(dayNumber-1);
			
			var gameOver:Boolean = false;
			var rebelsWon:Boolean = false;
			
			var killMessage:String = LocaleClass.loc["morningstate_createkm"];
			
			var message:String = "";
			if (dayNumber == 1)
			{
				message += LocaleClass.loc["morningstate_createm1"];
				if (gs.stateInControl)
				{
					message += LocaleClass.loc["morningstate_createm2"];
					message += LocaleClass.loc["morningstate_createm3"];
				}
				else
				{
					message += LocaleClass.loc["morningstate_createm4"];
				}
				message += LocaleClass.loc["morningstate_createm5"];
				message += LocaleClass.loc["morningstate_createm6"];
				message += LocaleClass.loc["morningstate_createm7_1"] + goal.targetLoyalty + LocaleClass.loc["morningstate_createm7_2"];
				
				if (gs.haveWonAtLeastOnce)
				{
					message += LocaleClass.loc["morningstate_createm8"];
					message += LocaleClass.loc["morningstate_createm9"];
				}
				else
				{
					message += LocaleClass.loc["morningstate_createm10"];
				}
			}
			else if (goal && goal != prevGoal)
			{
				// check prevGoal completion
				if (prevGoal.id == "first-state")
				{
					if (rs.curLoyalty >= prevGoal.targetLoyalty)
					{
						message += LocaleClass.loc["morningstate_createm11"];
						message += LocaleClass.loc["morningstate_createm12_1"] + goal.targetLoyalty + LocaleClass.loc["morningstate_createm12_2"];
						message += LocaleClass.loc["morningstate_createm13"];
						message += LocaleClass.loc["morningstate_createm14_1"] + goal.targetReaderCount + LocaleClass.loc["morningstate_createm14_2"] + goal.targetDayNumber + ".";
					}
					else 
					{
						message += LocaleClass.loc["morningstate_createm15"];
						message += killMessage;
						gameOver = true;
					}
				}
				else if (prevGoal.id == "second-state")
				{
					if (prevGoal.isMet())
					{
						message += LocaleClass.loc["morningstate_createm16"];
						message += LocaleClass.loc["morningstate_createm17"];
						message += LocaleClass.loc["morningstate_createm18"];
					}
					else 
					{
						message += LocaleClass.loc["morningstate_createm19_1"] + goal.targetLoyalty + LocaleClass.loc["morningstate_createm19_2"];
						message += killMessage;
						gameOver = true;
					}
				}
			}
			else if (goal && goal.id.indexOf("state") >= 0)
			{
				// working for state
				if (rs.curLoyalty >= goal.targetLoyalty)
				{
					message += LocaleClass.loc["morningstate_createm20"];
					message += LocaleClass.loc["morningstate_createm21_1"] + goal.targetLoyalty + LocaleClass.loc["morningstate_createm21_2"];
				}
				else if (rs.getLoyaltyDelta() > 0)
				{
					message += LocaleClass.loc["morningstate_createm22"];
					message += LocaleClass.loc["morningstate_createm23_1"] + goal.targetLoyalty + LocaleClass.loc["morningstate_createm23_2"] + goal.targetDayNumber + ".";
				}
				else if (rs.getLoyaltyDelta() < 0)
				{
					message += LocaleClass.loc["morningstate_createm24"];
					message += LocaleClass.loc["morningstate_createm25"];
					message += LocaleClass.loc["morningstate_createm26_1"] + goal.targetLoyalty + LocaleClass.loc["morningstate_createm26_2"] + goal.targetDayNumber + "."; 
				}
				else if (rs.getLoyaltyDelta() == 0)
				{
					message += LocaleClass.loc["morningstate_createm27"];
					message += LocaleClass.loc["morningstate_createm28"];
					message += LocaleClass.loc["morningstate_createm29_1"] + goal.targetLoyalty + LocaleClass.loc["morningstate_createm29_2"] + goal.targetDayNumber + "."; 
				}				
				if (goal.targetReaderCount)
				{
					message += "\n";
					if (rs.curReaderCount >= goal.targetReaderCount)
					{
						//message += "Good work. You have reached the requested readership quota.\n\n";
						message += LocaleClass.loc["morningstate_createm30_1"] + goal.targetReaderCount + LocaleClass.loc["morningstate_createm30_2"];
					}
					else
					{
						//message += "Your efforts to increase circulation are failing.\n\n";
						message += LocaleClass.loc["morningstate_createm31_1"] + goal.targetReaderCount + LocaleClass.loc["morningstate_createm31_2"] + goal.targetDayNumber + ".";
					}
				}
				
				message += "\n\n";
				message += getFamilyMessage(rs.curLoyalty);
			}
			else if (goal)
			{
				// working for rebels
				if (rs.getLoyaltyDelta() >= 0)
				{
					message += LocaleClass.loc["morningstate_createm32"];
				}
				if (rs.getLoyaltyDelta() < 0)
				{
					message += LocaleClass.loc["morningstate_createm33"];
				}
				message += getPerformanceMessage(rs.curLoyalty) + "\n" + getFamilyMessage(rs.curLoyalty);
			}
			else
			{
				// final
				FlxG.log("prev = " + prevGoal.toString());
				if (prevGoal.isMet())
				{
					// rebels succeeded
					message += LocaleClass.loc["morningstate_createm34"];
					message += LocaleClass.loc["morningstate_createm35"];
					message += LocaleClass.loc["morningstate_createm36"];
					message += LocaleClass.loc["morningstate_createm37"];
					message += LocaleClass.loc["morningstate_createm38"];
					message += LocaleClass.loc["morningstate_createm39"];
					gs.stateInControl = !gs.stateInControl;
					rebelsWon = true;
				}
				else
				{
					// rebels failed
					message += LocaleClass.loc["morningstate_createm40"];
					message += getPerformanceMessage(rs.curLoyalty) + "\n\n";
					message += LocaleClass.loc["morningstate_createm41"];
					message += LocaleClass.loc["morningstate_createm42"];
					message += killMessage;
				}
				gameOver = true;
			}
			
			message += "\n\n";		
			
			if (!gameOver)	
				message += getTutorialMessage(dayNumber);
				
			message = GameStatus.expandGovNames(message);
			
			backgroundSprite = new FlxSprite(0,0,Assets.morningImage);
			add(backgroundSprite);
			
			logoSprite = new FlxSprite(0,20,GameStatus.instance.stateInControl ? Assets.logo : Assets.logo2);
			logoSprite.x = FlxG.width/2-logoSprite.width/2;
			add(logoSprite);
			
			nextButton = new FlxButton(FlxG.width / 2 - Const.buttonW / 2, FlxG.height - 50, "", gameOver ? onClickGameOver : onClickNext);
			if (gameOver)
			{
				nextButton.loadGraphic(Assets.buttonTwoLines);
				nextButton.label.setFormat("DEFAULTF", 8, 0xff000000, "left", 0, 0, true);
			}
			else
			{
				nextButton.loadGraphic(Assets.button);
				nextButton.label.setFormat("DEFAULTF", 8, 0xff000000, "center", 0, 0, true);
			}
			
			nextButton.label.text = rebelsWon ? LocaleClass.loc["morningstate_createm43_1"] : (gameOver ? LocaleClass.loc["morningstate_createm43_2"] : LocaleClass.loc["morningstate_createm43_3"]);
			if (gameOver)
				nextButton.labelOffset = new FlxPoint((nextButton.width - nextButton.label.textWidth-4) / 2, (nextButton.height - nextButton.label.textHeight-4) / 2);
			add(nextButton);
			
			messageText = new FlxText(100, 90, FlxG.width-200);
			messageText.setFormat("DEFAULTF", 8, rebelsWon ? 0xffff0000 : 0xff000000, "left",0,0,true);
			messageText.text = message;
			messageText.y = 180 - messageText.height/2;
			add(messageText);
			
			dayText = new FlxText(int(FlxG.width / 2 - 25), 70, 50);
			dayText.setFormat("DEFAULTF", 8, 0xff000000, "center",0,0,true);
			dayText.text = LocaleClass.loc["morningstate_createm44"] + " " + dayNumber;
			add(dayText);

			creditsText = new FlxText(0, int(FlxG.height-35), int(FlxG.width));
			creditsText.setFormat("DEFAULTF", 8, 0xff000000, "left",0,0,true);
			creditsText.text = LocaleClass.loc["morningstate_createm45"];
			add(creditsText);
			
			if (dayNumber > 1)
			{
				statMeters = new StatMeters(FlxG.width-90, 120, true);
				statMeters.setValues(rs, false);
				add(statMeters);
			}
			
			add(Util.createMuteButton(Util.kCornerBR));
			Util.attachButtonSounds();
		}		
		
		private function getPerformanceMessage(loyalty:int):String
		{
			var str:String = "";
			str += LocaleClass.loc["morningstate_getperfmsg1"];
			if (loyalty >= Const.statMax) str += LocaleClass.loc["morningstate_getperfmsg2"];
			else if (loyalty > Const.statMax*2/3) str += LocaleClass.loc["morningstate_getperfmsg3"];
			else if (loyalty > Const.statMax*1/3) str += LocaleClass.loc["morningstate_getperfmsg4"];
			else if (loyalty >= -Const.statMax*1/3) str += LocaleClass.loc["morningstate_getperfmsg5"];
			else if (loyalty <= -Const.statMax) str += LocaleClass.loc["morningstate_getperfmsg6"];
			else if (loyalty < -Const.statMax*2/3) str += LocaleClass.loc["morningstate_getperfmsg7"];
			else if (loyalty < -Const.statMax*1/3) str += LocaleClass.loc["morningstate_getperfmsg8"];
			str += "-";
			return str;
		}
		
		private function getFamilyMessage(loyalty:int):String
		{
			var str:String = "";
			str += LocaleClass.loc["morningstate_getfamsg1"];
			if (loyalty >= Const.statMax) str += LocaleClass.loc["morningstate_getfamsg2"];
			else if (loyalty > Const.statMax*2/3) str += LocaleClass.loc["morningstate_getfamsg3"];
			else if (loyalty > Const.statMax*1/3) str += LocaleClass.loc["morningstate_getfamsg4"];
			else if (loyalty >= -Const.statMax*1/3) str += LocaleClass.loc["morningstate_getfamsg5"];
			else if (loyalty <= -Const.statMax) str += LocaleClass.loc["morningstate_getfamsg6"];
			else if (loyalty < -Const.statMax*2/3) str += LocaleClass.loc["morningstate_getfamsg7"];
			else if (loyalty < -Const.statMax*1/3) str += LocaleClass.loc["morningstate_getfamsg8"];
			return str;
		}
		
		private function getTutorialMessage(dayNumber:int):String
		{
			var str:String = "";
			
			if (dayNumber == 2)
			{
				// article size
				str += "__________________________________________\n";
				str += LocaleClass.loc["morningstate_getutmsg1"];
				str += LocaleClass.loc["morningstate_getutmsg2"];
				str += LocaleClass.loc["morningstate_getutmsg3"];
			}
			else if (dayNumber == 3)
			{
				// reader interest
				str += "__________________________________________\n";
				str += LocaleClass.loc["morningstate_getutmsg4"];
				str += LocaleClass.loc["morningstate_getutmsg5"];
				str += LocaleClass.loc["morningstate_getutmsg6"];
			}
			else if (dayNumber == 4)
			{
				// weather
				str += "__________________________________________\n";
				str += LocaleClass.loc["morningstate_getutmsg7"];
				str += LocaleClass.loc["morningstate_getutmsg8"];
				str += LocaleClass.loc["morningstate_getutmsg9"];
			}			
			else if (dayNumber == 5)
			{
				// weather
				str += "__________________________________________\n";
				str += LocaleClass.loc["morningstate_getutmsg10"];
				str += LocaleClass.loc["morningstate_getutmsg11"];
			}
			else if (dayNumber == 6)
			{
				// politics
				str += "__________________________________________\n";
				str += LocaleClass.loc["morningstate_getutmsg12"];
				str += LocaleClass.loc["morningstate_getutmsg13"];
			}
			else if (dayNumber == 7)
			{
				// politics
				str += "__________________________________________\n";
				str += LocaleClass.loc["morningstate_getutmsg14"];
				str += LocaleClass.loc["morningstate_getutmsg15"];
				str += LocaleClass.loc["morningstate_getutmsg16"];
			}
						
			return str;
		}
		
		override public function update():void
		{
			if (FlxG.debug)
			{
				if (FlxG.keys.pressed('K'))
				{
					GameStatus.instance.dayNumber++;
					FlxG.log(GameStatus.instance.readership.toString());
					FlxG.switchState(new MorningState());
				}
				if (FlxG.keys.pressed('O'))
				{
					GameStatus.instance.readership.curLoyalty -= 10;
					FlxG.log(GameStatus.instance.readership.toString());
					FlxG.switchState(new MorningState());
				}
				if (FlxG.keys.pressed('P'))
				{
					GameStatus.instance.readership.curLoyalty += 10;
					FlxG.log(GameStatus.instance.readership.toString());
					FlxG.switchState(new MorningState());
				}
				if (FlxG.keys.pressed('N'))
				{
					GameStatus.instance.readership.curReaderCount -= 100;
					FlxG.log(GameStatus.instance.readership.toString());
					FlxG.switchState(new MorningState());
				}
				if (FlxG.keys.pressed('M'))
				{
					GameStatus.instance.readership.curReaderCount += 100;
					FlxG.log(GameStatus.instance.readership.toString());
					FlxG.switchState(new MorningState());
				}
				//FlxG.log(GameStatus.instance.readership.toString());
			}
			
			var prevTime:Number = time;
			time += FlxG.elapsed;
			super.update();
		}
		
		protected function onClickNext():void
		{
			FlxG.switchState(new PlayState());
		}

		protected function onClickGameOver():void
		{
			GameStatus.instance.haveWonAtLeastOnce = true;
			GameStatus.instance.reset();
			FlxG.switchState(new MorningState());
		}			
	}
}
