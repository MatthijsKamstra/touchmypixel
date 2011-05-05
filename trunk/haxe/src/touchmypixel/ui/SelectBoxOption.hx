package touchmypixel.ui;

/**
 * ...
 * @author Tonypee
 */
import flash.display.Sprite;
import flash.text.TextField;
class SelectBoxOption extends Sprite
{
	public var gfxLabel:TextField;
	public var gfxHighlight:Sprite;
	public var value:Dynamic;
	
	public function new(label:String, value:Dynamic )
	{
		super();
		
		gfxHighlight.visible = false;
		
		mouseChildren = false;
		buttonMode = true;
		
		gfxLabel.text = label;
	
		this.value = value;
	}
	
}