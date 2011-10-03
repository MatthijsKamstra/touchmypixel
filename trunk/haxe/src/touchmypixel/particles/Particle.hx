/**
 * ...
 * @author Tony Polinelli
 */

package touchmypixel.particles;

import touchmypixel.game.geom.Vector;
import touchmypixel.particles.effectors.Effector;
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
	public var effectors:Array<Effector>;
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
		effectors = new Array();
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
	 * Add an effector to this particle
	**/
	public function addeffector(effector:Effector):Effector
	{
		effectors.push(effector);
		
		return effector;
	}
	
	/**
	 * Add an effector to this particle
	**/
	public function removeeffector(effector:Effector):Effector
	{
		effectors.remove(effector);
		
		return effector;
	}
	
	/**
	 * Apply all of the effectors to the particle
	**/
	public inline function update(dt:Float) 
	{
		x += vx * dt;
		y += vy * dt;
		age += dt;
		
		for (effector in effectors) 
			effector.apply(this, dt);
		
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
