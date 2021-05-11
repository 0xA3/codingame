package game;

class Tree {
	
	public var size = 0;
	public var owner:Player;
	public var fatherIndex = -1;
	public var isDormant:Bool;

	public function new( owner:Player, fatherIndex:Int ) {
		this.owner = owner;
		this.fatherIndex = fatherIndex;
	}

	public function grow() size++;
	public function setDormant() isDormant = true;
	public function reset() isDormant = false;

	public function toString() {
		return 'size:$size dormant:$isDormant';
	}
}