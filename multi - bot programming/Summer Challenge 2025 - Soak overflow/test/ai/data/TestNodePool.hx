package test.ai.data;

import ai.data.Cell;
import ai.data.Node;
import ai.data.NodePool;

using buddy.Should;

class TestNodePool extends buddy.BuddySuite {

	public function new() {
		
		describe( "Test NodePool get", {
			
			it( "get from empty NodePool", {
				final nodePool = new NodePool();
				final node = nodePool.get( 0, Cell.NO_CELL, 0 );
				nodePool.add( node );
				nodePool.length.should.be( 1 );
			});
			
			it( "get 2 Elements from NodePool", {
				final nodePool = new NodePool();
				for( i in 0...2 ) {
					final node = nodePool.get( 0, Cell.NO_CELL, 0 );
					nodePool.add( node );
				}
				nodePool.length.should.be( 1 );
			});
		});
		
	}
}
