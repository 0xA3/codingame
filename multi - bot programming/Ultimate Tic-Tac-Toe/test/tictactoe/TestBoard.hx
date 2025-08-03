package test.tictactoe;

import mcts.tictactoe.Board;

using buddy.Should;

class TestBoard extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Board", {
			
			it( "Test createEmpty", {
				final board = Board.create( 3 );
				board.boardValues.length.should.be( Board.DEFAULT_BOARD_SIZE );
			});
			
			it( "Test fromBoardSize", {
				final board = Board.create( 2 );
				board.boardValues.length.should.be( 2 );
			});
			
			it( "Test fromBoard", {
				final board1 = Board.create( 3 );
				board1.boardValues[0][0] = 1;
				
				final board2 = Board.copy( board1 );
				board2.boardValues[0][0].should.be( 1 );

				board1.boardValues[1][0] = 1;
				board2.boardValues[1][0].should.be( 0 );
			});
			
			it( "Test performMove", {
				final board = Board.create( 3 );
				board.performMove( 1, { x:0, y: 0 });

				board.totalMoves.should.be( 1 );
				board.boardValues[0][0].should.be( 1 );
			});
			
			it( "Test getEmptyPositions", {
				final board = Board.create( 3 );
				board.getEmptyPositions().length.should.be( 9 );
			});
		});
	}
}