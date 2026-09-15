package ai.algorithm;

import ai.data.Cell;
import xa3.math.Pos;

using Lambda;

class AStarSearch {
	
	public static function getPath( nodes:Array<PathNode>, start:Int, goal:Pos ) {
		final outputs = new List<PathNode>();
		final frontier = new MinPriorityQueue<PathNode>( PathNode.comparePriorityAndInstability );
		
		final startNode = nodes[start];
		startNode.visited = true;
		startNode.costFromStart = 0;
		startNode.priority = startNode.distanceToGoal;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			outputs.add( currentNode );
			if( currentNode.cell.pos == goal ) {
				// CodinGame.printErr( 'found goal' );
				// return backtrack( nodes, start, goal );
				return Lambda.array( outputs );
			}
			
			// CodinGame.printErr( 'current ${currentNode.id}' );
			for( edge in currentNode.neighbors ) {
				final nextNode = edge.to;
				final nextCost = currentNode.costFromStart + edge.cost;
				final nextPriority = nextCost + nextNode.distanceToGoal;
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} priority $nextPriority' + ( nextNode.visited ? '  <  ${nextNode.previous}-${nextNode.id} priority ${nextNode.priority}' : "" ));
				
				if( nextPriority < nextNode.priority ) {
					nextNode.previous = currentNode;
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

	static function backtrack( node:PathNode ) {
		final path = new List<Pos>();
		var tempNode = node;
		while( tempNode.previous != PathNode.NO_PATH_NODE ) {
			path.add( tempNode.cell.pos );
			tempNode = tempNode.previous;
		}
		path.add( tempNode.cell.pos );
		final aPath = Lambda.array( path );
		aPath.reverse();
		// CodinGame.printErr( aPath );
		return aPath;
	}
}