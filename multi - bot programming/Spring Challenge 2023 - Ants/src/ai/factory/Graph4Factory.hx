package ai.factory;

import CodinGame.printErr;
import ai.data.CellDataset;
import ai.data.Edge;
import ai.data.Node;
import ai.versions.Graph4;

class Graph4Factory {
	
	public static function create( baseIndices:Array<Int>, cells:Array<CellDataset>, minDistances:Map<Int, Int> ) {
		final nodes = [for( _ in cells ) Node.getNew()];
		final vertices = [for( i in 0...cells.length ) if( baseIndices.contains( i ) || cells[i].resources > 0 ) i];
		final verticesSet = [for( vertex in vertices ) vertex => true];
		
		vertices.sort(( a, b ) -> { // sort vertices by minDistance from bases
			if( minDistances[a] < minDistances[b] ) return -1;
			if( minDistances[a] > minDistances[b] ) return 1;
			return 0;
		});
		
		// printErr( vertices );
		
		final edgesSet:Map<String, Edge> = [];
		for( v1 in 0...vertices.length - 1 ) {
			final start = vertices[v1];
			
			final targets:Map<Int, Bool> = [];
			for( v2 in v1 + 1...vertices.length ) {
				final end = vertices[v2];
				if( !baseIndices.contains( start ) || !baseIndices.contains( end ) ) {
					targets.set( vertices[v2], true );
				}
			}
			
			final edges = getEdges( cells,  nodes, targets, start );
			for( edge in edges) {
				final id1 = '${edge.start}-${edge.end}';
				edgesSet.set( id1, edge );
				// printErr( '$id1 - distance ${edge.distance}' );
			}
		}

		return new Graph4( verticesSet, edgesSet, vertices.length, cells.length );
	}

	static function getEdges( cells:Array<CellDataset>, nodes:Array<Node>, targets:Map<Int, Bool>, start:Int ) {
		for( node in nodes ) node.reset();
		
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		final edges:Array<Edge> = [];
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			if( targets.exists( current ) ) {
				final distance = getDistance( nodes, start, current );
				final edge:Edge = { start: start, end: current, distance: distance }
				
				edges.push( edge );
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
		return edges;
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
