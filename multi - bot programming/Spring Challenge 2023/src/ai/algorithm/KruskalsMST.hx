package ai.algorithm;

import CodinGame.printErr;
import ai.data.Edge;
import ai.data.Subset;
import haxe.ds.Vector;

class KruskalsMST {
	
	public static function create( numCells:Int, numVertices:Int, edges:Array<Edge> ) {

		// Allocate memory for creating v subsets
		final subsets = new Vector<Subset>( numCells );

		// Allocate memory for results
		final results = new Vector<Edge>( numVertices - 1 );

		// Create v subsets with single elements
		for( i in 0...numCells ) {
			final subset:Subset = { parent: i, rank: 0 }
			subsets[i] = subset;
		}

		// Number of edges to be taken is equal to v-1
		var noOfEdges = 0;
		var j = 0;
		while( noOfEdges < numVertices - 1 ) {
			// Pick the smallest edge. And increment
			// the index for next iteration
			final nextEdge = edges[j];
			final x = findParent( subsets, nextEdge.start );
			final y = findParent( subsets, nextEdge.end );

			// If including this edge doesn't cause cycle,
			// include it in result and increment the index
			// of result for next edge
			if( x != y ) {
				results[noOfEdges] = nextEdge;
				union( subsets, x, y );
				noOfEdges++;
			}

			j++;
		}

		return results.toArray();
	}

	// Function to unite two disjoint sets
	static function union( subsets:Vector<Subset>, x:Int, y:Int ) {
		final rootX = findParent( subsets, x );
		final rootY = findParent( subsets, y );

		if( subsets[rootY].rank < subsets[rootX].rank ) subsets[rootY].parent = rootX;
		else if( subsets[rootX].rank < subsets[rootY].rank ) subsets[rootX].parent = rootY;
		else {
			subsets[rootY].parent = rootX;
			subsets[rootX].rank++;
		}
	}

	// Function to find parent of a set
	static function findParent( subsets:Vector<Subset>, i:Int ) {
		if( subsets[i].parent == i ) return subsets[i].parent;
		subsets[i].parent = findParent( subsets, subsets[i].parent );
		
		return subsets[i].parent;
	}
}