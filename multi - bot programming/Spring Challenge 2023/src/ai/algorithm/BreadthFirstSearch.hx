package ai.algorithm;

import CodinGame.printErr;
import ai.data.CellDataset;
import ai.data.CellDistance;
import ai.data.Node;

using Lambda;

class BreadthFirstSearch {
	
	public static function getCellDistances( cells:Array<CellDataset>, start:Int ) {
		final nodes = [for( _ in cells ) new Node()];
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		final resourceCellDistances:Array<CellDistance> = [];
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			if( cells[current].resources > 0 ) {
				final distance = getDistance( nodes, start, current );
				final cellDistance:CellDistance = { start: start, end: current, distance: distance }
				printErr( cellDistance );
				resourceCellDistances.push( cellDistance );
			}
			// trace( 'current $current' );
			for( neighbor in cells[current].neighbors ) {
				// trace( 'check $next' );
				final nextNode = nodes[neighbor];
				if( !nextNode.visited ) {
					nextNode.previous = current;
					nextNode.visited = true;
					frontier.add( neighbor );
				}
			}
		}
		return resourceCellDistances;
	}

	static function getDistance( nodes:Array<Node>, start:Int, end:Int ) {
		var distance = 0;
		var i = end;
		while( i != start ) {
			i = nodes[i].previous;
			distance++;
		}
		return distance;
	}
}