package touchmypixel.ui;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import hxs.Signal;

/**
 * ...
 * @author Tonypee
 */

class Input extends Sprite
{
	public var gfxText:TextField;
	public var gfxBg:Sprite;
	public var gfxHighlight:Sprite;
	
	public var value(_getValue, _setValue):String;
	
	public var onFocus:Signal;
	
	public function new(?value:String) 
	{
		super();
		
		if (value != null)
			this.value = value;
		
		gfxHighlight.visible = false;
		
		onFocus = new Signal(this);
		
		addEventListener(MouseEvent.CLICK, click);
	}
	private function click(e:MouseEvent):Void 
	{
		focus();
	}
	public function focus()
	{
		gfxHighlight.visible = true;
		
		onFocus.dispatch();
	}
	
	public function defocus()
	{
		gfxHighlight.visible = false;
	}
	
	public function _getValue():String
	{
		return gfxText.text;
	}
	public function _setValue(value:String):String
	{
		gfxText.text = value;
		
		return value;
	}
	
}