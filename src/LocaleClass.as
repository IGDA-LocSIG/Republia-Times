package  
{
	public class LocaleClass 
	{
		private static var _loc:Object = new Object();
		public static var lang:String = "";
		public static var id:String = "";
		
		public static function addLocValue(key:String, value:String):void
		{
			var str:String = value;
			if (!_loc.hasOwnProperty(key))
			{
				_loc[key] = textMan(str);
			}
		}
		
		public static function get loc():Object
		{
			return _loc;
		}
		
		private static function textMan(str:String):String {
			var aux:String = str;
			aux = aux.split("\\n").join("\n");
			aux = aux.split('\\"').join('\"');
			
			// strip beginning and end quotes
			if (aux.charAt(0) == '"')
				aux = aux.substr(1, aux.length - 1);
			if (aux.charAt(aux.length-1) == '"')
				aux = aux.substr(0,aux.length-1);
			return aux;
		}
	}
}