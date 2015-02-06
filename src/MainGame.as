package 
{
	import com.shortybmc.data.parser.CSV;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	[SWF(width = "1080", height = "640", backgroundColor = "#ffffff")] //Set the size and color of the Flash file
	
	public class MainGame extends MovieClip 
	{
		private var ldr:URLLoader;
		
		public function MainGame()
		{
			if(stage)
				startGame();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, startGame);
		}
		
		private function startGame(e:Event = null):void
		{
			LocaleClass.lang = stage.loaderInfo.parameters["lang"];
			LocaleClass.id = stage.loaderInfo.parameters["id"];
			/*LocaleClass.lang = "it";
			LocaleClass.id = "1";*/
			ldr = new URLLoader();
			ldr.addEventListener(Event.COMPLETE, onLangLoaded);
			ldr.load(new URLRequest("locale/"+LocaleClass.lang+"/"+LocaleClass.id+".csv"));
		}
		
		private function onLangLoaded(e:Event):void
		{
			var arr:Array = ldr.data.split(/\n/);
			trace(arr.length);
			for (var i:uint = 0; i < arr.length; i++)
			{
				var line:String = arr[i] as String;
				var l1:String = '';
				var l2:String = '';
				if (line != '')
				{
					if (line.indexOf('\t') > 1)
					{
						l1 = line.substring(0, line.indexOf('\t'));
						l2 = line.substring(line.lastIndexOf('\t') + 1, line.length-1);
						trace(l1+" = "+l2+".");
						LocaleClass.addLocValue(l1, l2);
					}
				}
			}
			addChild(new RepubliaTimes());
		}
	}	
}