import Path.Edge;
using Lambda;

class UniformCostSearch { // Dijkstra’s Algorithm
	
	public static function getShortestPathsBetweenNodes( nodes:Array<PathNode> ) {
		final pathNodes:Array<Array<PathNode>> = [];
		for( i in 0...nodes.length ) {
			pathNodes.push( getPaths( nodes, i ));
		}
		return backtrackAll( pathNodes );
	}

	public static function getPaths( incomingNodes:Array<PathNode>, start:Int ) {
		
		final nodes = incomingNodes.map( n -> n.copy());

		final frontier = new MinPriorityQueue<PathNode>( PathNode.compareCostAndSteps );
		
		final startNode = nodes[start];
		startNode.visited = true;
		startNode.costFromStart = 0;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			
			// if( start == 0 ) CodinGame.printErr( 'current ${currentNode.id}' );
			for( edge in currentNode.neighbors ) {
				final nextNode = nodes[edge.id];
				final nextCost = currentNode.costFromStart + edge.cost;
				final intermediates = currentNode.intermediates + 1;
				// if( start == 0 ) CodinGame.printErr( 'next ${nextNode.id} visited ${nextNode.visited}' );
				// if( start == 0 ) CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} cost $nextCost' );
					// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} cost $nextCost' + ( nextNode.visited ? '  <  ${nextNode.previous}-${nextNode.id} cost ${nextNode.costFromStart}' : "" ));
				
				if( nextCost < nextNode.costFromStart ) {
					nextNode.previous = currentNode.id;
					nextNode.costToPrevious = edge.cost;
					nextNode.costFromStart = nextCost;
					nextNode.intermediates = intermediates;
					if( !nextNode.visited ) {
						frontier.add( nextNode );
					} else {
						frontier.sort();
					}
					nextNode.visited = true;
					// if( start == 0 ) CodinGame.printErr( 'frontier $frontier' );
				}
			}
		}

		return nodes;
	}

	public static function backtrackAll( paths:Array<Array<PathNode>> ) {
		final path:Map<String, Path>= [];
		for( i in 0...paths.length ) {
			final nodes = paths[i];
			for( node in nodes ) {
				if( node.id != i ) {
					final goal = node.id;
					final edges = backtrack( nodes, i, goal );
					final length = edges.fold(( edge, sum ) -> sum + edge.cost, 0.0 ) + edges.length - 1;
					
					path.set( '${i}-${goal}', new Path( edges, length ));
				}
			}
		}
		return path;
	}

	static function backtrack( nodes:Array<PathNode>, start:Int, goal:Int ) {
		final path = new List<Edge>();
		var i = goal;
		while( i != start ) {
			final from = nodes[i].previous;
			final to = i;
			path.add({ from: from, to: to, cost: nodes[i].costToPrevious });
			i = nodes[i].previous;
		}
		// path.add( start );
		final aPath = Lambda.array( path );
		aPath.reverse();
		// CodinGame.printErr( '${start}-${goal}: ' + aPath.map( edge -> '${edge.from}-${edge.to} cost ${edge.cost}' ).join(", "));
		return aPath;
	}
}

