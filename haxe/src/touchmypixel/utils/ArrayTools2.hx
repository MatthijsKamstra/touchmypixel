package touchmypixel.utils;

/**
* ...
* @author Default
*/
class ArrayTools2 {
	
	public static function each<T, U>(a:Array<T>, f:T->U):Array<U>
	{
		var b:Array<U> = [];
		for (i in 0...a.length) {
			b[i] = f(a[i]);
		}
		return b;
	}
	
	public static function randomize<T>(array:Array<T>):Array<T>
	{
		var l = array.length-1;
		for (it in 0...l) {
			var r = Math.round(Math.random() * l);
			var tmp = array[it];
			array[it] = array[r];
			array[r] = tmp;
		}
		return array;
	}
	
	public static function findFirst(array:Array<Dynamic>, parameter:String, value:Dynamic):Dynamic
	{
		for (i in array) {
			var v = Reflect.field(i, parameter);
			if (v == value)
			return i;
		}
		return null;
	}
	
	public static function indexOf(a:Array<Dynamic>, value:Dynamic):Dynamic
    {
		for (i in 0...a.length)
		{
			if (a[i] == value) return a[i];
		}
		return -1;
	}
	
	/*public static function findFirstPosition<T>(array:Array<T>, parameter:String, value:*):Int
	{
		for (var i = 0; i < array.length; i++) {
			if (array[i][parameter] == value) return(i);
		}
		return(-1);
	}		
	
	public static function find(array:Array, parameter:String, value:*):Array
	{
		return(array.filter(function(element, index:int, arr:Array) {
			return (element[parameter] == value);
		} ));
	}*/	
	
	/*private function xmlToArray(xml:XMLList):Array
	{
		var a:Array = [];
		for each(var row:XML in xml)
		{
			var item = {};
			var atts = row.attributes();
			for each(var att:XML in atts)
			{
				item[att.name().toString()] = att.toXMLString();
			}
			a.push(item);
		}
		return a;
	}*/		
}