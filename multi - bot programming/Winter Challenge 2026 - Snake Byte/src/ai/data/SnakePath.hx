package ai.data;

import xa3.math.Pos;

class SnakePath {
	
	public final snakeId:Int;
	public final distance:Int;
	public final targetPos:Pos;
	public final path:Array<Pos>;

	public function new( snakeId:Int, distance:Int, targetPos:Pos, path:Array<Pos> ) {
		this.snakeId = snakeId;
		this.distance = distance;
		this.targetPos = targetPos;
		this.path = path;
	}
}