package game;

class Mob extends GameEntity {
	
	public var speed = new Vector( 0, 0 );
	public var health:Int;
	public var healthChanged = true;
	public var status:MobStatus;
	public var nextControls = new List<Vector>();

	public var isUnderControlSpell = false;
	public var isNearBase = false;
	public var threatFor = 0;

	public function new( id:Int, position:Vector, health:Int, type = 2 ) {
		super( id, position, type );
		this.health = health;
		pushed = false;
		// trace( 'new Mob $id' );
	}

	public function isAlive() return health > 0;

	public function hit( damage:Int ) {
		health -= damage;
		healthChanged = true;
	}

	public function heathHasChanged() return healthChanged;
	public function moveCancelled() return !isAlive() || pushed;
	
	function set_speed( speed:Vector ) {
		status = null;
		return this.speed = speed;
	}

	public function reset() {
        pushed = false;
        healthChanged = false;
        activeControls.clear();
        for( c in nextControls ) activeControls.add( c );
        nextControls.clear();
	}

	override function getOwner() return null;
	override function applyControl( destination:Vector ) nextControls.push( destination );
	
	override function pushTo( position:Vector ) {
		super.pushTo( position );
		status = null;
		pushed = true;
	}

}

