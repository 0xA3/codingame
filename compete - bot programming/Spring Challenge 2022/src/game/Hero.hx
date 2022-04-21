package game;

class Hero {
	
	public final owner:Player;
	
	public var x:Int;
	public var y:Int;

	public function new( owner:Player ) {
		this.owner = owner;
	}

	public function toString() {
		return 'pos: $x:$y';
	}
}