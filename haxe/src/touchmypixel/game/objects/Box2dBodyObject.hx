/**
 * ...
 * @author Tonypee
 */

package touchmypixel.game.objects;
import box2D.collision.shapes.B2ShapeDef;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import haxe.xml.Fast;
import touchmypixel.game.ds.ObjectHash;
import touchmypixel.game.objects.Box2dObject;
import touchmypixel.game.simulations.Box2dSimulation;
import touchmypixel.game.box2d.ContactPoint;

class Box2dBodyObject extends Object
{
	public var type:String;
	public var simulation:Box2dSimulation;
	
	public var gameObject:Box2dObject;
	
	public var body:B2Body;
	
	public var contacts_add:ObjectHash<Array<ContactPoint>>;
	public var contacts_persist:ObjectHash<Array<ContactPoint>>;
	public var contacts_remove:ObjectHash<Array<ContactPoint>>;
	
	public var cacheContacts:Bool;
	
	public function new(s:Box2dSimulation) 
	{
		super();
		
		simulation = s;
		
		createBody(new B2BodyDef());
		
		cacheContacts = false;
		
		contacts_add = new ObjectHash();
		contacts_persist = new ObjectHash();
		contacts_remove = new ObjectHash();	
	}
	
	override public function update(dt)
	{
		if(body != null)
			simulation.sync(this, body);
	}
	
	public function createBody(bodyDef:B2BodyDef)
	{
		body = simulation.world.CreateBody(bodyDef);
		body.SetUserData(this);
	}
	
	public function createShape(def:B2ShapeDef)
	{
		if (body == null)
			createBody(new B2BodyDef());
			 
		body.CreateShape(def);
			
		body.SetMassFromShapes();
	}
	
	override public function destroy()
	{
		super.destroy();
		
		freeContactList(contacts_add);
		contacts_add = null;
		freeContactList(contacts_persist);
		contacts_persist = null;
		freeContactList(contacts_remove);
		contacts_remove = null;
	
		if ( body != null )
		{
			body.SetUserData(null);	
			simulation.world.DestroyBody(body);
			body = null;
		}
	
		gameObject = null;
		simulation = null;
	}
	
	inline function freeContactList( list : ObjectHash<Array<ContactPoint>> ) : Void
	{
		if ( list != null )
		{
			for ( a in list )
			{
				for ( cp in a )
				{
					cp.body1 = cp.body2 = null;
					cp.object1 = cp.object2 = null;
					cp.shape1 = cp.shape2 = null;
				}
			}
		}
	}
}