package test.ai.data;

import ai.data.NodePool;

using buddy.Should;

class TestNodePool extends buddy.BuddySuite {

	public function new() {
		describe( "Test NodePool get", {
			
			it( "get from empty NodePool", {
				final nodePool = new NodePool();
				final node = nodePool.get();
				nodePool.length.should.be( 1 );
			});
			
			it( "get 2 Elements from NodePool", {
				final nodePool = new NodePool();
				final node1 = nodePool.get();
				final node2 = nodePool.get();
				nodePool.length.should.be( 2 );
			});
		});
		
		describe( "Test NodePool reset", {
			
			it( "reset empty NodePool", {
				final nodePool = new NodePool();
				nodePool.reset();
				nodePool.length.should.be( 0 );
			});
			
			it( "reset after getting one element", {
				final nodePool = new NodePool();
				final node1 = nodePool.get();
				nodePool.reset();
				nodePool.length.should.be( 1 );
			});
		});
		
		describe( "Test NodePool get after reset", {
			
			it( "reset after getting two elements", {
				final nodePool = new NodePool();
				final node1 = nodePool.get();
				final node2 = nodePool.get();
				nodePool.reset();
				nodePool.get().should.be( node1 );
			});
			
			it( "reset after getting three elements", {
				final nodePool = new NodePool();
				final node1 = nodePool.get();
				final node2 = nodePool.get();
				final node3 = nodePool.get();
				nodePool.reset();
				nodePool.get().should.be( node1 );
			});
		});
	}
}
