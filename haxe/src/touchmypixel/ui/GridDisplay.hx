package touchmypixel.ui;

import caurina.transitions.Tweener;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.MovieClip;
import flash.events.Event;
import flash.display.Sprite;
import flash.xml.XML;
import haxe.xml.Fast;

class GridDisplay extends MovieClip
{
	public static var INIT:String = "init";
	public static var CHANGE:String = "change";
	public static var ITEM_CLICK:String = "itemClick";
	public static var ITEM_INIT:String = "itemInit";
	public static var CHANGE_DATA:String = "changeData";
	
	//private var controller;
	public var rows:Int;
	public var columns:Int;
	public var currentPage:Int;
	public var totalPages:Int;
	public var data:Array<Dynamic>;
	public var createClass:Class<Dynamic>;
	public var itemW:Float;
	public var itemH:Float;
	public var items:Array<DisplayObject>;
	
	public function new(?columns:Int = 5, ?rows:Int = 5, ?itemW:Float = 50, ?itemH:Float = 50 )
	{
		super();
		
		this.rows = rows;
		this.columns = columns;
		this.itemH = itemH;
		this.itemW = itemW;
		
		items = [];
	}
	
	public function setData(d:Dynamic)
	{
		reset();
		
		data = Std.is(d, Array) ? d : xmlToArray(Xml.parse(d));
				
		//trace("GRID DISPLAY " + data);
		currentPage = 0;
		totalPages = Math.ceil(data.length / (rows * columns));
		
		dispatchEvent(new Event(INIT));
		
		display();
	}
	
	private function xmlToArray(x:Xml)
	{
		var a:Array<Dynamic> = [];
		for(row in x.elements())
		{
			var item = {};
			for(att in row.attributes())
				Reflect.setField(item, att, row.get(att));
			a.push(item);
		}
		return a;
	}
	
	public function display(?page:Int = 1)
	{
		currentPage = page;
		update();
	}
	
	private function update()
	{
		clear();
		var itemsPerPage = rows * columns;
		var first = (currentPage-1) * itemsPerPage;
		var last = (currentPage-1) * itemsPerPage + itemsPerPage;
		
		if (last > data.length) last = data.length;
		
		if (data != null && (last > 0)) {
			var i = first;
			while(i < last) {
				var o:Sprite = Type.createInstance(createClass, []);
				Reflect.setField(o, 'data', data[i]);
				
				for(j in Reflect.fields(data[i])) {
					if (Std.is(Reflect.field(o, j), Bool)) {
						Reflect.setField(o, j, (Reflect.field(data[i], j) == "1" ? true : false));
					}else {
						Reflect.setField(o, j, Reflect.field(data[i], j));
					}
				}
				
				o.dispatchEvent(new Event(ITEM_INIT));
				
				o.x = i % columns * (itemW);
				o.y = Math.floor((i - first) / columns) * (itemH);
				
				//trace(o.x + " - " + o.y);
				
				addChild(o);
				
				dispatchEvent(new Event(ITEM_CLICK));
				
				items.push(o);
				
				i++;
			}
			totalPages = Math.ceil(last / itemsPerPage);
		}
		
		if (true){
			var m = new MovieClip();
			addChildAt(m, 0);
			var w = itemW * columns;
			var h = itemH * items.length / columns + itemH;
			var g:Graphics = m.graphics;
			g.beginFill(0x000000, 0);
			g.drawRect(0, 0, w, h);
			g.endFill();
		}
		
		dispatchEvent(new Event(CHANGE));
	}
	
	public function next()
	{
		if (hasNext()) {
			currentPage++;
			update();
		}
	}
	
	public function prev()
	{
		if (hasPrev()) {
			currentPage--;
			update();
		}
	}
	
	public function hasNext()
	{
		return (currentPage < (totalPages - 1));
	}
	
	public function hasPrev()
	{
		return (currentPage > 0);
	}
	
	public function clear()
	{
		for(item in items) 
		{
			Tweener.removeTweens(item);
			removeChild(item);
		}
		items = [];
	}
	
	public function reset()
	{
		clear();
		currentPage = 0;
		totalPages = 0;
	}
}