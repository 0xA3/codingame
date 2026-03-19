package ai.data;

import xa3.math.Pos;

class SnakePath {
	
	public final snakebot:Snakebot;
	public final distance:Int;
	public final targetPos:Pos;
	public final path:Array<Pos>;

	public function new( snakebot:Snakebot, distance:Int, targetPos:Pos, path:Array<Pos> ) {
		this.snakebot = snakebot;
		this.distance = distance;
		this.targetPos = targetPos;
		this.path = path;
	}
}