package test.montecarlo;

import mcts.montecarlo.Integer;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.montecarlo.State;
import mcts.montecarlo.StatePool;
import mcts.tictactoe.BitBoard;
import mcts.tree.Node;
import mcts.tree.NodePool;

using buddy.Should;

@:access( mcts.montecarlo.MonteCarloTreeSearch )
class TestUCT extends buddy.BuddySuite {
	
	public function new() {
	
		final statePool = new StatePool();
		final mct = new MonteCarloTreeSearch( Node.NO_NODE, new NodePool( statePool ), statePool, 0 );

		describe( "Test uctValue", {
			
			it( "Test uctValue nodeVisit 0", {
				mct.uctValue( 0, 0, 0 ).should.be( Integer.MAX_VALUE );
			});
			
			it( "Test uctValue totalVisit 1 nodeVisit 1", {
				mct.uctValue( 1, 0, 1 ).should.be( 0 );
			});
			
			it( "Test uctValue totalVisit 2 nodeVisit 2", {
				mct.uctValue( 2, 0, 2 ).should.beCloseTo( 0.83 );
			});
			
			it( "Test uctValue totalVisit 2 nodeWinScore 0.5 nodeVisit 2", {
				mct.uctValue( 2, 0.5, 2 ).should.beCloseTo( 1.08 );
			});
		});

		describe( "Test findBestNodeWithUCT", {
			
			it( "Test uctValue nodeVisit 0", {
				final node = Node.create( State.create( 1, BitBoard.create() ));
				node.state.visitCount = 3;

				final child1 = Node.create( State.create( 1, BitBoard.create() ));
				child1.state.visitCount = 2;
				
				final child2 = Node.create( State.create( 1, BitBoard.create() ));
				child2.state.visitCount = 2;
				child2.state.winScore = 0.5;

				node.children.push( child1 );
				node.children.push( child2 );

				final bestNode = mct.findBestNodeWithUCT( node );
				bestNode.state.winScore.should.be( 0.5 );
			});
		});
	}
}