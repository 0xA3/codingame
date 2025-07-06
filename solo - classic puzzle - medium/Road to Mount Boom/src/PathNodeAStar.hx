import eval.luv.Path;

typedef Edge = {
	final to:Pos;
	final cost:Int;
}

class PathNodeAStar {
	
	public static final NO_NODE = new PathNodeAStar( null, -1, [] );

	public final pos:Pos;
	public final distanceToGoal:Int;
	public final neighbors:Array<Edge> = [];
	public var costFromStart = Math.POSITIVE_INFINITY;
	public var priority = Math.POSITIVE_INFINITY;
	public var previous = PathNodeAStar.NO_NODE;
	public var visited = false;

	public function new( pos:Pos, distanceToGoal:Int, neighbors:Array<Edge> ) {
		this.pos = pos;
		this.distanceToGoal = distanceToGoal;
		this.neighbors = neighbors;
	}

	public function toString() return '{ ${ previous != PathNodeAStar.NO_NODE ? Std.string( previous ) + "-" : ""}$pos prio: $priority}';

	public static function compareCostFromStart( a:PathNodeAStar, b:PathNodeAStar ) {
		if( a.costFromStart > b.costFromStart ) return true;
		return false;
	}

	public static function compareDistanceToGoal( a:PathNodeAStar, b:PathNodeAStar ) {
		if( a.distanceToGoal > b.distanceToGoal ) return true;
		return false;
	}

	public static function comparePriority( a:PathNodeAStar, b:PathNodeAStar ) {
		if( a.priority > b.priority ) return true;
		return false;
	}

	public static function comparePriorityAndId( a:PathNodeAStar, b:PathNodeAStar ) {
		if( a.priority > b.priority ) return true;
		if( a.priority < b.priority ) return false;
		if( a.pos.x + a.pos.y > b.pos.x + b.pos.y ) return true;
		return false;
	}
}