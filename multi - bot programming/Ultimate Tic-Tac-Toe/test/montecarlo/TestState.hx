package test.montecarlo;

import mcts.montecarlo.State;
import mcts.tictactoe.Board;

using buddy.Should;

class TestState extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test State", {
			
			it( "Test createEmpty", {
				final state = State.create();
				state.board.should.not.be( null );
				state.playerNo.should.be( 1 );
				state.visitCount.should.be( 0 );
				state.winScore.should.be( 0 );
			});
			
			it( "Test fromState", {
				final state1 = State.create();
				final state2 = State.fromState( state1 );
				state2.playerNo = 2;
				state2.visitCount = 1;
				state2.winScore = 1;

				state2.board.should.not.be( state1.board );
				state2.playerNo.should.not.be( state1.playerNo );
				state2.winScore.should.not.be( state1.winScore );
			});
			
			it( "Test getOpponent", {
				final state = State.create();
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