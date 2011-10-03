package touchmypixel.ui;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

//import com.pixelbreaker.ui.osx.MacMouseWheel;

class ScrollPane extends MovieClip
{
	public var stepSize:Float;
	
	private var _currentStep:Int;
	public var currentStep(getCurrentStep, setCurrentStep):Int;
	
	private var _content:MovieClip;
	private var _mask:MovieClip;
	
	public var transitionTime:Float;
	public var transitionDelay:Float;
	public var transitionType:String;
	
	public var ui_content(getUi_content, setUi_content):MovieClip;
	public var ui_mask(getUi_mask, setUi_mask):MovieClip;
	
	public function new()
	{
		super();
		
		stepSize = 50;
		currentStep = 1;
		transitionTime = 1;
		transitionDelay = 0;
		transitionType = "easeOutExpo"; //easeInOutSine
		
		if (_content == null) ui_content = new MovieClip(); 
		if (_mask == null)	setMask(0, 0, 100, 100);
		
		addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
	}
	
	private function onWheel(e:MouseEvent):Void 
	{
		var r:Rectangle = getBounds(this);
		if (e.localX > r.left && e.localX < r.right && e.localY > r.top && e.localY < r.bottom) {
			if (e.delta > 0) {
				// go up
				dispatchEvent(new UIEvent(UIEvent.PREVIOUS));
			}else {
				// go down
				dispatchEvent(new UIEvent(UIEvent.NEXT));
			}
		}
	}
	
	private function setCurrentStep(s:Int)
	{
		_currentStep = s;
		if (_content != null) _content.y = -(_currentStep - 1) * stepSize;
		return _currentStep;
	}
	private function getCurrentStep()
	{
		return _currentStep;
	}
	
	public function setUi_content(mc:MovieClip)
	{
		if(_content != null) removeChild(_content);
		_content = mc;
		_content.x = 0;
		_content.y = 0;
		_content.mask = ui_mask;
		_content.y = -(_currentStep - 1) * stepSize;
		addChild(_content);
		
		return _content;
	}
	public function getUi_content():MovieClip
	{
		return _content;
	}
	
	public function setUi_mask(mc:MovieClip)
	{	
		if(_mask != null) removeChild(_mask);
		_mask = mc;
		addChild(_mask);
		
		return _mask;
	}
	public function getUi_mask():MovieClip
	{
		return _mask;
	}
	
	public function setMask(x:Float, y:Float, width:Float, height:Float)
	{
		if(_mask != null) removeChild(_mask);
		_mask = new MovieClip(); 
		_mask.graphics.clear();
		_mask.graphics.beginFill(0x000000, 1);
		_mask.graphics.drawRect(x, y, width, height);
		addChild(_mask);
		_content.mask = _mask;
	}
	
	public function next(steps:Float = 1)
	{
		if (hasNext()) moveToStep(++_currentStep);
	}

	public function prev(steps:Float = 1)
	{
		if (hasPrev()) moveToStep(--_currentStep);
	}
	
	public function hasNext()
	{
		var r:Rectangle = getBounds(this);
		return (currentStep < (r.height / stepSize) - 1);
	}
	
	public function hasPrev()
	{
		return (currentStep - 1 != 0);
	}
	
	public function moveToStep(step:Float):Void
	{
		Tweener.removeTweens(_content);
		Tweener.addTween(_content, { time:transitionTime, delay:transitionDelay, y:-(step-1)*stepSize, transition:transitionType } );
	}
	
	//TODO : Set scroll By percentage
	public function moveTo(percentage:Float)
	{
		
	}
}