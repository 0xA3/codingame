typedef Neighbor = {
	final id:Int;
	final cost:Int;
}

class PathNode {
	
	public final id:Int;
	public final neighbors:Array<Neighbor> = [];
	public var costFromStart = Math.POSITIVE_INFINITY;
	public var intermediates = -1;
	public var previous = -1;
	public var costToPrevious = 0.0;
	public var visited = false;

	public function new( id:Int, neighbors:Array<Neighbor> ) {
		this.id = id;
		this.neighbors = neighbors;
	}

	public function copy() {
		return new PathNode( id, neighbors );
	}

	// public function toString() return 'id $id: ${neighborsToString()}';
	public function toString() return 'id $id intermediates $intermediates cost $costFromStart  intermediates+cost ${intermediates + costFromStart}';

	function neighborsToString() {
		return neighbors.map( n -> '${id}-${n.id} cost ${n.cost}' ).join( ", " );
	}

	public static function compareCostFromStart( a:PathNode, b:PathNode ) {
		if( a.costFromStart > b.costFromStart ) return true;
		return false;
	}

	public static function compareCostAndSteps( a:PathNode, b:PathNode ) {
		final aCost = a.costFromStart + a.intermediates;
		final bCost = b.costFromStart + b.intermediates;
		if( aCost > bCost ) return true;
		if( aCost < bCost ) return false;
		if( a.intermediates > b.intermediates ) return true;
		return false;
	}

}