/**
* ...
* @author Default
* @version 0.1
*/

package touchmypixel.ui;

import caurina.transitions.properties.DisplayShortcuts;
import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.media.Sound;

@:bind class SimpleButton_2 extends SimpleButton {}
@:bind class SimpleButton_3 extends SimpleButton {}
@:bind class SimpleButton_4 extends SimpleButton {}
@:bind class SimpleButton_5 extends SimpleButton {}
@:bind class SimpleButton_6 extends SimpleButton {}
@:bind class SimpleButton_7 extends SimpleButton {}
@:bind class SimpleButton_8 extends SimpleButton {}
@:bind class SimpleButton_9 extends SimpleButton {}
@:bind class SimpleButton_10 extends SimpleButton {}

@:bind class SimpleButton extends MovieClip
{
	public static inline var HIGHLIGHT:String = "hightlight";
	public static inline var UNHIGHLIGHT:String = "hightlight";
	public static inline var ON:String = "on";
	public static inline var OFF:String = "off";
	
	public var id:Int;	
	public var group:String;
	
	public var e_animation:MovieClip;
	public var selected:Bool;
	public var useFrameRollovers:Bool;
	public var animationClip:MovieClip;
	public var animationDuration:Float;
	public var animationTransition:String;
	public var isHighlighted:Bool;
	public var isEnabled:Bool;
	
	public var autoUnhighlightAll:Bool;
	public var autoHighlight:Bool;
	
	public var mouseOverSound:Sound;
	public var mouseOutSound:Sound;
	public var mouseDownSound:Sound;
	public var mouseUpSound:Sound;
	
	public function new() 
	{
		super();
		
		animationDuration = 1;
		animationTransition = "easeOutSine";
		isHighlighted = false;
		isEnabled = true;
		
		autoUnhighlightAll = true;
		autoHighlight = true;
		
		mouseChildren = false;
		
		if (e_animation != null) {
			animationClip = e_animation;
			animationClip.stop();
		} else {
			animationClip = this;
		}
		
		stop();
		useFrameRollovers = false;
		addEventListener(MouseEvent.MOUSE_OVER, MOUSE_OVER);
		addEventListener(MouseEvent.MOUSE_OUT, MOUSE_OUT);
		addEventListener(MouseEvent.MOUSE_UP, MOUSE_UP);
		addEventListener(MouseEvent.MOUSE_DOWN, MOUSE_DOWN);
		enable(true);
		
		DisplayShortcuts.init();
	}
	
	public function enable(?firstTime:Bool = false):Void
	{
		if (!firstTime) alpha = 1;
		buttonMode = true;
		isEnabled = true;
		addEventListener(MouseEvent.CLICK, click);
	}
	
	public function disable():Void
	{
		alpha = .5;
		buttonMode = false;
		MOUSE_OUT();
		isEnabled = false;
		removeEventListener(MouseEvent.CLICK, click);
	}
	
	public function click(e:MouseEvent):Void 
	{
		dispatchEvent(new UIEvent(UIEvent.CLICK));
	}
	
	public function highlight(autoUnhighlightAll:Bool = false)
	{
		if (this.autoUnhighlightAll || (autoUnhighlightAll != false)) unHighlightAll();
		
		isHighlighted = selected = true;
		dispatchEvent(new Event(SimpleButton.HIGHLIGHT));
		MOUSE_OVER();
		dispatchEvent(new Event(SimpleButton.ON));

		if(useFrameRollovers) Tweener.addTween(animationClip, {_frame:animationClip.totalFrames, time:animationDuration, transition:animationTransition});
	}
	
	public function unHighlight()
	{
		isHighlighted = selected = false;
		dispatchEvent(new Event(SimpleButton.UNHIGHLIGHT));
		MOUSE_OUT();
		dispatchEvent(new Event(SimpleButton.OFF));
		
		if(useFrameRollovers) Tweener.addTween(animationClip, {_frame:0, time:animationDuration, transition:animationTransition});
	}
	
	public function unHighlightAll()
	{
		for(item in getGroup(group, cast(parent, Sprite))) {
			item.unHighlight();
		}
	}
	
	public function highlightAll()
	{
		for(item in getGroup(group, cast(parent, Sprite))) {
			item.highlight();
		}
	}
	
	public function MOUSE_UP(?e:Event)
	{
		if (isEnabled) {
			if (mouseUpSound != null) mouseUpSound.play();
			if (autoHighlight) highlight();
		}
	}
	
	public function MOUSE_DOWN(?e:Event)
	{
		if (isEnabled) {
			if (mouseDownSound != null) mouseDownSound.play();
		}
	}
	
	public function MOUSE_OVER(?e:Event)
	{
		if (isEnabled) {
			dispatchEvent(new Event(SimpleButton.ON));
			if (mouseOverSound != null) mouseOverSound.play();
			if(useFrameRollovers)Tweener.addTween(animationClip, { _frame:animationClip.totalFrames, time:animationDuration, transition:animationTransition } );
		}
	}
	
	public function MOUSE_OUT(?e:Event)
	{
		if (isEnabled && !isHighlighted) {
			dispatchEvent(new Event(SimpleButton.OFF));
			if (mouseOutSound != null) mouseOutSound.play();
			if(useFrameRollovers) Tweener.addTween(animationClip, { _frame:0, time:animationDuration, transition:animationTransition } );
		}
	}
	
	public static function getGroup(group:String, scope:Sprite):Array<SimpleButton>
	{
		var items:Array<SimpleButton> = new Array();
		var i = 0;
		while (i < scope.numChildren)
		{
			if (Std.is(scope.getChildAt(i), SimpleButton))
			{
				var clip:SimpleButton = cast(scope.getChildAt(i), SimpleButton);
				if (clip != null)
				{
					if (clip.group == group) items.push(clip);
				}
			}
			i++;
		}
		return items;
	}
	
	public static function getAll(scope:Sprite)
	{
		var items:Array<SimpleButton> = new Array();
		var i = 0;
		while (i < scope.numChildren)
		{
			if (Std.is(scope.getChildAt(i), SimpleButton))
			{
				var clip:SimpleButton = cast(scope.getChildAt(i), SimpleButton);
				if (clip != null)
				{
					items.push(clip);
				}
			}
			i++;
		}
		return items;
	}
}