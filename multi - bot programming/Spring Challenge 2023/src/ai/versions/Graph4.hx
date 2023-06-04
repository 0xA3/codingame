package ai.versions;

import CodinGame.printErr;
import ai.algorithm.KruskalsMST;
import ai.data.Edge;
import haxe.ds.ArraySort;
import haxe.ds.GenericStack;

class Graph4 {
	
	final verticesSet:Map<Int, Bool>;
	final edgesSet:Map<String, Edge>;
	
	public var mstEdges:Array<Edge> = [];
	public var needsUpdate = true;

	var numVertices:Int;
	var numCells:Int;

	public function new( verticesSet:Map<Int, Bool>, edgesSet:Map<String, Edge>, numVertices:Int, numCells:Int ) {
		this.verticesSet = verticesSet;
		this.edgesSet = edgesSet;

		this.numVertices = numVertices;
		this.numCells = numCells;
	}

	public function removeVertex( vertex:Int ) {
		if( !verticesSet.exists( vertex )) return;
		
		verticesSet.remove( vertex );
		numVertices--;
		
		final removeList = new GenericStack<String>();
		for( id => edge in edgesSet ) {
			if( edge.start == vertex || edge.end == vertex ) removeList.add( id );
		}
		for( id in removeList ) edgesSet.remove( id );
		
		needsUpdate = true;
	}

	public function createMinimumSpanningTree( minDistances:Map<Int, Int> ) {
		final edges = [for( edge in edgesSet ) edge ];
		edges.sort(( a, b ) -> a.distance - b.distance );

		mstEdges = KruskalsMST.create( numCells, numVertices, edges );
		
		haxe.ds.ArraySort.sort(mstEdges, ( a, b ) -> { // sort edges by minDistance from bases
			if( minDistances[a.start] < minDistances[b.start] ) return -1;
			if( minDistances[a.start] > minDistances[b.start] ) return 1;
			return 0;
		});
		
		// for( edge in mstEdges ) printErr( '${edge.start}-${edge.end} distance: ${edge.distance}' );
		needsUpdate = false;
	}
}
