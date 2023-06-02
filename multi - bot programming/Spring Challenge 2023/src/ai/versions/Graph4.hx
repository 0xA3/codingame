package ai.versions;

import CodinGame.printErr;
import ai.data.Edge;
import haxe.ds.GenericStack;

class Graph4 {
	
	final verticesSet:Map<Int, Bool>;
	final edgesSet:Map<String, Edge>;
	final edges:Array<Edge> = [];
	
	public function new( verticesSet:Map<Int, Bool>, edgesSet:Map<String, Edge> ) {
		this.verticesSet = verticesSet;
		this.edgesSet = edgesSet;
		initEdges();
	}

	public function createMinimumSpanningTree() {
		edges.sort(( a, b ) -> a.distance - b.distance );
		for( edge in edges ) printErr( '${edge.start}-${edge.end} distance: ${edge.distance}' );
	}

	public function removeVertex( vertex:Int ) {
		verticesSet.remove( vertex );
		
		final removeList = new GenericStack<String>();
		for( id => edge in edgesSet ) {
			if( edge.start == vertex || edge.end == vertex ) removeList.add( id );
		}
		for( id in removeList ) edgesSet.remove( id );
		initEdges();
	}

	function initEdges() {
		edges.splice( 0, edges.length );
		for( edge in edgesSet ) edges.push( edge );
	}
}
