package game;

using Lambda;

class Player {
	
	static inline var MAX_INV = 10;
	
	public var inventory:Array<Int> = [];
	var score:Int;
	public var space(default, null):Int;

	public function new( inv0 = 0, inv1 = 0, inv2 = 0, inv3 = 0, score = 0 ) {
		update( inv0, iniv1, inv2, inv3, score );
	}

	public function update( inv0:Int, inv1:Int, inv2:Int, inv3:Int, score:Int ) {
		inventory[0] = inv0;
		inventory[1] = inv1;
		inventory[2] = inv2;
		inventory[3] = inv3;
		this.score = score;

		space = MAX_INV - inventory.fold(( i, sum ) -> i + sum, 0 );
	}

	public function copy() {
		return new Player( inventory[0], inventory[1], inventory[2], inventory[3], score );
	}

}