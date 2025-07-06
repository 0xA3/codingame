import PathNodeAStar.Edge;
import Std.int;

using Lambda;

class AStarSearch {
	
	public static function getPath( nodes:Map<Int, PathNodeAStar>, start:Int, goal:Int ) {
		
		final outputs = new List<Array<Int>>();
		final frontier = new MinPriorityQueue<PathNodeAStar>( PathNodeAStar.comparePriorityAndId );
		
		final startNode = nodes[start];
		startNode.visited = true;
		startNode.costFromStart = 0;
		startNode.priority = startNode.distanceToGoal;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			outputs.add( [currentNode.id, Std.int( currentNode.priority )] );
			if( currentNode.id == goal ) {
				// CodinGame.printErr( 'found goal' );
				// return backtrack( nodes, start, goal );
				return Lambda.array( outputs );
			}
			
			CodinGame.printErr( 'current ${currentNode.id}' );
			for( edge in currentNode.neighbors ) {
				final nextNode = nodes[edge.to];
				final nextCost = currentNode.costFromStart + edge.cost;
				final nextPriority = nextCost + nextNode.distanceToGoal;
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} priority $nextPriority' + ( nextNode.visited ? '  <  ${nextNode.previous}-${nextNode.id} priority ${nextNode.priority}' : "" ));
				
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

	static function backtrack( nodes:Array<PathNodeAStar>, start:Int, goal:Int ) {
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

	public static function createNodes( grid:Array<Array<String>>, width:Int, endPos:Pos ) {
		final positions = [for( y in 0...grid.length ) [for( x in 0...grid[y].length ) { final pos:Pos = { x: x, y: y }; pos; }]];
		
		final nodes:Map<Int, PathNodeAStar> = [];
		for( y in 0...grid.length ) {
			for( x in 0...grid[y].length ) {
				if( grid[y][x] == "^" ) continue;

				final id = getId( x, y, width );
				final distanceToGoal = manhattanDistance( x, y, endPos );

				final neighbors = getNeighbors( x, y, grid, positions );
				final validNeighbors = neighbors.filter( n -> validateNeighbor( n, x, y, grid ) );
				// printErr( 'pos: $x:$y (${grid[y][x]}), neighbors: ' + validNeighbors.map( n -> '${n.x}:${n.y} (${grid[n.y][n.x]})}' ).join(" "));
				final edges = validNeighbors.map( n -> {
					final index = n.y * width + n.x;
					final edge:Edge = { to: index, cost: 1 };
					return edge;
				});

				final node = new PathNodeAStar( id, distanceToGoal, edges );
				// printErr( 'node: ${node.id} ($x:$y) "${grid[y][x]}", distanceToGoal: ${node.distanceToGoal}, neighbors: ${node.neighbors.map( n -> toPos( n.to, width ))}' );
				nodes.set( id, node );
			}
		}

		return nodes;
	}

	static function getId( x:Int, y:Int, width:Int ) return y * width + x;
	static function toPos( id:Int, width:Int ) {
		final pos:Pos = { x: id % width, y: int( id / width )}
		return pos;
	}

	static function manhattanDistance( x:Int, y:Int, p2:Pos ) return abs( x - p2.x ) + abs( y - p2.y );

	static function getNeighbors( x:Int, y:Int, grid:Array<Array<String>>, positions:Array<Array<Pos>> ) {
		final minX = max( 0, x - 1 );
		final maxX = min( grid[y].length - 1, x + 1 );
		final minY = max( 0, y - 1 );
		final maxY = min( grid.length - 1, y + 1 );
		
		final neighbors = [for( ny in minY...maxY + 1 ) for( nx in minX...maxX + 1 ) if( nx != x || ny != y ) positions[ny][nx]];
		return neighbors;
	}

	static function validateNeighbor( neighbor:Pos, x:Int, y:Int, grid:Array<Array<String>> ) {
		// horizontal or vertical neighbor
		if( neighbor.x == x || neighbor.y == y ) return grid[neighbor.y][neighbor.x] != "^";
		
		// diagonal neighbor
		final isMountainNeighbor = grid[neighbor.y][neighbor.x] == "^";
		if( isMountainNeighbor ) return false;

		final isHorizontalMountain = grid[y][neighbor.x] == "^";
		final isVerticalMountain = grid[neighbor.y][x] == "^";
		if( isHorizontalMountain && isVerticalMountain ) return false;

		return true;
	}

	
	static function abs( v:Int ) return v < 0 ? -v : v;
	static function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
	static function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
}