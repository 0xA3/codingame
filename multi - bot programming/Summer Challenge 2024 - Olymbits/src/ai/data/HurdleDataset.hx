package ai.data;

class HurdleDataset {
	
	public var position:Int;
	public var stunTimer:Int;

	public function new( position = 0, stunTimer = 0 ) {
		this.position = position;
		this.stunTimer = stunTimer;
	}

	public function copy() {
		return new HurdleDataset( position, stunTimer );
	}

	public function set( position:Int, stunTimer:Int ) {
		this.position = position;
		this.stunTimer = stunTimer;
	}

	public function copyFrom( other:HurdleDataset ) {
		this.position = other.position;
		this.stunTimer = other.stunTimer;
	}

	public function reset() {
		position = 0;
		stunTimer = 0;
	}
}