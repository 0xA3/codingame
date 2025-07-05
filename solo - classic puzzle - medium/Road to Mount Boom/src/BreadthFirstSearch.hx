import CodinGame.printErr;
import Std.int;
import ya.Set;

using Lambda;

class Node {
	public static final NO_NODE = new Node( null, -1, Pos.NO_POS );
	
	public final previous:Node;
	public final id:Int;
	public final pos:Pos;
	public var visited = false;

	public function new( previous:Node, id:Int, pos:Pos ) {
		this.previous = previous;
		this.id = id;
		this.pos = pos;
	}

	public function toString() return '${pos.x}:${pos.y}';
}


class BreadthFirstSearch {
	
	public static function getPath( grid:Array<Array<String>>, width:Int, positions:Array<Array<Pos>>, start:Int, goal:Int ) {
		final frontier = new List<Node>();
		final visited = new Set<Pos>();

		final startPos = positions[int(start / width)][start % width];
		final startNode:Node = new Node( Node.NO_NODE, start, startPos );
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			// printErr( 'current: $current' );
			if( current.id == goal ) return backtrack( current );

			// trace( 'current $current' );
			final neighbors = getNeighbors( current.pos, grid, positions );
			final validNeighbors = neighbors.filter( n -> validateNeighbor( current.pos, n, grid, visited ) );
			
			for( neighbor in validNeighbors ) {
				// printErr( 'validNeighbor: $neighbor' );
				final id = neighbor.y * width + neighbor.x;
				final node = new Node( current, id, neighbor );
				frontier.add( node );
				visited.add( neighbor );
			}
		}
		return [];
	}

	static function getNeighbors( pos:Pos, grid:Array<Array<String>>, positions:Array<Array<Pos>> ) {
		final minX = max( 0, pos.x - 1 );
		final maxX = min( grid[pos.y].length - 1, pos.x + 1 );
		final minY = max( 0, pos.y - 1 );
		final maxY = min( grid.length - 1, pos.y + 1 );
		
		final neighbors = [for( ny in minY...maxY + 1 ) for( nx in minX...maxX + 1 ) if( nx != pos.x || ny != pos.y ) positions[ny][nx]];
		
		return neighbors;
	}
	static function validateNeighbor( pos:Pos, neighbor:Pos, grid:Array<Array<String>>, visited:Set<Pos> ) {
		// trace( 'visited ${visited.contains( neighbor )}' );
		if( visited.contains( neighbor )) return false;

		final x = pos.x;
		final y = pos.y;


		// horizontal or vertical neighbor
		if( neighbor.x == x || neighbor.y == y ) {
			// trace( 'horizontal or vertical neighbor ${grid[neighbor.y][neighbor.x] != "^"}' );
			return grid[neighbor.y][neighbor.x] != "^";
		}
		
		// diagonal neighbor
		final isMountainNeighbor = grid[neighbor.y][neighbor.x] == "^";
		// trace( 'isMountainNeighbor ${isMountainNeighbor}' );
		if( isMountainNeighbor ) return false;

		final isHorizontalMountain = grid[y][neighbor.x] == "^";
		final isVerticalMountain = grid[neighbor.y][x] == "^";
		// trace( 'isHorizontalMountain ${isHorizontalMountain}, isVerticalMountain ${isVerticalMountain}' );

		if( isHorizontalMountain && isVerticalMountain ) return false;

		return true;
	}

	static function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
	static function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;

	static function backtrack( goalNode:Node ) {
		final path = new List<Pos>();
		var current = goalNode;
		while( current.pos != Pos.NO_POS ) {
			path.add( current.pos );
			current = current.previous;
		}
		
		final aPath = Lambda.array( path );
		aPath.reverse();
		// for( pos in aPath ) printErr( '$pos' );
		return aPath;
	}
}