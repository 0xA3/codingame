package test.montecarlo;

import mcts.montecarlo.Integer;
import mcts.montecarlo.UCT;
import mcts.tree.Node;
using buddy.Should;

class TestUCT extends buddy.BuddySuite {
	
	public function new() {
	
		describe( "Test uctValue", {
			
			it( "Test uctValue nodeVisit 0", {
				UCT.uctValue( 0, 0, 0 ).should.be( Integer.MAX_VALUE );
			});
			
			it( "Test uctValue totalVisit 1 nodeVisit 1", {
				UCT.uctValue( 1, 0, 1 ).should.be( 0 );
			});
			
			it( "Test uctValue totalVisit 2 nodeVisit 2", {
				UCT.uctValue( 2, 0, 2 ).should.beCloseTo( 0.83 );
			});
			
			it( "Test uctValue totalVisit 2 nodeWinScore 0.5 nodeVisit 2", {
				UCT.uctValue( 2, 0.5, 2 ).should.beCloseTo( 1.08 );
			});
			
			it( "Test findBestNodeWithUCT", {
				final node = Node.createEmpty();

				final childNode1 = Node.createEmpty();
				final childNode2 = Node.createEmpty();
			});
			
		});

		describe( "Test findBestNodeWithUCT", {
			
			it( "Test uctValue nodeVisit 0", {
				final node = Node.createEmpty();
				node.state.visitCount = 3;

				final child1 = Node.createEmpty();
				child1.state.visitCount = 2;
				
				final child2 = Node.createEmpty();
				child2.state.visitCount = 2;
				child2.state.winScore = 0.5;

				node.childArray.push( child1 );
				node.childArray.push( child2 );

				final bestNode = UCT.findBestNodeWithUCT( node );
				bestNode.state.winScore.should.be( 0.5 );
				
			});
			
		});

	}
}