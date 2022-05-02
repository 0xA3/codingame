using Lambda;

class UniformCostSearch { // Dijkstra’s Algorithm
	
	public static function getPath( nodes:Array<PathNode>, start:Int, goal:Int ) {
		
		final frontier = new MinPriorityQueue<PathNode>( PathNode.compareCostFromStart );
		
		final startNode = nodes[start];
		startNode.visited = true;
		startNode.costFromStart = 0;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			if( currentNode.id == goal ) {
				// CodinGame.printErr( 'found goal' );
				return backtrack( nodes, start, goal );
			}
			
			// CodinGame.printErr( 'current ${currentNode.id}' );
			for( edge in currentNode.neighbors ) {
				final nextNode = nodes[edge.to];
				final nextCost = currentNode.costFromStart + edge.cost;
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} cost $nextCost' + ( nextNode.visited ? '  <  ${nextNode.previous}-${nextNode.id} cost ${nextNode.costFromStart}' : "" ));
				if( nextCost < nextNode.costFromStart ) {
					nextNode.previous = currentNode.id;
					nextNode.costFromStart = nextCost;
					if( !nextNode.visited ) {
						frontier.add( nextNode ); }
					else {
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
		final path = new List<Int>();
		var i = goal;
		while( i != start ) {
			path.add( i );
			i = nodes[i].previous;
		}
		path.add( start );
		final aPath = Lambda.array( path );
		aPath.reverse();
		// CodinGame.printErr( aPath );
		return aPath;
	}
}