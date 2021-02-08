using Lambda;

class UniformCostSearch { // Dijkstra’s Algorithm
	
	public static function getGoals( nodes:Array<PathNode>, start:Int ) {
		
		final goals = [];
		final frontier = new MaxPriorityQueue<PathNode>( PathNode.compareMoneyFromStart );
		
		final startNode = nodes[start];
		startNode.moneyFromStart = startNode.money;
		frontier.add( startNode );

		while( !frontier.isEmpty()) {
			final currentNode = frontier.pop();
			if( currentNode.neighbors.length < 2 ) {
				goals.push( currentNode );
				// CodinGame.printErr( 'found goal' );
			}
			
			// CodinGame.printErr( 'current ${currentNode.id}' );
			for( neighbor in currentNode.neighbors ) {
				final nextNode = nodes[neighbor];
				final nextMoney = currentNode.moneyFromStart + nextNode.money;
				// CodinGame.printErr( 'check ${currentNode.id}-${nextNode.id} nextMoney $nextMoney' );
				if( nextMoney > nextNode.moneyFromStart ) {
					nextNode.previous = currentNode.id;
					nextNode.moneyFromStart = nextMoney;
					frontier.add( nextNode ); //}
				}
			}
		}
		
		return goals;
	}

	// static function backtrack( nodes:Array<PathNode>, start:Int, goal:Int ) {
	// 	final path = new List<Int>();
	// 	var i = goal;
	// 	while( i != start ) {
	// 		path.add( i );
	// 		i = nodes[i].previous;
	// 	}
	// 	path.add( start );
	// 	final aPath = Lambda.array( path );
	// 	aPath.reverse();
	// 	// CodinGame.printErr( aPath );
	// 	return aPath;
	// }

}