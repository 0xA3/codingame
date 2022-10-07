import haxe.ds.GenericStack;

class DepthFirstSearch {
	
	public static function search( root:Node ) {
		
		final frontier = new MaxPriorityQueue<Node>( sortNodes );
		
		frontier.insert( root );

		while( !frontier.isEmpty()) {
			final current = frontier.delMax();
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

	static function sortNodes( a:Node, b:Node ) {
		if( a.state.x < b.state.x ) return true;
		if( a.state.x > b.state.x ) return false;
		
		if( a.state.alive < b.state.alive ) return true;
		else return false;
	}

	static function backtrack( nodes:Array<Node>, start:Int, goal:Int ) {
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