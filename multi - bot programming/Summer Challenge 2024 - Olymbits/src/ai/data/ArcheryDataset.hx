package ai.data;

import CodinGame.printErr;

class ArcheryDataset {
	
	public final position = new Pos();

	public function new() { }

	public function set( x:Int, y:Int ) {
		position.x = x;
		position.y = y;
	}

	public function copyFrom( other:ArcheryDataset ) {
		this.position.x = other.position.x;
		this.position.y = other.position.y;
	}

	public function reset() {
		position.x = 0;
		position.y = 0;
	}
}