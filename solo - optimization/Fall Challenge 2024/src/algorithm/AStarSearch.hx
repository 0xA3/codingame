package algorithm;

import data.PathNode;

using Lambda;

class AStarSearch {
	
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
			outputs.add( [currentNode.id, Std.int( currentNode.priority )] );
			if( currentNode.id == goal ) {
				// CodinGame.printErr( 'found goal' );
				// return backtrack( nodes, start, goal );
				return Lambda.array( outputs );
			}
			
			// CodinGame.printErr( 'current ${currentNode.id}' );
			for( i in 0...currentNode.neighbors.length ) {
				final edge = currentNode.neighbors[i];
				final nextNode = nodes[currentNode.neighborIds[i]];
				final nextCost = currentNode.costFromStart + 1;
				final nextPriority = nextCost + nextNode.distanceToGoal;
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} priority $nextPriority' + ( nextNode.visited ? '  <  ${nextNode.previous}-${nextNode.id} priority ${nextNode.priority}' : "" ));
				
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
		final path = new List<Array<Int>>();
		var i = goal;
		while( i != start ) {
			path.add( [i, Std.int( nodes[i].priority )]);
			i = nodes[i].previous;
		}
		path.add( [i, Std.int( nodes[i].priority )] );
		final aPath = Lambda.array( path );
		aPath.reverse();
		// CodinGame.printErr( aPath );
		return aPath;
	}
}