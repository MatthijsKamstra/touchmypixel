/**
 * ...
 * @author Tonypee
 */

package touchmypixel.game.objects;
import haxe.xml.Fast;
import phx.Body;
import phx.World;

class PhxBodyObject extends Object
{
	public var type:String;
	
	public var world:World;
	public var body:Body;
	
	public var hits:Array<Body>;
	
	public function new(w:World) 
	{
		super();
		
		this.world = w;	
		hits = [];
	}
	
	public function registerHit(b:Body):Void
	{
		if (!Lambda.has(hits, b))
			hits.push(b);
	}
	
	public function resetHits()
	{
		hits = [];
	}
	
	override public function update(dt):Void
	{
		if(body != null)
		{
			x = body.x;
			y = body.y;
			rotation = Math.atan2(body.rsin, body.rcos) * 57.2957795;	
		}
	}
	
	override public function destroy()
	{
		super.destroy();
		
		if ( body != null )
		{
			world.removeBody(body);
			body = null;
		}
	}
}