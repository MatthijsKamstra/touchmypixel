/**
 * ...
 * @author Tony Polinelli
 */

package touchmypixel.particles;
import haxe.FastList;

class ParticlePool
{
	public static var instance:ParticlePool;
	
	public var pool:FastList<Particle>;
	public var next:Int;
	public var length:Int;
	public var i:Iterator<Particle>;
	
	public function new(amount) 
	{
		length = amount;
		next = 0;
		
		pool = new FastList<Particle>();
		for (i in 0...amount)
			pool.add(new Particle());
			
		//i = pool.iterator();
	}
	
	public static function init(amount:Int)
	{
		return instance = new ParticlePool(amount);
	}
	
	/**
	 * Return a fresh particle
	**/
	public inline function getParticle()
	{
		if (i == null || !i.hasNext())
			i = pool.iterator();
			
		return i.next();
		
		/*next++;
		if (next >= length) next = 0;
		
		return pool[next];
		*/
		
		//next = pool.
	}
	
}