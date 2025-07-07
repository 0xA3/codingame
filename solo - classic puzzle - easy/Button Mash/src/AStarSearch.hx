import CodinGame.printErr;
import Main.ButtonResult;
import ya.Set;

using Lambda;

class AStarSearch {
	
	public static function getPath( goal:Int, getNeighbors:(Int)->Array<ButtonResult> ) {
		trace( 'goal $goal' );
		final frontier = new MinPriorityQueue<PathNode>( PathNode.compareCostAndDistance );
		final visited = new Set<Int>();

		final startNode = new PathNode( "", 0, 0, goal );
		visited.add( startNode.value );
		// startNode.priority = startNode.distanceToGoal;
		frontier.add( startNode );

		var count = 0;
		while( !frontier.isEmpty()) {
		// while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			
			final spaces = [for(_ in 0...currentNode.costFromStart ) " "].join( "" );
			// printErr( '$spaces -> ${currentNode.value}: ${currentNode.button}' );
			
			if( currentNode.value == goal ) {
				// CodinGame.printErr( 'found goal' );
				return backtrack( currentNode );
			}
			
			final neighbors = getNeighbors( currentNode.value );

			// CodinGame.printErr( 'current ${currentNode.pos}' );
			for( neighbor in neighbors ) {
				if( neighbor.result <= 0 ) continue;

				final nextCost = currentNode.costFromStart + 1;
				final distanceToGoal = abs( goal - neighbor.result );
				// final nextPriority = nextCost + distanceToGoal;
				if( !visited.contains( neighbor.result ) ) {
					visited.add( neighbor.result );
					
					// printErr( '$spaces ${neighbor.button}: --  ${neighbor.result} -- distance: $distanceToGoal' );
					
					final nextNode = new PathNode( neighbor.button, neighbor.result, nextCost, distanceToGoal );
					nextNode.previous = currentNode;
					// nextNode.priority = nextPriority;
					
					frontier.add( nextNode );
					frontier.sort();
					// CodinGame.printErr( frontier );
				}
			}
		}
		return [];
	}
	
	static function backtrack( goalNode:PathNode ) {
		final path = new List<Int>();
		var current = goalNode;
		while( current.previous != PathNode.NO_NODE ) {
			path.add( current.value );
			current = current.previous;
		}
		
		path.add( current.previous.value ); // add start position

		final aPath = Lambda.array( path );
		aPath.reverse();
		// for( pos in aPath ) printErr( '$pos' );
		return aPath;
	}

	static function abs( v:Int ) return v < 0 ? -v : v;
}