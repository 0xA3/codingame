package ai.algorithm;

import ai.data.CellDataset;

class BreadthFirstSearch {
	
	public static function getDistances( cells:Array<CellDataset>, start:Int ) {
		final nodes:Array<Node> = [for( _ in cells ) {}];
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		final cellDistances:Map<Int, Int> = [];
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			cellDistances.set( current, nodes[current].distance );

			// trace( 'current $current' );
			for( neighbor in cells[current].neighbors ) {
				// trace( 'check $next' );
				final nextNode = nodes[neighbor];
				if( !nextNode.visited ) {
					nextNode.previous = current;
					nextNode.visited = true;
					nextNode.distance = nodes[current].distance + 1;
					frontier.add( neighbor );
				}
			}
		}
		return cellDistances;
	}
}

@:structInit class Node {
	public var previous = -1;
	public var visited = false;
	public var distance = 0;
}