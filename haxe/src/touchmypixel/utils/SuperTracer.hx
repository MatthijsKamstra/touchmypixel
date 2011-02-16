/**
 * ...
 * @author Tarwin Stroh-Spijer
 */

package touchmypixel.utils;
import flash.Lib;
import haxe.PosInfos;

class SuperTracer 
{
	public static var lastTraceTime:Int = -1;
	
	public static function init()
	{
		lastTraceTime = Lib.getTimer();
	}
	public static function trace(?pos:PosInfos, ?extra:Dynamic)
	{
		if (lastTraceTime == -1) lastTraceTime = Lib.getTimer();
		var o = "";
		if (pos != null) o += " - " + pos.fileName + "::" + pos.methodName + ":" + pos.lineNumber;
		o += " (" + (Lib.getTimer() - lastTraceTime) / 1000 + " seconds)";
		if (extra != null) o += " :: " + Std.string(extra);
		trace(o);
		lastTraceTime = Lib.getTimer();
	}
}