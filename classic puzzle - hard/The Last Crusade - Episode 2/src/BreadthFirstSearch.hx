using Lambda;

class BreadthFirstSearch {
	
	public static function getPaths( nodes:Array<PathNode>, start:Int, goal:Int ) {
		
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

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

	static function backtrack( nodes:Array<PathNode>, start:Int, goal:Int ) {
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