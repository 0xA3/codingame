package ai.data;

class DivingDataset {
	
	public var points = 0;
	public var combos = 0;

	public function new() {}

	public function set( points:Int, combos:Int ) {
		this.points = points;
		this.combos = combos;
	}

	public function copyFrom( other:DivingDataset ) {
		this.points = other.points;
		this.combos = other.combos;
	}

	public function reset() {
		points = 0;
		combos = 0;
	}
}