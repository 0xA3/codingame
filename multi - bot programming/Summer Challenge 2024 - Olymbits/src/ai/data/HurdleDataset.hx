package ai.data;

class HurdleDataset {
	
	public var position = 0;
	public var stunTimer = 0;

	public function new() {}

	public function set( position:Int, stunTimer:Int ) {
		this.position = position;
		this.stunTimer = stunTimer;
	}

	public function copy( other:HurdleDataset ) {
		this.position = other.position;
		this.stunTimer = other.stunTimer;
	}
	
	public function reset() {
		position = 0;
		stunTimer = 0;
	}
}