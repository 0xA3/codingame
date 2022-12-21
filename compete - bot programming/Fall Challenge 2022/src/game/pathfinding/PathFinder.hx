package game.pathfinding;

/*
 * Find the best path from a Coord to another Coord
 * currently : using Astar algorithm
 */

 class PathFinderResult {
	
	public static final NO_PATH = new PathFinderResult();
	
	public var path:Array<Coord> = [];
	public var weightedLength = -1;
	public var isNearest = false;

	public function new() {	}
	public function hasNextCoord() return path.length > 1;
	public function getNextCoord() return path[1];
	public function hasNoPath() return weightedLength == -1;
 }

class PathFinder {

	var grid:Grid;
	var start = Coord.NO_COORD;
	var end = Coord.NO_COORD;
	var weightFunction = ( coord:Coord ) -> 1;
	var restricted:Array<Coord>;

	public function new() { }

	public function setGrid( grid:Grid ) { this.grid = grid; return this; }
	public function from( coord:Coord ) { this.start = coord; return this; }
	public function to( coord:Coord ) { this.end = coord; return this; }
	public function withWeightFunction( weightFunction:( Coord ) -> Int ) { this.weightFunction = weightFunction; return this; }
	public function restrict( restricted:Array<Coord> ) { this.restricted = restricted; return this; }

	public function findPath() {
		if( start == Coord.NO_COORD || end == Coord.NO_COORD ) return PathFinderResult.NO_PATH;

		final a = new AStar( grid, start, end, weightFunction, restricted );
		var pathItems = a.find();
		final pfr = new PathFinderResult();

		if( pathItems.length == 0 ) {
			pfr.isNearest = true;
			pathItems = new AStar( grid, start, a.nearest, weightFunction, restricted ).find();
		}

		pfr.path = pathItems.map( item -> item.coord );
		pfr.weightedLength = pathItems[pathItems.length - 1].cumulativeLength;

		return pfr;
	}
}

