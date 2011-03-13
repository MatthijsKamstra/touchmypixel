package touchmypixel.io;

import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.Lib;

class Keys
{
	public static var inited:Bool = false;
	public static var keycodes: IntHash<Bool> = new IntHash();
	private static var keyDownUsed: IntHash<Hash<Bool>> = new IntHash();
	
	static public function init():Void
	{
		if (!inited)
		{
			Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		inited = true;
	}
	
	static public function isDown( key:Int):Bool
	{
		return keycodes.get(key) == true;
	}
	
	static public function isDownOnce(key:Int, id:String):Bool
	{
		if(keycodes.get(key) && keyDownUsed.exists(key)){
			if(!keyDownUsed.get(key).get(id)){
				keyDownUsed.get(key).set(id, true);
				return(true);
			}
		}
		return(false);
	}
	
	private static function onKeyDown( event: KeyboardEvent ):Void
	{
		//trace(event.keyCode);
		keycodes.set(event.keyCode, true);
		if(!keyDownUsed.exists(event.keyCode)) keyDownUsed.set(event.keyCode, new Hash());
	}
	
	private static function onKeyUp( event: KeyboardEvent ):Void
	{
		keycodes.set(event.keyCode, false);
		keyDownUsed.remove(event.keyCode);
	}
	
	public static function forceKeyDown( key:Int )
	{
		 keycodes.set(key, true);
	}
	
	public static function forceKeyUp( key:Int )
	{
		keycodes.set(key, false);
		keyDownUsed.remove(key);
	}
	
	/* ------------------------------------------------------------------------------- */
	// KEY VALUES
	public static inline var A:UInt = 65;
	public static inline var ALTERNATE:UInt = 18;
	public static inline var B:UInt = 66;
	public static inline var BACKQUOTE:UInt = 192;
	public static inline var BACKSLASH:UInt = 220;
	public static inline var BACKSPACE:UInt = 8;
	public static inline var C:UInt = 67;
	public static inline var CAPS_LOCK:UInt = 20;
	public static inline var COMMA:UInt = 188;
	public static inline var COMMAND:UInt = 15;
	public static inline var CONTROL:UInt = 17;
	public static inline var D:UInt = 68;
	public static inline var DELETE:UInt = 46;
	public static inline var DOWN:UInt = 40;
	public static inline var E:UInt = 69;
	public static inline var END:UInt = 35;
	public static inline var ENTER:UInt = 13;
	public static inline var EQUAL:UInt = 187;
	public static inline var ESCAPE:UInt = 27;
	public static inline var F:UInt = 70;
	public static inline var F1:UInt = 112;
	public static inline var F10:UInt = 121;
	public static inline var F11:UInt = 122;
	public static inline var F12:UInt = 123;
	public static inline var F13:UInt = 124;
	public static inline var F14:UInt = 125;
	public static inline var F15:UInt = 126;
	public static inline var F2:UInt = 113;
	public static inline var F3:UInt = 114;
	public static inline var F4:UInt = 115;
	public static inline var F5:UInt = 116;
	public static inline var F6:UInt = 117;
	public static inline var F7:UInt = 118;
	public static inline var F8:UInt = 119;
	public static inline var F9:UInt = 120;
	public static inline var G:UInt = 71;
	public static inline var H:UInt = 72;
	public static inline var HOME:UInt = 36;
	public static inline var I:UInt = 73;
	public static inline var INSERT:UInt = 45;
	public static inline var J:UInt = 74;
	public static inline var K:UInt = 75;
	public static inline var L:UInt = 76;
	public static inline var LEFT:UInt = 37;
	public static inline var LEFTBRACKET:UInt = 219;
	public static inline var M:UInt = 77;
	public static inline var MINUS:UInt = 189;
	public static inline var N:UInt = 78;
	public static inline var NUMBER_0:UInt = 48;
	public static inline var NUMBER_1:UInt = 49;
	public static inline var NUMBER_2:UInt = 50;
	public static inline var NUMBER_3:UInt = 51;
	public static inline var NUMBER_4:UInt = 52;
	public static inline var NUMBER_5:UInt = 53;
	public static inline var NUMBER_6:UInt = 54;
	public static inline var NUMBER_7:UInt = 55;
	public static inline var NUMBER_8:UInt = 56;
	public static inline var NUMBER_9:UInt = 57;
	public static inline var NUMPAD:UInt = 21;
	public static inline var NUMPAD_0:UInt = 96;
	public static inline var NUMPAD_1:UInt = 97;
	public static inline var NUMPAD_2:UInt = 98;
	public static inline var NUMPAD_3:UInt = 99;
	public static inline var NUMPAD_4:UInt = 100;
	public static inline var NUMPAD_5:UInt = 101;
	public static inline var NUMPAD_6:UInt = 102;
	public static inline var NUMPAD_7:UInt = 103;
	public static inline var NUMPAD_8:UInt = 104;
	public static inline var NUMPAD_9:UInt = 105;
	public static inline var NUMPAD_ADD:UInt = 107;
	public static inline var NUMPAD_DECIMAL:UInt = 110;
	public static inline var NUMPAD_DIVIDE:UInt = 111;
	public static inline var NUMPAD_ENTER:UInt = 108;
	public static inline var NUMPAD_MULTIPLY:UInt = 106;
	public static inline var NUMPAD_SUBTRACT:UInt = 109;
	public static inline var O:UInt = 79;
	public static inline var P:UInt = 80;
	public static inline var PAGE_DOWN:UInt = 34;
	public static inline var PAGE_UP:UInt = 33;
	public static inline var PERIOD:UInt = 190;
	public static inline var Q:UInt = 81;
	public static inline var QUOTE:UInt = 222;
	public static inline var R:UInt = 82;
	public static inline var RIGHT:UInt = 39;
	public static inline var RIGHTBRACKET:UInt = 221;
	public static inline var S:UInt = 83;
	public static inline var SEMICOLON:UInt = 186;
	public static inline var SHIFT:UInt = 16;
	public static inline var SLASH:UInt = 191;
	public static inline var SPACE:UInt = 32;
	public static inline var T:UInt = 84;
	public static inline var TAB:UInt = 9;
	public static inline var U:UInt = 85;
	public static inline var UP:UInt = 38;
	public static inline var V:UInt = 86;
	public static inline var W:UInt = 87;
	public static inline var X:UInt = 88;
	public static inline var Y:UInt = 89;
	public static inline var Z:UInt = 90;
	/* experimental
	 */
	public static inline var WINDOWS_KEY_LEFT:UInt = 91;
	public static inline var WINDOWS_KEY_RIGHT:UInt = 92;
	public static inline var WINDOWS_RIGHT_CLICK:UInt = 93;
	public static inline var WINDOWS_VOLUME_DOWN:UInt = 174;
	public static inline var WINDOWS_VOLUME_UP:UInt = 175;
	public static inline var WINDOWS_VOLUME_MUTE:UInt = 173;
	public static inline var WINDOWS_PLAY_PAUSE:UInt = 179;
	public static inline var WINDOWS_BACK:UInt = 166;
	public static inline var WINDOWS_FORWARD:UInt = 167;
	public static inline var NUM_LOCK:UInt = 144;
	public static inline var SCROLL_LOCK:UInt = 145;
	public static inline var PAUSE_BREAK:UInt = 19;
}