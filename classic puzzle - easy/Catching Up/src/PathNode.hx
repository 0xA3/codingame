import Math.abs;
import Std.int;

class PathNode {
	
	public final id:Int;
	public final neighbors:Array<Int> = [];
	public var costFromStart:Float;
	public var distanceToGoal:Int;
	public var priority:Float;
	public var previous:Int;
	public var visited = false;

	public function new( id:Int, neighbors:Array<Int> ) {
		this.id = id;
		this.neighbors = neighbors;
	}

	public function reset( goalIndex:Int, width:Int, visited:Bool ) {
		this.visited = visited;
		costFromStart = Math.POSITIVE_INFINITY;
		distanceToGoal = 0;
		priority = Math.POSITIVE_INFINITY;
		previous = -1;
		
		final x = id % width;
		final y = int( id / width );
		final gx = goalIndex % width;
		final gy = int( goalIndex / width );
		final deltaX = gx - x;
		final deltaY = gy - y;
		distanceToGoal = deltaX * deltaX + deltaY * deltaY;
		// trace( '$id  x $x  y $y  gx $gx  gy $gy  deltaX $deltaX  deltaY $deltaY distanceToGoal $distanceToGoal' );
	}

	public function toString() {
		return '$id distanceToGoal: $distanceToGoal';
		// return '$id neighbors: $neighbors, costFromStart: $costFromStart, distanceToGoal: $distanceToGoal, priority: $priority, previous: $previous';
	}

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