package game;

class Mob extends GameEntity {
	
	// Referee and Agent vars
	public var velocity = new Vector( 0, 0 );
	public var health:Int;
	public var healthChanged = true;
	public var status:MobStatus;
	public var nextControls = new List<Vector>();

	// Agent Vars
	public var isUnderControlSpell = false;
	public var isNearBase = false;
	public var threatFor = 0;
	public var threatLevel = 0.0;

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

	public function toString() {
		return 'Mob id: $id, velocity $velocity, health: $health, status $status, nextControls: $nextControls';
	}

}

