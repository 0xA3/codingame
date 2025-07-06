import CodinGame.printErr;
import PathNodeAStar.Edge;
import Std.int;
import haxe.Exception;

using Lambda;

class AStarSearch {
	
	public static function getPath( nodes:Map<Pos, PathNodeAStar>, start:Pos, goal:Pos ) {
		final frontier = new MinPriorityQueue<PathNodeAStar>( PathNodeAStar.comparePriorityAndId );
		
		final startNode = nodes[start];
		if( startNode == null ) throw new Exception( 'Error: There is no Node with position $start' );
		startNode.visited = true;
		startNode.costFromStart = 0;
		startNode.priority = startNode.distanceToGoal;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			if( currentNode.pos == goal ) {
				// CodinGame.printErr( 'found goal' );
				return backtrack( currentNode );
			}
			
			// CodinGame.printErr( 'current ${currentNode.pos}' );
			for( edge in currentNode.neighbors ) {
				final nextNode = nodes[edge.to];
				final nextCost = currentNode.costFromStart + edge.cost;
				final nextPriority = nextCost + nextNode.distanceToGoal;
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} priority $nextPriority' + ( nextNode.visited ? '  <  ${nextNode.previous}-${nextNode.id} priority ${nextNode.priority}' : "" ));
				
				if( nextPriority < nextNode.priority ) {
					nextNode.previous = currentNode;
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

	static function backtrack( goalNode:PathNodeAStar ) {
		final path = new List<Pos>();
		var current = goalNode;
		while( current.previous != PathNodeAStar.NO_NODE ) {
			path.add( current.pos );
			current = current.previous;
		}
		
		path.add( current.previous.pos ); // add start position

		final aPath = Lambda.array( path );
		aPath.reverse();
		// for( pos in aPath ) printErr( '$pos' );
		return aPath;
	}

	public static function createNodes( grid:Array<Array<String>>, positions:Array<Array<Pos>>, endPos:Pos ) {
		
		final nodes:Map<Pos, PathNodeAStar> = [];
		for( y in 0...grid.length ) {
			for( x in 0...grid[y].length ) {
				if( grid[y][x] == "^" ) continue;

				final pos = positions[y][x];
				final distanceToGoal = manhattanDistance( x, y, endPos );

				final neighbors = getNeighbors( x, y, grid, positions );
				final validNeighbors = neighbors.filter( n -> validateNeighbor( n, x, y, grid ) );
				// printErr( 'pos: $x:$y (${grid[y][x]}), neighbors: ' + validNeighbors.map( n -> '${n.x}:${n.y} (${grid[n.y][n.x]})}' ).join(" "));
				final edges = validNeighbors.map( neighborPos -> {
					final edge:Edge = { to: neighborPos, cost: 1 };
					return edge;
				});

				final node = new PathNodeAStar( pos, distanceToGoal, edges );
				// printErr( 'node: ${node.pos} "${grid[y][x]}", distanceToGoal: ${node.distanceToGoal}, neighbors: ${node.neighbors.map( n -> '$n' ).join(",")}' );
				nodes.set( pos, node );
			}
		}

		return nodes;
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