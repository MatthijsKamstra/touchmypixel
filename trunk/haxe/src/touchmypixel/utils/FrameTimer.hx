/*
 * FrameTimer.as
 * Copyright: 2008 Touch My Pixel - www.touchmypixel.com - contact@touchmypixel.com
 * Please see http://blog.touchmypixel.com/archives/14 for discussion
 */

package touchmypixel.utils;

import flash.display.Sprite;
import flash.display.Stage;
import flash.errors.Error;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.TypedDictionary;

class FrameTimer {
	
	private var frameRate:Int;
	public var scope:Stage;
	private var timeouts:TypedDictionary<Int, TimeoutItem>;
	private var intervals:TypedDictionary<Int, IntervalItem>;
	private var timoutsCounter:Int;
	private var intervalsCounter:Int;
	private var millisecondsPerFrame:Int;
	
	public static var instance:FrameTimer;
	
	public function new(stage:Stage = null, autoUpdate:Bool = true)
	{
		frameRate = 35;
		timoutsCounter = 1;
		intervalsCounter = 1;
		millisecondsPerFrame = 0;
		
		if (stage == null) {
			if (FrameTimer.instance != null) {
				stage = FrameTimer.instance.scope;
			}else {
				throw new Error("You must specify a scope (Stage) for the FrameTimer if it has not already been init'd.");
			}
		}
		
		frameRate = Math.round(stage.frameRate);
		scope = stage;
		
		timeouts = new TypedDictionary(true);
		intervals = new TypedDictionary(true);
		millisecondsPerFrame = Math.round(1000 / frameRate);
		
		if (autoUpdate)
		{
			stage.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
		}
	}
	
	public function update(e:Event = null):Void {
		var to:TimeoutItem;
		for (k in timeouts) {
			var to = timeouts.get(k);
			if (--to.framesLeft == 0) {
				to.cb();
				to.remove();
				timeouts.delete(k);
			}
		}
		
		var iv:IntervalItem;
		for (k in intervals) {
			var iv = intervals.get(k);
			if (--iv.framesLeft == 0) {
				iv.cb();
				iv.framesLeft = iv.frameInterval;
			}
		}
	}
	
	/*==================================================================================*/
	public function setFrameTimeout(cb:Void->Void, frames:Int):Int
	{
		if (scope != null) {
			timeouts.set(++timoutsCounter, new TimeoutItem(frames, cb));
			return(timoutsCounter);
		}else {
			trace("Please INIT with scope");
		}
		return(0);
	}
	
	public function setTimeout(cb:Void->Void, milliseconds:Int):Int
	{
		if (scope != null) {
			timeouts.set(++timoutsCounter, new TimeoutItem(Math.round(milliseconds/millisecondsPerFrame), cb));
			return(timoutsCounter);
		}else {
			trace("Please INIT with scope");
		}
		return(0);
	}
	
	public function clearTimeout(key:Int)
	{
		if(timeouts.exists(key)) timeouts.get(key).remove();
		timeouts.delete(key);
	}
	
	/*==================================================================================*/
	public function setFrameInterval(cb:Void->Void, frames:Int):Int
	{
		if (scope != null) {
			intervals.set(++intervalsCounter, new IntervalItem(frames, cb));
			return(intervalsCounter);
		}else {
			trace("Please INIT with scope");
		}
		return(0);
	}
	
	public function setInterval(cb:Void->Void, milliseconds:Int):Int
	{
		if (scope != null) {
			var time = Math.round(milliseconds / millisecondsPerFrame);
			if (time == 0) time = 1;
			intervals.set(++intervalsCounter, new IntervalItem(time, cb));
			return(intervalsCounter);
		}else {
			trace("Please INIT with scope");
		}
		return(0);
	}
	
	public function clearInterval(key:Int)
	{
		if(intervals.exists(key)) intervals.get(key).remove();
		intervals.delete(key);
	}
	
	/*==================================================================================*/
	public function clearAll()
	{
		clearAllTimeout();
		clearAllIntervals();
	}
	
	public function clearAllTimeout()
	{
		var to:TimeoutItem;
		for (k in timeouts) {
			to = timeouts.get(k);
			to.remove();
			timeouts.delete(k);
		}			
		timeouts = new TypedDictionary(true);			
	}
	
	public function clearAllIntervals()
	{
		var iv:IntervalItem;
		for (k in intervals) {
			iv = intervals.get(k);
			iv.remove();
			intervals.delete(k);
		}
		intervals = new TypedDictionary(true);
	}	
	
	/*============================================================================================================================================*/
	/* For static access! */
	/*============================================================================================================================================*/		
			
	public static function init(stage:Stage)
	{
		instance = new FrameTimer(stage, true);
	}
	
	/*static private function doTimer(e:Event):void {
		instance.doTimer(e);
	}*/
	
	/*==================================================================================*/
	public static function setFrameTimeoutS(cb:Void->Void, frames:Int):Int
	{
		return(instance.setFrameTimeout(cb, frames));
	}
	
	public static function setTimeoutS(cb:Void->Void, milliseconds:Int):Int
	{
		return(instance.setTimeout(cb, milliseconds));
	}
	
	public static function clearTimeoutS(key:Int)
	{
		instance.clearTimeout(key);
	}
	
	/*==================================================================================*/
	public static function setFrameIntervalS(cb:Void->Void, frames:Int):Int
	{
		return(instance.setFrameInterval(cb, frames));
	}
	
	public static function setIntervalS(cb:Void->Void, milliseconds:Int):Int
	{
		return(instance.setInterval(cb, milliseconds));
	}
	
	public static function clearIntervalS(key:Int)
	{
		instance.clearInterval(key);
	}
	
	/*==================================================================================*/
	public static function clearAllS()
	{
		instance.clearAll();
	}
	
	public static function clearAllTimeoutS()
	{
		instance.clearAllTimeout();
	}
	
	public static function clearAllIntervalS()
	{
		instance.clearAllIntervals();
	}
}

class TimeoutItem
{
	public var cb:Void->Void;
	public var framesLeft:Int;

	public function new(_framesLeft:Int, _cb:Void->Void)
	{
		cb = _cb;
		framesLeft = _framesLeft;
	}

	public function remove()
	{
		cb = null;
	}
}

class IntervalItem
{
	public var cb:Void->Void;
	public var framesLeft:Int;
	public var frameInterval:Int;

	public function new(_frameInterval:Int, _cb:Void->Void)
	{
		cb = _cb;
		frameInterval = _frameInterval;
		framesLeft = _frameInterval;
	}

	public function remove()
	{
		cb = null;
	}
}