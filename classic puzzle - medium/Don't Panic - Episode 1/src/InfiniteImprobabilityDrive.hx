class InfiniteImprobabilityDrive {
	
	final nbFloors:Int;
	final width:Int;
	final exitFloor:Int;
	final exitPos:Int;
	final elevators:Map<Int, Int>;

	public function new( nbFloors:Int, width:Int, exitFloor:Int, exitPos:Int, elevators:Map<Int, Int> ) {
		this.nbFloors = nbFloors;
		this.width = width;
		this.exitFloor = exitFloor;
		this.exitPos = exitPos;
		this.elevators = elevators;	
	}

	public function getTargetPosition( floor:Int ) {
		if( elevators.exists( floor )) return elevators[floor];
		if( floor == exitFloor ) return exitPos;
		throw 'Error: no elevator and no exit on floor $floor';
	}

}