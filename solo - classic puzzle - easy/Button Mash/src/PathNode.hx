import eval.luv.Path;

typedef Edge = {
	final to:Int;
	final cost:Int;
}

class PathNode {
	
	public static final NO_NODE = new PathNode( "", -1, 2_147_483_647, 2_147_483_647 );

	public final button:String;
	public final value:Int;
	public final distanceToGoal:Int;
	public final costFromStart:Int;
	// public var priority = Math.POSITIVE_INFINITY;
	public var previous = PathNode.NO_NODE;

	public function new( button:String, value:Int, costFromStart:Int, distanceToGoal:Int ) {
		this.button = button;
		this.value = value;
		this.costFromStart = costFromStart;
		this.distanceToGoal = distanceToGoal;
	}

	public function toString() return '{ ${ previous != PathNode.NO_NODE ? Std.string( previous ) + "-" : ""}$value';

	// public static function compareCostFromStart( a:PathNode, b:PathNode ) {
	// 	if( a.costFromStart > b.costFromStart ) return true;
	// 	return false;
	// }

	// public static function compareDistanceToGoal( a:PathNode, b:PathNode ) {
	// 	if( a.distanceToGoal > b.distanceToGoal ) return true;
	// 	return false;
	// }

	// public static function comparePriority( a:PathNode, b:PathNode ) {
	// 	if( a.priority > b.priority ) return true;
	// 	return false;
	// }

	// public static function comparePriorityAndCost( a:PathNode, b:PathNode ) {
	// 	if( a.priority > b.priority ) return true;
	// 	if( a.priority < b.priority ) return false;
	// 	if( a.costFromStart > b.costFromStart ) return true;
	// 	return false;
	// }

	public static function compareCostAndDistance( a:PathNode, b:PathNode ) {
		if( a.costFromStart > b.costFromStart ) return true;
		if( a.costFromStart < b.costFromStart ) return false;
		if( a.distanceToGoal > b.distanceToGoal ) return true;
		return false;
	}
}