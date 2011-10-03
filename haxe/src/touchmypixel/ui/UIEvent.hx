package touchmypixel.ui ;

import flash.events.MouseEvent;

class UIEvent extends MouseEvent
{
	public static var CLICK:String = "UIEvent.CLICK";
	public static var UPDATE:String = "UIEvent.UPDATE";
	public static var UPDATE_WHEEL:String = "UIEvent.UPDATE_WHEEL";
	
	public static var NEXT:String = "UIEvent.NEXT";
	public static var PREVIOUS:String = "UIEvent.PREVIOUS";
	public static var DRAG:String = "UIEvent.DRAG";
	
	static public var HIGHLIGHT:String = "UIEvent.HIGHLIGHT";
	static public var UNHIGHLIGHT:String = "UIEvent.UNHIGHLIGHT";
	static public var ON:String = "UIEvent.ON";
	static public var OFF:String = "UIEvent.OFF";
	
	public function new(type:String, ?bubbles:Bool=false, ?cancelable:Bool=false)
	{
		super(type, bubbles, cancelable);
	}
}