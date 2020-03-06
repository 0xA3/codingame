using Lambda;

class UniformCostSearch { // Dijkstra’s Algorithm
	
	public static function getPath( nodes:Array<PathNode>, start:Int, goal:Int ) {
		
		final frontier = new MinPriorityQueue<PathNode>( PathNode.compare );
		
		final startNode = nodes[start];
		startNode.visited = true;
		startNode.costFromStart = 0;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			// CodinGame.printErr( 'current $current' );
			for( edge in currentNode.neighbors ) {
				final next = edge.to;
				// CodinGame.printErr( 'check $next' );
				final nextNode = nodes[edge.to];
				final nextCost = currentNode.costFromStart + nextNode.costFromStart;
				if( !nextNode.visited ) {
					nextNode.previous = current;
					nextNode.visited = true;
					nextNode.costFromStart = nextCost;
					frontier.add( nextNode );
					if( next == goal ) {
						// CodinGame.printErr( 'found goal' );
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