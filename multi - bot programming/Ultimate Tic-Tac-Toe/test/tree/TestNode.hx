package test.tree;

import mcts.montecarlo.State;
import mcts.tree.Node;
using buddy.Should;

class TestNode extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Node", {
			
			it( "Test createEmpty", {
				final node = Node.createEmpty();
				node.state.should.not.be( null );
				node.parent.should.be( null );
				node.childArray.length.should.be( 0 );
			});
			
			it( "Test fromState", {
				final state = State.createEmpty();
				final node = Node.fromState( state );
				node.state.should.be( state );
				node.parent.should.be( null );
				node.childArray.length.should.be( 0 );
			});
			
			it( "Test fromNode", {
				final node1 = Node.createEmpty();
				final node2 = Node.fromNode( node1 );
				node1.state.should.not.be( node2.state );
				node2.parent.should.be( null );
				node2.childArray.length.should.be( node1.childArray.length );
			});

			it( "Test getRandomChildNode", {
				final childNode1 = Node.createEmpty();
				final childNode2 = Node.createEmpty();
				final node = Node.createEmpty();
				node.childArray.push( childNode1 );
				node.childArray.push( childNode2 );

				final randomChildNode = node.getRandomChildNode();
				final isOneOfChildnodes = randomChildNode == childNode1 || randomChildNode == childNode2;

				isOneOfChildnodes.should.be( true );
			});

			it( "Test getChildWithMaxScore", {
				final childNode1 = Node.createEmpty();
				final childNode2 = Node.createEmpty();
				final childNode3 = Node.createEmpty();

				childNode1.state.visitCount = 1;
				childNode2.state.visitCount = 3;
				childNode3.state.visitCount = 2;

				final node = Node.createEmpty();
				node.childArray.push( childNode1 );
				node.childArray.push( childNode2 );
				node.childArray.push( childNode3 );

				final maxScoreChildNode = node.getChildWithMaxScore();

				maxScoreChildNode.state.visitCount.should.be( 3 );
			});
			
		});

	}
}