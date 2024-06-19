package ai.data;

class SkatingDataset {
	
	public var spacesTravelled = 0;
	public var riskOrStun = 0;

	public function new() {}

	public function set( spacesTravelled:Int, riskOrStun:Int ) {
		this.spacesTravelled = spacesTravelled;
		this.riskOrStun = riskOrStun;
	}

	public function copy( other:SkatingDataset ) {
		this.spacesTravelled = other.spacesTravelled;
		this.riskOrStun = other.riskOrStun;
	}

	public function reset() {
		spacesTravelled = 0;
		riskOrStun = 0;
	}
}