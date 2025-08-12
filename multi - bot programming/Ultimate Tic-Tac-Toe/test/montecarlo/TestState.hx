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

			it( "Test getAllPossibleStates", {
				// final board = Board.create( 2 );
				// final state = State.fromBoard( board );
				// final allPossibleStates = state.getAllPossibleStates();
				// allPossibleStates.length.should.be( 4 );
				// allPossibleStates[0].board.boardValues[0][0].should.be( 2 );
				// allPossibleStates[0].board.boardValues[0][1].should.be( 0 );
				// allPossibleStates[0].board.boardValues[1][0].should.be( 0 );
				// allPossibleStates[0].board.boardValues[1][1].should.be( 0 );
			});
			
		});

	}
}