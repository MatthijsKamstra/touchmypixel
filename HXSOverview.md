# HXS - Signals Library #


## Overview ##

HXS is based on AS3Signals and aims to provide a lightweight signals & slots library for crossplatform haxe development. The syntax aims to be concise and familiar to flash & web (ecma) programmers.



## Examples ##
Examples can be found in the Main.hx file in the 'src' of the HXS project. Or read below.

## A simple example ##

Like AS3Signals HXS is setup to directly call listener functions. You have the option of calling listeners with a number of arguments: 1,2,3,4 or 5 (currently). There are different SignalX classes for each number of arguments.

## No Arguemnts ##

The Simplest setup simply allows a number of listeners to be added to a signal, without passing any information to the listener.

```
var s = new Signal();
s.add(function() {
	trace("a simple listener");
});
s.add(function() {
	trace("another simple listener on the same signal");
});
s.dispatch();
```


## With Arguments ##

SignalX classes allow you to pass data to the listeners. HXS is fully typed, but you can use type inference for cleaner, faster coding.

### Fully Typed ###
```
var signal2:Signal2<String, Float> = new Signal2();
signal2.add(function(a:String, b:Float){
	trace("String" + a);
	trace("float" + (b*2));
});
signal2.dispatch("hello", 22.3);
```

### Type Inference ###
```
var signal2 = new Signal2();
signal2.add(function(a:String, b:Float){
	trace("String" + a);
	trace("float" + (b*2));
});
signal2.dispatch("hello", 22.3);
```



## Event Information ##
So far we have been adding listeners to our signal via the 'add' method. If you want to get information about he signal/slot that is currently dispatching then you can use the 'addAdvanced' method. This sends an 'info' object with the dispatch.

This can be useful to:
  * access the caller object (object holding the signal - eg. a movieclip)
This requires that you have passed it to the Signal on instantiation (eg new Signal(this))
  * mute/unmute the signal
  * mute/unmute slots

```
var s = new Signal();
s.addAdvanced(function(info:Info) {
	trace("a simple listener with info");
	info.signal.mute();
});
s.dispatch();
s.dispatch();
s.dispatch();
```

This example would only call the listener once, as in the first call it mutes the signal.


## Integration with Native Flash events ##
It is very simple to integrate with flash AVM2 native events.

```
var onClick = new AS3Signal(this, MouseEvent.CLICK);
onClick.add(function(e:MouseEvent){
	
	trace("clicked");
});	
```

This example adds a listener to 'this' for the MouseEvent.CLICK. An AS3Signal allows for the same features (muting, info etc, as the normal signals)

## Shortcuts ##

Shortcuts use the haxe 'using' functionality to inject signals onto certain classes. For example, onEnterFrame can be added to all MovieClips - this allows us to use events similar to ActionScript1, but with the benefits of signals:

```
using hxs.shortcuts.as3.Common;

var box = new Sprite();
	
box.onClick().add(function(e) {
	trace("onClick");
});
		
box.onRollOver().add(function(e) {
	trace("onRollOver");
});

// it allows for onReleaseOutside to be implemented too!
box.onReleaseOutside().add(function(e) {
	trace("** onReleaseOutside ** (HELL YEAH!)");
});
```

Currently there a few shortcuts for commonly used AS3 events, such as onEnterFrame, click, etc.