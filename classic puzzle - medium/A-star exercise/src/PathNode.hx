typedef Edge = {
	final to:Int;
	final cost:Int;
}

class PathNode {
	
	public final id:Int;
	public final distanceToGoal:Int;
	public final neighbors:Array<Edge> = [];
	public var costFromStart = Math.POSITIVE_INFINITY;
	public var priority = Math.POSITIVE_INFINITY;
	public var previous = -1;
	public var visited = false;

	public function new( id:Int, distanceToGoal:Int, neighbors:Array<Edge> ) {
		this.id = id;
		this.distanceToGoal = distanceToGoal;
		this.neighbors = neighbors;
	}

	public function toString() return '{ ${ previous != -1 ? Std.string( previous ) + "-" : ""}$id prio: $priority}';

	public static function compareCostFromStart( a:PathNode, b:PathNode ) {
		if( a.costFromStart > b.costFromStart ) return true;
		return false;
	}

	public static function compareDistanceToGoal( a:PathNode, b:PathNode ) {
		if( a.distanceToGoal > b.distanceToGoal ) return true;
		return false;
	}

	public static function comparePriority( a:PathNode, b:PathNode ) {
		if( a.priority > b.priority ) return true;
		return false;
	}

	public static function comparePriorityAndId( a:PathNode, b:PathNode ) {
		if( a.priority > b.priority ) return true;
		if( a.priority < b.priority ) return false;
		if( a.id > b.id ) return true;
		return false;
	}
}