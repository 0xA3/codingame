package test.tree;

import mcts.montecarlo.State;
import mcts.montecarlo.StatePool;
import mcts.tictactoe.BitBoard;
import mcts.tree.Node;
import mcts.tree.NodePool;

using buddy.Should;

class TestNodePool extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test NodePool recycle", {
			
			it( "Test create and recycle", {
				final statePool = new StatePool();
				final nodePool = new NodePool( statePool );
				
				final node = nodePool.get( statePool.get( 1, BitBoard.create() ));
				nodePool.recycle( node );
				nodePool.length.should.be( 1 );
			});
			
			it( "Test create chain", {
				final statePool = new StatePool();
				final nodePool = new NodePool( statePool );
				
				final node1 = nodePool.get( statePool.get( 1, BitBoard.create() ));
				final node2 = nodePool.get( statePool.get( 1, BitBoard.create() ), node1 );
				final node3 = nodePool.get( statePool.get( 1, BitBoard.create() ), node2 );
				
				node1.children.push( node2 );
				node2.children.push( node3 );

				nodePool.recycle( node3 );
				nodePool.length.should.be( 1 );
				
				node3.parent.should.be( Node.NO_NODE );
				node2.children.length.should.be( 0 );
			});
		});
		
		describe( "Test NodePool recycleBranch", {
			
			it( "Test create chain", {
				final statePool = new StatePool();
				final nodePool = new NodePool( statePool );
				
				final node1 = nodePool.get( statePool.get( 1, BitBoard.create() ));
				final node2 = nodePool.get( statePool.get( 1, BitBoard.create() ));
				final node3 = nodePool.get( statePool.get( 1, BitBoard.create() ));
				
				node1.children.push( node2 );
				node2.children.push( node3 );

				nodePool.recycleBranch( node1 );
				nodePool.length.should.be( 3 );
				
				node1.parent.should.be( Node.NO_NODE );
				node2.parent.should.be( Node.NO_NODE );
				node3.parent.should.be( Node.NO_NODE );
				
				node1.children.length.should.be( 0 );
				node2.children.length.should.be( 0 );
			});
			
			it( "Test create branches", {
				final statePool = new StatePool();
				final nodePool = new NodePool( statePool );
				
				final node1 = nodePool.get( statePool.get( 1, BitBoard.create() ));
				final node11 = nodePool.get( statePool.get( 1, BitBoard.create() ), node1 );
				final node111 = nodePool.get( statePool.get( 1, BitBoard.create() ), node11 );
				final node12 = nodePool.get( statePool.get( 1, BitBoard.create() ), node1 );
				
				node1.children.push( node11 );
				node1.children.push( node12 );
				node11.children.push( node111 );

				nodePool.recycleBranch( node11 );
				nodePool.length.should.be( 2 );
				
				node1.children.length.should.be( 1 );
				
				node11.parent.should.be( Node.NO_NODE );
				node12.parent.should.be( node1 );
				node111.parent.should.be( Node.NO_NODE );

				node11.children.length.should.be( 0 );
			});
			
		});

	}
}