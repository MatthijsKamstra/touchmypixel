package touchmypixel.ui;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import hxs.Signal;

/**
 * ...
 * @author Tonypee
 */

class SelectBox extends Sprite
{
	public var label(_getLabel, _setLabel):String;
	public var value:Dynamic;
	
	public var gfxLabel:TextField;
	public var gfxBg:Sprite;
	public var gfxDropdownBg:Sprite;
	public var gfxButton:Sprite;
	
	public var maskClip:Sprite;
	public var contentClip:Sprite;
	
	var options:Array<SelectBoxOption>;
	
	var h:Float;
	private var open:Bool;
	
	public var customOptionClass:Class<Dynamic>;
	
	public var onChange:Signal;
	
	public function new(?label:String, ?value:Dynamic)
	{
		super();	
		
		h = 0;
		options = [];
		open = false;
		
		onChange = new Signal(this);
		
		//unhighlight();
		
		init(label, value);
		
		//mouseChildren = false;
		//buttonMode = true;
		
		gfxLabel.mouseEnabled = false;
		
		maskClip = new Sprite();
		maskClip.graphics.beginFill(0, .3);
		maskClip.graphics.drawRect(0, 0, gfxDropdownBg.width, 10);
		maskClip.height = 0;
		addChild(maskClip);
		
		contentClip = new Sprite();
		addChild(contentClip);
		
		maskClip.y = contentClip.y = gfxBg.height;
		
		//contentClip.addChild(gfxDropdownBg);
		contentClip.mask = maskClip;
		
		gfxDropdownBg.x = gfxDropdownBg.y = 0;
		
		gfxBg.addEventListener(MouseEvent.CLICK, click);
		gfxButton.addEventListener(MouseEvent.CLICK, click);
	}
	
	private function click(e:MouseEvent):Void 
	{
		parent.setChildIndex(this, parent.numChildren-1);
		
		if (!open)
			showOptions(e);
		else
			hideOptions();
			
		
	}
	
	public function showOptions(e:MouseEvent):Void
	{	
		open = true;
		maskClip.height = h+6;
		
		e.stopImmediatePropagation();
		
		stage.addEventListener(MouseEvent.CLICK, blur);
	}
	
	public function hideOptions():Void
	{
		open = false;
		maskClip.height = 0;
		
		stage.removeEventListener(MouseEvent.CLICK, blur);
	}
	
	private function blur(e:MouseEvent):Void 
	{
		hideOptions();
	}
	
	public function init(label:String, value:Dynamic)
	{
		this.label = label;
		this.value = value;	
	}
	
	public function addOption(label:String, value:Dynamic)
	{
		
		var option:SelectBoxOption;
		
		if (customOptionClass != null)
			option = Type.createInstance(customOptionClass, [label, value]);
		else 
			option = new SelectBoxOption(label, value);
		
		contentClip.addChild(option);
		
		option.addEventListener(MouseEvent.CLICK, onClickItem);
		
		options.push(option);
		
		arrangeOptions();
	}
	
	private function onClickItem(e:MouseEvent):Void 
	{
		var option:burnlab.ui.SelectBoxOption = cast e.target;
		
		value = option.value;
		label = option.gfxLabel.text;
		
		onChange.dispatch();
	}
	
	private function arrangeOptions():Void
	{
		var c = 0;
		for (i in options)
		{
			i.y = 30 * c;
			
			c++;
		}
		
		if (contentClip.contains(gfxDropdownBg))
			contentClip.removeChild(gfxDropdownBg);
			
		gfxDropdownBg.visible = false;
		
		h = contentClip.height;
		
		//gfxDropdownBg.y = -gfxDropdownBg.height + h;
		gfxDropdownBg.height = h+5;
		
		gfxDropdownBg.visible = true;
		
		contentClip.addChildAt(gfxDropdownBg,0);
	}
	
	public function selectOption(value:Dynamic)
	{
		for (i in options)
		{
			if (i.value == value)
			{
				this.value = value;
				label = i.gfxLabel.text;
				onChange.dispatch();
			}
		}
	}
	
	public function _getLabel():String
	{
		return gfxLabel.text;
	}
	public function _setLabel(value:String):String
	{
		gfxLabel.text = value;
		
		//gfxLabel.width = gfxLabel.textWidth + 5;
		
		return value;
	}
	
}

