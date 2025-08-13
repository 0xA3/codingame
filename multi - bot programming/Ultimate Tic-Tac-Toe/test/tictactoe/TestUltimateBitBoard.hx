package test.tictactoe;

import mcts.tictactoe.BitBoard;
import mcts.tictactoe.UltimateBitBoard;

using buddy.Should;

@:access( mcts.tictactoe.BitBoard )
class TestUltimateBitBoard extends buddy.BuddySuite {
	
	public function new() {

		UltimateBitBoard.createPositions();
		
		@include describe( "Test UltimateBitBoard performMove", {

			it( "Test cell 0 horizontal win", {
				final bitBoard = UltimateBitBoard.create();
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[0][0] );
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[0][1] );
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[0][2] );
				bitBoard.getCellP1( UltimateBitBoard.ultimatePositions[0][0] ).should.be( 1 );
			});

			it( "Test cell 0 vertical win", {
				final bitBoard = UltimateBitBoard.create();
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[0][0] );
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[1][0] );
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[2][0] );
				bitBoard.getCellP1( UltimateBitBoard.ultimatePositions[0][0] ).should.be( 1 );
			});

			it( "Test cell 0 diagonal down win", {
				final bitBoard = UltimateBitBoard.create();
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[0][0] );
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[1][1] );
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[2][2] );
				bitBoard.getCellP1( UltimateBitBoard.ultimatePositions[0][0] ).should.be( 1 );
			});

			it( "Test cell 0 diagonal up win", {
				final bitBoard = UltimateBitBoard.create();
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[2][0] );
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[1][1] );
				bitBoard.performMove( 1, UltimateBitBoard.ultimatePositions[0][2] );
				bitBoard.getCellP1( UltimateBitBoard.ultimatePositions[0][0] ).should.be( 1 );
			});
		});
	}
}