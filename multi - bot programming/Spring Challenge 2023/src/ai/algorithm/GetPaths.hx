package ai.algorithm;

import ai.data.CellDataset;
import ai.data.PathDataset;
import haxe.ds.Vector;

class GetPaths {
	
	public static function get( cells:Array<CellDataset> ) {
		final pathNodes = [for( i in 0...cells.length ) PathNode.getNew( i )];
		
		final paths = new Vector<Array<Int>>( cells.length * cells.length );
		for( start in 0...cells.length ) dijkstra( cells, pathNodes, paths, start );

		return paths.toArray();
	}
	
	static function dijkstra( cells:Array<CellDataset>, pathNodes:Array<PathNode>, paths:Vector<Array<Int>>, start:Int ) {
		
		for( node in pathNodes ) node.reset();
		final frontier = new MaxPriorityQueue<PathNode>( PathNode.compare );

		final startNode = pathNodes[start];
		startNode.visited = true;
		startNode.resourcesFromStart = cells[start].resources;
		frontier.add( startNode );

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentId = currentNode.id;
			final index = PathDataset.getPathIndex( start, currentId, cells.length );
			
			final path = backtrack( pathNodes, start, currentId );
			// trace( '${path[0]}-${path[path.length - 1]} length ${path.length - 1} $path' );
			paths[index] = path;

			for( neighbor in cells[currentId].neighbors ) {
				final nextNode = pathNodes[neighbor];
				final nextCell = cells[neighbor];
				final nextDistance = currentNode.distanceFromStart + 1;
				final nextResources = currentNode.resourcesFromStart + nextCell.resources;

				// trace( 'neighbor $neighbor  nextCost $nextCost  nextNode.costFromStart ${nextNode.costFromStart}' );
				if( !nextNode.visited ) {
					nextNode.previous = currentNode.id;
					nextNode.distanceFromStart = nextDistance;
					nextNode.resourcesFromStart = nextResources;
					frontier.add( nextNode );
					// else frontier.sort();
					
					nextNode.visited = true;
				}
			}
		}
	}

	static function backtrack( pathNodes:Array<PathNode>, start:Int, end:Int ) {
		final path = new List<Int>();
		var i = end;
		while( i != start ) {
			path.add( i );
			i = pathNodes[i].previous;
		}
		path.add( start );
		final aPath = Lambda.array( path );
		aPath.reverse();
		return aPath;
	}
}

@:structInit class PathNode {
	
	public static final NO_PATHNODE:PathNode = { id: -1 }
	
	public final id:Int;
	public var previous = -1;
	public var visited = false;
	public var distanceFromStart = 0;
	public var resourcesFromStart = 0;

	public static function getNew( id:Int ) {
		final node:PathNode = { id: id}
		return node;
	}

	public function reset() {
		previous = -1;
		visited = false;
		distanceFromStart = 0;
		resourcesFromStart = 0;
	}

	public static function compare( a:PathNode, b:PathNode ) { // return min of distances and max of resources
		if( a.distanceFromStart < b.distanceFromStart ) return true;
		if( a.distanceFromStart > b.distanceFromStart ) return false;
		return a.resourcesFromStart < b.resourcesFromStart ? false : true;
	}
}