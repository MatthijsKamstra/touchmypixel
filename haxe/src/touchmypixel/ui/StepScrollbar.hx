package touchmypixel.ui;

import caurina.transitions.Tweener;
import cc.av3d.creator.UpButton;
import com.touchmypixel.utils.GlobalTimer;
import touchmypixel.ui.SimpleButton;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

@:bind class StepScrollbar extends MovieClip
{	
	public var ui_bar:MovieClip;
	public var ui_track:MovieClip;
	public var ui_buttonUp:SimpleButton;
	public var ui_buttonDown:SimpleButton;
	public var ui_drag:SimpleButton;

	public var ui_barContent:MovieClip;
	public var ui_barMask:MovieClip;
	public var padding:Float;

	var _totalHeight:Float;
	var _steps:Int;
	var _currentStep:Int;
	var interv:Int;
	var disableButtons:Bool;
	
	var minDragHeight:Float;
	
	public function new()
	{
		super();
		
		padding = 2;
		currentStep = 1;
		_steps = 1;
		disableButtons = false;
		minDragHeight = 16;
		
		addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
	}
	
	public var currentStep(getCurrentStep, setCurrentStep):Int;
	public function getCurrentStep():Int { return _currentStep; }
	public function setCurrentStep(s):Int
	{
		_currentStep = s;
		//update();
		return _currentStep;
	}
	
	public var steps(getSteps, setSteps):Int;
	public function getSteps():Int { return _steps; }
	public function setSteps(s):Int
	{
		if (s < 1) s = 1;
		_steps = s;
		
		//trace("_steps: "+_steps);
		
		build();
		return _steps;
	}
	
	public var totalHeight(getTotalHeight, setTotalHeight):Float;
	public function getTotalHeight():Float { return _totalHeight; }
	public function setTotalHeight(h:Float)
	{
		_totalHeight = h;
		build();
		return _totalHeight;
	}
	
	public function init(e:Event)
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		//trace("STEP SCROLL INIT");
		
		if (ui_bar != null) {
			ui_bar.buttonMode = true;
			ui_bar.addEventListener(MouseEvent.MOUSE_DOWN, startBarDrag, false, 0, true);
			ui_bar.addEventListener(MouseEvent.MOUSE_UP, stopBarDrag, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopBarDrag, false, 0, true);
		}
		
		if (ui_barMask != null && ui_barContent != null) 
		{
			ui_bar.alpha = .1;
			ui_barContent.mask = ui_barMask;
			addEventListener(Event.ENTER_FRAME, enterFrame, false, 0, true);
		}
		
		if (ui_buttonUp != null && ui_buttonDown != null)
		{
			ui_buttonUp.addEventListener(UIEvent.CLICK, prev, false, 0, true);
			ui_buttonDown.addEventListener(UIEvent.CLICK, next, false, 0, true);
		}
		
		ui_track.addEventListener(MouseEvent.CLICK, clickTrack);
		
		update();
	}
	
	private function clickTrack(e:MouseEvent):Void 
	{
		onDrag(new Point(0, mouseY));
	}
	
	private function enterFrame(e:Event):Void 
	{
		ui_bar.alpha = .01;
		ui_barMask.y = Math.round(ui_bar.y);
		ui_barContent.y = ui_barMask.y;
		ui_barMask.height = ui_bar.height;
		
		
		ui_barMask.height = Math.round(ui_barMask.height / 2) * 2;
	}
	
	public function build()
	{
		if (ui_track != null && ui_bar != null) {
			ui_track.height = (totalHeight - ui_buttonUp.height - ui_buttonDown.height) - padding*2;
			ui_bar.oy = ui_bar.y = ui_track.y = ui_buttonUp.height + padding;
			ui_bar.height = (ui_track.height / _steps);
			if (ui_bar.height < minDragHeight) ui_bar.height = minDragHeight;
			ui_bar.y = ui_bar.oy + ui_bar.height * (currentStep - 1);
			ui_bar.alpha = (_steps == 1) ? 0 : 100;
			ui_buttonDown.y = ui_track.y + ui_track.height;
		} else {
			ui_buttonDown.y = totalHeight - ui_buttonDown.height;
		}
		
		if (_steps == 1) disable();
		
		updateButtons();
	}
	
	public function update()
	{
		if (ui_bar != null)
		{
			var ny = ui_bar.oy + ((ui_track.height - ui_bar.height + ui_track.height / _steps) / _steps) * (currentStep-1);
			if (!Math.isNaN(ny)) Tweener.addTween(ui_bar, { y:ny, time:1 } );
		}
		
		//if(!disableButtons){
			updateButtons();
		//}
		
		
		dispatchEvent(new UIEvent(UIEvent.UPDATE));
	}
	
	public function updateButtons()
	{
		ui_buttonUp.enable();
		ui_buttonDown.enable();
		if (!hasNext()) {
			ui_buttonDown.disable();
		}
		if (!hasPrev()) {
			ui_buttonUp.disable();
		}
	}

	private function startBarDrag(e:Event)
	{
		interv = GlobalTimer.setInterval(onDrag,30);
	}
	
	private function stopBarDrag(e:Event)
	{
		GlobalTimer.clearInterval(interv);
	}
	
	private function onDrag(?vMouse:Point = null)
	{	
		var mY = (vMouse == null) ? mouseY : vMouse.y;
		var newStep = Math.floor((mY - ui_bar.oy) / (ui_track.height / _steps)) + 1;
		if (newStep < 1) newStep = 1;
		if (newStep > _steps) newStep = _steps;
		if(currentStep != newStep){
			currentStep = newStep;
			update();
		}
	}
	
	public function next(?e:Event)
	{
		if (hasNext()) {
			currentStep++;
			update();
		}
		dispatchEvent(new UIEvent(UIEvent.NEXT));
	}
	
	public function prev(?e:Event)
	{
		if (hasPrev()) {
			currentStep--;
			update();
		}
		dispatchEvent(new UIEvent(UIEvent.PREVIOUS));
	}

	public function hasNext()
	{
		return (currentStep<(_steps));
	}
	
	public function hasPrev()
	{
		return (currentStep-1 != 0);
	}
	
	public function disable()
	{
		if (ui_bar != null) ui_bar.alpha = 0;

		if (ui_track != null) {
			ui_track.alpha = .1;
			ui_track.removeEventListener(MouseEvent.CLICK, clickTrack);
			ui_track.buttonMode = false;
		}

		if (ui_buttonUp != null) ui_buttonUp.alpha = .5;
		if (ui_buttonUp != null) ui_buttonUp.disable();

		if (ui_buttonDown != null) ui_buttonDown.alpha = .5;
		if (ui_buttonDown != null) ui_buttonDown.disable();

		if (ui_drag != null) ui_drag.alpha = 0;
		if (ui_drag != null) ui_drag.disable();

		if (ui_barContent != null) ui_barContent.alpha = 0;
		if (ui_barMask != null) ui_barMask.alpha = 0;
	}
	
	public function enable()
	{
		if (ui_bar != null) ui_bar.alpha = 1;
		
		if (ui_track != null) {
			ui_track.alpha = 1;
			ui_track.addEventListener(MouseEvent.CLICK, clickTrack);
			ui_track.buttonMode = true;
		}
		
		if (ui_buttonUp != null) ui_buttonUp.alpha = 1;
		if (ui_buttonUp != null) ui_buttonUp.enable();
		
		if (ui_buttonDown != null) ui_buttonDown.alpha = 1;
		if (ui_buttonDown != null) ui_buttonDown.enable();
		
		if (ui_drag != null) ui_drag.alpha = 1;
		if (ui_drag != null) ui_drag.enable();

		if (ui_barContent != null) ui_barContent.alpha = 1;
		if (ui_barMask != null) ui_barMask.alpha = 1;
	}
}