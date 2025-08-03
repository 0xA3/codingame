package test.tictactoe;

import mcts.tictactoe.Board;

using buddy.Should;

class TestBoardCheckStatus extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test BoardCheckStatus", {
			
			/*
			0 0 0
			0 0 0
			0 0 0
			*/
			it( "Test checkStatus IN_PROGRESS", {
				final board = Board.create( 3 );
				board.checkStatus().should.be( Board.IN_PROGRESS );
			});
			
			/*
			1 2 2
			2 1 1
			2 1 2
			*/
			it( "Test checkStatus DRAW", {
				final board = Board.create( 3 );
				board.boardValues[0][0] = 1;
				board.boardValues[0][1] = 2;
				board.boardValues[0][2] = 2;
				
				board.boardValues[1][0] = 2;
				board.boardValues[1][1] = 1;
				board.boardValues[1][2] = 1;
				
				board.boardValues[2][0] = 2;
				board.boardValues[2][1] = 1;
				board.boardValues[2][2] = 2;
				board.checkStatus().should.be( Board.DRAW );
			});
		
			/*
			1 1 1
			2 2 0
			0 0 0
			*/
			it( "Test checkStatus P1 vertical", {
				final board = Board.create( 3 );
				board.boardValues[0][0] = 1;
				board.boardValues[0][1] = 1;
				board.boardValues[0][2] = 1;
				
				board.boardValues[1][0] = 2;
				board.boardValues[1][1] = 2;
				board.boardValues[1][2] = 0;
				
				board.boardValues[2][0] = 0;
				board.boardValues[2][1] = 0;
				board.boardValues[2][2] = 0;
				board.checkStatus().should.be( Board.P1 );
			});
			
			/*
			1 2 0
			1 2 0
			1 0 0
			*/
			it( "Test checkStatus P1 horizontal", {
				final board = Board.create( 3 );
				board.boardValues[0][0] = 1;
				board.boardValues[0][1] = 2;
				board.boardValues[0][2] = 0;
				
				board.boardValues[1][0] = 1;
				board.boardValues[1][1] = 2;
				board.boardValues[1][2] = 0;
				
				board.boardValues[2][0] = 1;
				board.boardValues[2][1] = 0;
				board.boardValues[2][2] = 0;
				board.checkStatus().should.be( Board.P1 );
			});
			
			/*
			1 2 2
			0 1 0
			0 0 1
			*/
			it( "Test checkStatus P1 diagonal", {
				final board = Board.create( 3 );
				board.boardValues[0][0] = 1;
				board.boardValues[0][1] = 2;
				board.boardValues[0][2] = 2;
				
				board.boardValues[1][0] = 0;
				board.boardValues[1][1] = 1;
				board.boardValues[1][2] = 0;
				
				board.boardValues[2][0] = 0;
				board.boardValues[2][1] = 0;
				board.boardValues[2][2] = 1;
				board.checkStatus().should.be( Board.P1 );
			});
		});
	}
}