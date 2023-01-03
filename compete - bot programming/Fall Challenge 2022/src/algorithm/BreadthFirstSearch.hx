package algorithm;

import game.Coord;
import game.Tile;

using Lambda;

class BreadthFirstSearch {
	
	final coords:Array<Coord>;
	final tiles:Array<Tile>;
	final width:Int;

	public function new( coords:Array<Coord>, tiles:Array<Tile>, width:Int ) {
		this.coords = coords;
		this.tiles = tiles;
		this.width = width;
	}

	public function getPath( tiles:Array<Tile>, start:PathNode ) {
		
		final frontier = new List<PathNode>();
		
		frontier.add( start );
		start.visited = true;

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			// trace( 'current $current' );
			for( edge in nodes[current].neighbors ) {
				final next = edge.to;
				// trace( 'check $next' );
				final nextNode = nodes[edge.to];
				if( !nextNode.visited ) {
					nextNode.previous = current;
					nextNode.visited = true;
					frontier.add( next );
					if( next == goal ) {
						// trace( 'found goal' );
						return backtrack( nodes, start, goal );
					}
				}
			}
		}
		return [];
	}

	function backtrack( nodes:Array<PathNode>, start:Int, goal:Int ) {
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