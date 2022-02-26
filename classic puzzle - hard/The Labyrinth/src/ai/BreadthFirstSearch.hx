package ai;

import data.PathNode;
import data.TCell;

using Lambda;

class BreadthFirstSearch {
	
	public static function getPath( nodes:Map<Int, PathNode>, start:Int, destinationCell:TCell ) {
		
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			// CodinGame.printErr( 'current $current' );
			for( next in nodes[current].neighbors ) {
				// CodinGame.printErr( 'check $next' );
				final nextNode = nodes[next];
				if( !nextNode.visited ) {
					nextNode.previous = current;
					nextNode.visited = true;
					frontier.add( next );
					if( nextNode.cell == destinationCell ) {
						// CodinGame.printErr( 'found goal' );
						return backtrack( nodes, start, nextNode.id );
					}
				}
			}
		}
		return [];
	}

	static function backtrack( nodes:Map<Int, PathNode>, start:Int, goal:Int ) {
		final path = new List<Int>();
		var i = goal;
		while( i != start ) {
			path.add( i );
			i = nodes[i].previous;
		}
		path.add( start );
		final aPath = Lambda.array( path );
		aPath.reverse();
		return aPath;
	}
}