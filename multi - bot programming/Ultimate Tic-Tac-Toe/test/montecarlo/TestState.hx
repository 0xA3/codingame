package test.montecarlo;

import mcts.montecarlo.State;
import mcts.tictactoe.BitBoard;
import mcts.tictactoe.Board;

using buddy.Should;

class TestState extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test State", {
			
			it( "Test createEmpty", {
				final state = State.create( 1, BitBoard.create() );
				state.board.should.not.be( null );
				state.player.should.be( 1 );
				state.visitCount.should.be( 0 );
				state.winScore.should.be( 0 );
			});
			
			it( "Test getOpponent", {
				final state = State.create( 1, BitBoard.create() );
				state.getOpponent().should.be( 2 );
			});
		});
	}
}