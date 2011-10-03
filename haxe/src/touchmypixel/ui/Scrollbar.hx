
package com.touchmypixel.ui;

import caurina.transitions.Tweener;
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

class Scrollbar extends MovieClip
{	
	public var bar:MovieClip;
	public var track:MovieClip;
	
	public var percentage:Float;
	public var mouseWheelRect:Rectangle;
	
	public var _enabled:Bool;
	
	public function new()
	{
		super();
				
		addEventListener(Event.ADDED_TO_STAGE, added);
	}
	
	public function disable()
	{
		if(stage != null) stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheel);
		
		bar.removeEventListener(MouseEvent.MOUSE_DOWN, startBarDrag);
		bar.removeEventListener(MouseEvent.MOUSE_UP, stopBarDrag);
		track.removeEventListener(MouseEvent.MOUSE_UP, stopBarDrag);
		
		track.removeEventListener(MouseEvent.MOUSE_DOWN, clickTrack);
		
		_enabled = visible = false;
	}
	
	public function enable()
	{
		if (stage != null) stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheel, false, 1, true);
		
		bar.addEventListener(MouseEvent.MOUSE_DOWN, startBarDrag, false, 1, true);
		bar.addEventListener(MouseEvent.MOUSE_UP, stopBarDrag, false, 1, true);
		track.addEventListener(MouseEvent.MOUSE_UP, stopBarDrag, false, 1, true);
		
		track.addEventListener(MouseEvent.MOUSE_DOWN, clickTrack);
		
		_enabled = visible = true;
	}
	
	private function added(e:Event):Void 
	{
		bar.buttonMode = true;
		
		mouseWheelRect = track.getBounds(this);
		
		enabled = true;
		percentage = 0;		
		
		removeEventListener(Event.ADDED, added);
		
		if(_enabled) enable();
	}
	
	private function wheel(e:MouseEvent):Void 
	{
		if (mouseWheelRect.contains(mouseX, mouseY))
		{
			percentage += 0.03 * -e.delta;
			if (percentage > 1) percentage = 1;
			if (percentage < 0) percentage = 0;
			bar.x = (track.width - bar.width) * percentage;
			update(null);
		}
	}
	
	public function setWidth(value:Float)
	{
		mouseWheelRect.width = value;
		track.width = value;
		bar.x = (track.width - bar.width) * percentage;
		update(null);
	}
	
	private function startBarDrag(e:MouseEvent):Void 
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, stopBarDrag, false, 1, true);
		
		var bounds = track.getBounds(this);
		bounds.height = 0;
		bounds.width -= bar.width;
		bar.startDrag(false, bounds); 
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	private function stopBarDrag(e:MouseEvent):Void 
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, stopBarDrag);
		bar.stopDrag();
		
		removeEventListener(Event.ENTER_FRAME, update);
	}	
	
	public function moveTo(percentage:Float)
	{
		this.percentage = percentage;
		bar.x = (track.width - bar.width) * percentage;
		update(null);
	}
	
	private function clickTrack(e:MouseEvent):Void 
	{
		percentage = track.mouseX / (track.width - bar.width);
		dispatchEvent(new UIEvent(UIEvent.UPDATE));
	}	
	
	public function update(e:Event):Void 
	{
		percentage = bar.x / (track.width - bar.width);
		dispatchEvent(new UIEvent(UIEvent.UPDATE));
	}
	
}

