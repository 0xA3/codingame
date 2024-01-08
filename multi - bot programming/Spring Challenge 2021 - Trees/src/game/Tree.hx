package game;

class Tree {
	
	public final owner:Player;
	
	public var size = 0;
	public var fatherIndex = -1;
	public var isDormant:Bool;

	public function new( owner:Player ) {
		this.owner = owner;
	}

	public function grow() size++;
	public function setDormant() isDormant = true;
	public function reset() isDormant = false;

	public function toString() {
		return 'size:$size dormant:$isDormant';
	}
}