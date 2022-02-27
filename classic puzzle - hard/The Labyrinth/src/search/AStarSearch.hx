package search;

using Lambda;

class AStarSearch { // Dijkstra’s Algorithm
	
	public static function getPath( nodes:Array<PathNode>, start:Int, goal:Int ) {
		
		final outputs = new List<Array<Int>>();
		final frontier = new MinPriorityQueue<PathNode>( PathNode.comparePriorityAndId );
		
		final startNode = nodes[start];
		startNode.visited = true;
		startNode.costFromStart = 0;
		startNode.priority = startNode.distanceToGoal;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			// if( goal == 7 ) trace( 'currentNode ${currentNode.id} neighbors ${currentNode.neighbors}' );
			outputs.add( [currentNode.id, currentNode.priority] );
			if( currentNode.id == goal ) {
				// CodinGame.printErr( 'found goal' );
				return backtrack( nodes, start, goal );
			}
			
			// CodinGame.printErr( 'current ${currentNode.id}' );
			for( neighborIndex in currentNode.neighbors ) {
				final nextNode = nodes[neighborIndex];
				final nextCost = currentNode.costFromStart + 1;
				final nextPriority = nextCost + nextNode.distanceToGoal;
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} nextCost $nextCost  nextPriority $nextPriority' );
				
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
		// final path = new List<Array<Int>>();
		final path = new List<Int>();
		var i = goal;
		while( i != start ) {
			// path.add( [i, nodes[i].priority] );
			path.add( i );
			i = nodes[i].previous;
		}
		// path.add( [goal, Std.int( nodes[i].priority )] );
		final aPath = Lambda.array( path );
		aPath.reverse();
		return aPath;
	}
}