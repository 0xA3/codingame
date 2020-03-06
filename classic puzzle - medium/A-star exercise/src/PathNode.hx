typedef Edge = {
	final to:Int;
	final cost:Int;
}

class PathNode {
	
	final distanceToGoal:Int;
	public final neighbors:Array<Edge> = [];
	public var costFromStart = Math.POSITIVE_INFINITY;
	public var previous = -1;
	public var visited = false;

	public function new( distanceToGoal:Int, neighbors:Array<Edge> ) {
		this.distanceToGoal = distanceToGoal;
		this.neighbors = neighbors;
	}
}