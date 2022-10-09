import CodinGame.printErr;

using Lambda;

class BreadthFirstSearch {
	
	public static function getPaths( nodes:Array<PathNode>, start:Int, goals:Array<Int> ) {
		
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		final paths = [];
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			// printErr( 'current $current' );
			for( neighbor in nodes[current].neighbors ) {
				final next = neighbor;
				// printErr( 'check $next' );
				final nextNode = nodes[neighbor];
				if( !nextNode.visited ) {
					nextNode.previous = current;
					nextNode.visited = true;
					frontier.add( next );
					for( goal in goals ) { if( goal == next ) {
						// printErr( 'found goal $goal' );
						paths.push( backtrack( nodes, start, goal ));
					}}
				}
			}
		}
		return paths;
	}

	static function backtrack( nodes:Array<PathNode>, start:Int, goal:Int ) {
		// printErr( 'backtrack $start $goal' );
		final path = new List<Int>();
		var i = goal;
		while( i != start ) {
			path.add( i );
			i = nodes[i].previous;
			// printErr( 'path add $i' );
		}
		path.add( start );
		// printErr( 'path add $start' );
		final aPath = Lambda.array( path );
		aPath.reverse();
		return aPath;
	}
}