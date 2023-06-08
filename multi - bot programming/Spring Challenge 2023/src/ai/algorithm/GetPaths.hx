package ai.algorithm;

import ai.data.CellDataset;
import ai.data.Node;
import haxe.ds.Vector;

class GetPaths {
	
	public static function get( cells:Array<CellDataset> ) {
		final nodes = [for( _ in cells ) Node.getNew()];
		
		final paths = new Vector<Array<Int>>( cells.length * cells.length );
		for( start in 0...cells.length ) {
			getPaths( cells, nodes, paths, start, cells.length );

		}
		return paths.toArray();
	}
	
	static function getPaths( cells:Array<CellDataset>, nodes:Array<Node>, paths:Vector<Array<Int>>, start:Int, width:Int ) {
		for( node in nodes ) node.reset();
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			final index = current + start * width;
			final path = backtrack( nodes, start, current );
			paths[index] = path;

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

	static function backtrack( nodes:Array<Node>, start:Int, end:Int ) {
		final path = new List<Int>();
		var i = end;
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
