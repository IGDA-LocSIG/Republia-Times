package
{
	import org.flixel.*;
	
	public class Util
	{
		// http://flassari.is/2009/04/as3-array-shuffle/
		public static function shuffleArray(array_arr:Array):Array
		{
			for(var i:Number = 0; i < array_arr.length; i++)
			{
				var randomNum_num:Object = Math.floor(Math.random() * array_arr.length);
				var arrayIndex:Object = array_arr[i];
				array_arr[i] = array_arr[randomNum_num];
				array_arr[randomNum_num] = arrayIndex;
			}
			return array_arr;
		}
		
		public static function insertIntoArray(a1:Array,index:int,value:Object):void
		{
			a1.splice(index,0,value);
		}
		
		public static const kCornerTL:int = 0;
		public static const kCornerTR:int = 1;
		public static const kCornerBL:int = 2;
		public static const kCornerBR:int = 3;
		public static const kCornerCustom:int = 4;
		
		public static function createMuteButton(corner:int, customX:int=0, customY:int=0):FlxButton
		{
			var button:FlxButton = new FlxCheckButton(0,0,null,toggleMute);
			button.loadGraphic(Assets.mute, true, false, 12, 12);
			//button.onToggle = toggleMute;
			button.on = FlxG.mute;
			//button.frame = FlxG.mute ? 1 : 0;
			
			var margin:int = 10;
			if (corner == kCornerTL)
			{
				button.x = margin;
				button.y = margin;
			}
			else if (corner == kCornerTR)
			{
				button.x = FlxG.width - margin - button.width;
				button.y = margin;
			}
			else if (corner == kCornerBL)
			{
				button.x = margin;
				button.y = FlxG.height - margin - button.height;
			}
			else if (corner == kCornerBR)
			{
				button.x = FlxG.width - margin - button.width;
				button.y = FlxG.height - margin - button.height;
			}
			else if (corner == kCornerCustom)
			{
				button.x = customX;
				button.y = customY;
			}
			return button;
		}
		
		public static function toggleMute():void
		{
			FlxG.mute = !FlxG.mute;
			for each (var item:FlxBasic in FlxG.state.members)
			{
				var button:FlxButton = item as FlxButton;
				if (!button || button.onUp != toggleMute) continue;
				// this is the mute button
				button.on = FlxG.mute;
			}
		}
		
		private static function attachButtonSoundsRecursive(item:FlxBasic):void
		{
			if (item is FlxButton)
			{
				var button:FlxButton = item as FlxButton;
				button.setSounds(null, 1.0, null, 1.0, Assets.buttonDownSound, 1.0, Assets.buttonUpSound, 1.0);
				//button.soundUp.survive = true;
			}
			else if (item is FlxGroup)
			{
				var group:FlxGroup = item as FlxGroup;
				for each (var subItem:FlxBasic in group.members)
				{
					attachButtonSoundsRecursive(subItem);
				}
			}
		}
		
		public static function attachButtonSounds():void
		{
			attachButtonSoundsRecursive(FlxG.state);
		}
		
		// http://www.kensodev.com/2010/06/22/copy-object-properties-to-another-object-flex/
		/**
		 * copies a source object to a destination object
		 * @param sourceObject the source object
		 * @param destinationObject the destination object
		 *
		 */
		/*
		public static function copyObject(sourceObject:Object, destinationObject:Object):void
		{
		    // check if the objects are not null
		    if((sourceObject) && (destinationObject)) {
		        try
		        {
		            //retrive information about the source object via XML
		            var sourceInfo:XML = describeType(sourceObject);
		            var objectProperty:XML;
		            var propertyName:String;

		            // loop through the properties
		            for each(objectProperty in sourceInfo.variable)
		            {
		                propertyName = objectProperty.@name;
		                if(sourceObject[objectProperty.@name] != null)
		                {
		                    if(destinationObject.hasOwnProperty(objectProperty.@name)) {
		                        destinationObject[objectProperty.@name] = sourceObject[objectProperty.@name];
		                    }
		                }
		            }
		            //loop through the accessors
		            for each(objectProperty in sourceInfo.accessor) {
		                if(objectProperty.@access == "readwrite") {
		                    propertyName = objectProperty.@name;
		                    if(sourceObject[objectProperty.@name] != null)
		                    {
		                        if(destinationObject.hasOwnProperty(objectProperty.@name)) {
		                            destinationObject[objectProperty.@name] = sourceObject[objectProperty.@name];
		                        }
		                    }
		                }
		            }
		        }
		        catch (err:*) {
		            ;
		        }
		    }
		}
		*/
	}
}

import org.flixel.*;

class FlxCheckButton extends FlxButton
{
	public function FlxCheckButton(x:int, y:int, str:String, onUp_:Function)
	{
		super(x, y, str, onUp_);
	}
	
	override public function postUpdate():void
	{
		super.postUpdate();
		frame = this.on ? 1 : 0;
	}
}