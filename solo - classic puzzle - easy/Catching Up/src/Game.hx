import CodinGame.printErr;
import Std.int;

class Game {
	
	static inline var WALL = "*";

	final grid:Array<Array<String>>;
	final width:Int;
	final height:Int;
	
	final nodes:Array<PathNode> = [];
	var myIndex = 0;
	var otherIndex = 0;
	final visitedCells:Array<Int> = [];

	public function new( grid:Array<Array<String>> ) {
		this.grid = grid;
		width = grid[0].length;
		height = grid.length;
	}

	public function init() {
		var index = 0;
		
		for( y in 0...grid.length ) {
			for( x in 0...grid[y].length ) {
				if( grid[y][x] == "P" ) myIndex = index;
				if( grid[y][x] == "E" ) otherIndex = index;
				
				final neighbors = [];
				if( grid[y][x] != WALL ) {
					if( x > 0 && grid[y][x - 1] != WALL ) neighbors.push( index - 1 );
					if( x < width - 1 && grid[y][x + 1] != WALL ) neighbors.push( index + 1 );
					if( y > 0 && grid[y - 1][x] != WALL ) neighbors.push( index - width );
					if( y < height - 1 && grid[y + 1][x] != WALL ) neighbors.push( index + width );
				}
				final node = new PathNode( index, neighbors );
				// trace( '$x:$y  index $index  neighbors $neighbors' );
				nodes.push( node );
				index++;
			}
		}
	}

	public function step( eneX:Int, eneY:Int ) {
		otherIndex = eneY * width + eneX;
		
		visitedCells.remove( otherIndex );
		for( node in nodes ) node.reset( otherIndex, width, visitedCells.contains( node.id ));
		visitedCells.push( myIndex );
		
		final path = searchPath();
		// printErr( getPathDisplay( path ));
		
		if( path.length < 2 ) throw "Error: no path found";

		final next = path[1][0];
		final output = next == myIndex + 1 ? "R"
				: next == myIndex - 1 ? "L"
				: next == myIndex - 10 ? "U"
				: next == myIndex + 10 ? "D"
				: 'Error myIndex $myIndex  nextIndex $next';
		
		myIndex = next;
		
		return output;
	}

	// A-Star Search
	function searchPath() {
		final outputs = new List<Array<Int>>();
		final frontier = new MinPriorityQueue<PathNode>( PathNode.comparePriorityAndId );
		
		final startNode = nodes[myIndex];
		startNode.visited = true;
		startNode.costFromStart = 0;
		startNode.priority = startNode.distanceToGoal;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			outputs.add( [currentNode.id, Std.int( currentNode.priority )] );
			if( currentNode.id == otherIndex ) {
				return backtrack( nodes, myIndex, otherIndex );
			}
			
			// CodinGame.printErr( 'current ${currentNode.id}' );
			for( edge in currentNode.neighbors ) {
				final nextNode = nodes[edge];
				final nextCost = currentNode.costFromStart + 1;
				final nextPriority = nextCost + nextNode.distanceToGoal;
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} priority $nextPriority' + ( nextNode.visited ? '  <  ${nextNode.previous}-${nextNode.id} priority ${nextNode.priority}' : "" ));
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id}' );
				
				if( nextPriority < nextNode.priority ) {
					nextNode.previous = currentNode.id;
					nextNode.costFromStart = nextCost;
					nextNode.priority = nextPriority;
					
					if( !nextNode.visited ) {
						frontier.add( nextNode );
					} else {
						frontier.sort();
					}
					nextNode.visited = true;
					// CodinGame.printErr( frontier );
				}
			}
		}
		return [];
	}

	static function backtrack( nodes:Array<PathNode>, start:Int, goal:Int ) {
		final path = new List<Array<Int>>();
		var i = goal;
		while( i != start ) {
			path.add( [i, Std.int( nodes[i].priority )]);
			i = nodes[i].previous;
		}
		path.add( [i, Std.int( nodes[i].priority )] );
		final aPath = Lambda.array( path );
		aPath.reverse();
		// CodinGame.printErr( aPath );
		return aPath;
	}
	
	function getPathDisplay( path:Array<Array<Int>> ) {
		final copy = grid.map( line -> line.copy());
		for( point in path ) {
			final x = point[0] % width;
			final y = int( point[0] / width );
			if( copy[y][x] == "-" ) copy[y][x] = ".";
		}
		final output = copy.map( line -> line.join( "" )).join( "\n" );
		return output;
	}
}