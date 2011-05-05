package touchmypixel.ui;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.events.MouseEvent;
import flash.text.TextField;

/**
 * ...
 * @author Tonypee
 */

class OptionBox extends MovieClip
{
	public var group:OptionGroup;
	public var label(_getLabel, _setLabel):String;
	public var value:Dynamic;
	
	public var gfxLabel:TextField;
	public var gfxHighlight:DisplayObject;
	
	private var hit:Shape;
	
	public function new(?group:OptionGroup, ?label:String, ?value:Dynamic)
	{
		super();	
		
		unhighlight();
		
		if(group != null && label != null && value != null)
			init(group, label, value);
		
		mouseChildren = false;
		buttonMode = true;
	}
	
	public function init(group:OptionGroup, label:String, value:Dynamic)
	{
		this.group = group;
		this.label = label;
		this.value = value;
		
		group.addOption(this);
		
		addEventListener(MouseEvent.CLICK, onClick);
		
		var r = getRect(this);
		hit = new Shape();
		hit.graphics.beginFill(0x000000, 0);
		hit.graphics.drawRect(r.x, r.y, r.width, r.height);
		addChild(hit);
		
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		select();
	}
	
	public function _getLabel():String
	{
		return gfxLabel.text;
	}
	public function _setLabel(value:String):String
	{
		gfxLabel.text = value;
		
		gfxLabel.width = gfxLabel.textWidth + 5;
		
		return value;
	}
	
	public function select():Void
	{
		group.selectOption(this);
	}
	
	public function highlight():Void
	{
		gfxHighlight.visible = true;
	}
	
	public function unhighlight():Void
	{
		gfxHighlight.visible = false;
	}
	
}