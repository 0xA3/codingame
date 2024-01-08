package game;

class Cell {
	
	public static final NO_CELL = new Cell( 0, false );

	public var durability:Int;
	public final isValid:Bool;
	public var owner = Player.NO_PLAYER;

	public function new( durability = 0, isValid = true ) {
		this.durability = durability;
		this.isValid = isValid;
	}

	public static function fromCell( cell:Cell ) {
		return new Cell( cell.durability );
	}

	public function isHole() return durability == 0;

	public function garanteeNotHole() if( isHole()) durability = 1;

	public function damage() {
		durability--;
		if( durability == 0 ) {
			owner = Player.NO_PLAYER;
			return true;
		}
		return false;
	}

	public function isOwnedBy( p:Player ) return owner == p;

	public function toString() return 'durability: $durability, isValid: $isValid, owner: ${owner.index}';
}