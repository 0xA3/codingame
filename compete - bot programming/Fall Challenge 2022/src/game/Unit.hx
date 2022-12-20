package game;

class Unit {
	
	public static final NO_UNIT = new Unit( 0, 0 );

	public var availableCount:Int;
	public var unavailableCount:Int;

	public function new( availableCount:Int, unavailableCount:Int ) {
		this.availableCount = availableCount;
		this.unavailableCount = unavailableCount;
	}

	public function getStrength() return availableCount;
	
	public function add( available:Int, unavailable:Int ) {
		return new Unit( availableCount + available, unavailableCount + unavailable );
	}

	public function isValid() return this != NO_UNIT;

	public function reset() {
		availableCount += unavailableCount;
		unavailableCount = 0;
	}

	public function remove( n:Int ) return add( -n, 0 );

	public function toString() return 'availableCount: $availableCount, unavailableCount: $unavailableCount';
}