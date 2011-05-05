package touchmypixel.ui;
import flash.display.Sprite;
import hxs.Signal;

/**
 * ...
 * @author Tonypee
 */

class OptionGroup
{
	public var options:Array<OptionBox>;
	
	public var onChange:Signal;
	
	public var selected:OptionBox;
	
	public function new() 
	{
		options = [];
		
		onChange = new Signal(this);
	}	
	
	public function addOption(option:OptionBox)
	{
		options.push(option);
	}
	
	public function removeOption(option:OptionBox)
	{
		options.remove(option);
	}
	
	public function selectOption(option:OptionBox)
	{
		for (o in options)
			o.unhighlight();
		
		option.highlight();
		
		selected = option;
		
		onChange.dispatch();
	}
	
	public function getIndex(option:OptionBox)
	{
		return Lambda.indexOf(options, option);
	}
}