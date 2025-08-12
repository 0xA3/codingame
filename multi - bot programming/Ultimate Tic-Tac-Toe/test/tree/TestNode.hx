package test.tree;

import mcts.montecarlo.State;
import mcts.tictactoe.BitBoard;
import mcts.tree.Node;

using buddy.Should;

class TestNode extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Node", {
			
			it( "Test createEmpty", {
				final node = Node.create( State.create( 1, BitBoard.create() ));
				node.state.should.not.be( null );
				node.parent.should.be( Node.NO_NODE );
				node.children.length.should.be( 0 );
			});
			
			it( "Test fromState", {
				final state = State.create( 1, BitBoard.create() );
				final node = Node.fromState( state );
				node.state.should.be( state );
				node.parent.should.be( Node.NO_NODE );
				node.children.length.should.be( 0 );
			});
			
			it( "Test getRandomChildNode", {
				final childNode1 = Node.create( State.create( 1, BitBoard.create() ));
				final childNode2 = Node.create( State.create( 1, BitBoard.create() ));
				final node = Node.create( State.create( 1, BitBoard.create() ));
				node.children.push( childNode1 );
				node.children.push( childNode2 );

				final randomChildNode = node.getRandomChildNode();
				final isOneOfChildnodes = randomChildNode == childNode1 || randomChildNode == childNode2;

				isOneOfChildnodes.should.be( true );
			});

			it( "Test getChildWithMaxScore", {
				final childNode1 = Node.create( State.create( 1, BitBoard.create() ));
				final childNode2 = Node.create( State.create( 1, BitBoard.create() ));
				final childNode3 = Node.create( State.create( 1, BitBoard.create() ));

				childNode1.state.visitCount = 1;
				childNode2.state.visitCount = 3;
				childNode3.state.visitCount = 2;

				final node = Node.create( State.create( 1, BitBoard.create() ));
				node.children.push( childNode1 );
				node.children.push( childNode2 );
				node.children.push( childNode3 );

				final maxScoreChildNode = node.getChildWithMaxScore();

				maxScoreChildNode.state.visitCount.should.be( 3 );
			});
			
		});

	}
}