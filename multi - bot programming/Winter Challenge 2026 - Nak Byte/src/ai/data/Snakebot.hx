package ai.data;

import xa3.math.Pos;

class Snakebot {
	
	public final id:Int;
	public final bodyPositions:Array<Pos>;

	public function new( id:Int, bodyPositions:Array<Pos> ) {
		this.id = id;
		this.bodyPositions = bodyPositions;
	}
}