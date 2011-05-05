/**
 * ...
 * @author Tony Polinelli
 */

package touchmypixel.particles;

import touchmypixel.game.geom.Vector;
import touchmypixel.particles.affectors.Affector;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;


//#if flash

typedef ParticleSprite = BitmapData;

/*
#else

typedef ParticleSprite = nme.TileRenderer;

#end*/


class Particle
{
	public static var pnum:Int = 0;
	public var affectors:Array<Affector>;
	public var emitter:Emitter;
	public var lifespan:Float;
	public var age:Float;
	public var isAlive:Bool;
	public var isActive:Bool;
	public var mass:Float;
	
	public var vx:Float;
	public var vy:Float;
	public var vr:Float;
	public var x:Float;
	public var y:Float;
	
	public var gfx:ParticleSprite;
	
	public var userData:Dynamic;
	
	public var num:Int;
	
	public function new() 
	{
		reset();
		
		lifespan = 50;
		
		age = 0;
		mass = 1;
		num = Particle.pnum++;
		
		isAlive = false;
		isActive = true;
	}
	
	/**
	 * Reset particle for use again later
	**/
	public function reset():Void
	{
		isAlive = false;
		isActive = false;
		age = 0;
		vx = vy = vr = x = y = 0;
		affectors = new Array();
		emitter = null;
	}
	
	public function clampSpeed(min, max)
	{
		var v = new Vector(vx, vy);
		var s = v.getLenth();
		
		if (s < min) 
		{
			var d = min / s;
			vx *= d;
			vy *= d;
			return;
		}
		if (s > max) 
		{
			var d = max / s;
			vx *= d;
			vy *= d;
		}
	}
	
	/**
	 * Add an Affector to this particle
	**/
	public function addAffector(affector:Affector):Affector
	{
		affectors.push(affector);
		
		return affector;
	}
	
	/**
	 * Add an Affector to this particle
	**/
	public function removeAffector(affector:Affector):Affector
	{
		affectors.remove(affector);
		
		return affector;
	}
	
	/**
	 * Apply all of the Affectors to the particle
	**/
	public inline function update(dt:Float) 
	{
		x += vx * dt;
		y += vy * dt;
		age += dt;
		
		for (affector in affectors) 
			affector.apply(this, dt);
		
		if (age > lifespan) 
			isAlive = false;
	}

	public static function createSprite(data:BitmapData) : ParticleSprite
	{
		//#if flash
		return data;
		//#else
		//return new nme.TileRenderer(data,0,0,data.width,data.height,0,0);
		//#end
	}
}
