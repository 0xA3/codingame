package ai.algorithm;

import ai.data.CellDataset;
import ai.data.Node;
import haxe.ds.Vector;

class GetDistances {
	
	public static function get( cells:Array<CellDataset> ) {
		final nodes = [for( _ in cells ) Node.getNew()];
		
		final distances = new Vector<Int>( cells.length * cells.length );
		for( start in 0...cells.length ) {
			getDistances( cells, nodes, distances, start, cells.length );

		}
		return distances.toArray();
	}
	
	static function getDistances( cells:Array<CellDataset>, nodes:Array<Node>, distances:Vector<Int>, start:Int, width:Int ) {
		for( node in nodes ) node.reset();
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			final index = current + start * width;
			distances[index] = nodes[current].distance;

			// trace( 'current $current' );
			for( neighbor in cells[current].neighbors ) {
				// trace( 'check $neighbor' );
				final nextNode = nodes[neighbor];
				if( !nextNode.visited ) {
					nextNode.previous = current;
					nextNode.visited = true;
					nextNode.distance = nodes[current].distance + 1;
					frontier.add( neighbor );
				}
			}
		}
	}
}
