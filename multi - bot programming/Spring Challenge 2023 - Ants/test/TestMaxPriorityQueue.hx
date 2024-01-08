package test;

import ai.algorithm.GetPaths.PathNode;
import ai.algorithm.MaxPriorityQueue;

using StringTools;
using buddy.Should;

class TestMaxPriorityQueue extends buddy.BuddySuite {

	public function new() {
		describe( "Test TestMaxPriorityQueue", {
			it( "3 ints", {
				final queue = new MaxPriorityQueue<Int>(( a, b ) -> a < b ? false : true );
				queue.add( 1 );
				queue.add( 3 );
				queue.add( 2 );
				queue.pop().should.be( 3 );
				queue.pop().should.be( 2 );
			});
			
			it( "4 ints 1 later added", {
				final queue = new MaxPriorityQueue<Int>(( a, b ) -> a < b ? false : true );
				queue.add( 1 );
				queue.add( 5 );
				queue.add( 4 );
				queue.pop().should.be( 5 );
				queue.add( 3 );
				queue.pop().should.be( 4 );
			});
			
			it( "3 nodes with different distances", {
				final queue = new MaxPriorityQueue<PathNode>( PathNode.compare );
				final node1:PathNode = {id: 1, distanceFromStart: 1}
				final node2:PathNode = {id: 2, distanceFromStart: 2}
				final node3:PathNode = {id: 3, distanceFromStart: 3}
				queue.add( node1 );
				queue.add( node3 );
				queue.add( node2 );
				queue.pop().should.be( node1 );
				queue.pop().should.be( node2 );
			});
			
			it( "3 nodes with different resources", {
				final queue = new MaxPriorityQueue<PathNode>( PathNode.compare );
				final node1:PathNode = {id: 1, resourcesFromStart: 1}
				final node2:PathNode = {id: 2, resourcesFromStart: 2}
				final node3:PathNode = {id: 3, resourcesFromStart: 3}
				queue.add( node1 );
				queue.add( node3 );
				queue.add( node2 );
				queue.pop().should.be( node3 );
				queue.pop().should.be( node2 );
			});
			
			it( "4 nodes with different distances and resources", {
				final queue = new MaxPriorityQueue<PathNode>( PathNode.compare );
				final node1:PathNode = {id: 1, distanceFromStart: 1, resourcesFromStart: 1}
				final node2:PathNode = {id: 2, distanceFromStart: 2, resourcesFromStart: 2}
				final node3:PathNode = {id: 3, distanceFromStart: 2, resourcesFromStart: 3}
				final node4:PathNode = {id: 4, distanceFromStart: 3, resourcesFromStart: 1}
				queue.add( node4 );
				queue.add( node3 );
				queue.add( node1 );
				queue.add( node2 );
				queue.pop().should.be( node1 );
				queue.pop().should.be( node3 );
			});
		});
	}
}
