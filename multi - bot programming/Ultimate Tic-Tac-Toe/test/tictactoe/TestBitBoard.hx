package test.tictactoe;

import mcts.tictactoe.BitBoard;
import mcts.tictactoe.UltimateBitBoard;

using buddy.Should;

@:access( mcts.tictactoe.BitBoard )
class TestBitBoard extends buddy.BuddySuite {
	
	public function new() {

		UltimateBitBoard.createPositions();
		
		describe( "Test BitBoard setCell", {
			it( "Test setCell 1", {
				final bitBoard = BitBoard.create();
				bitBoard.setCellP1( BitBoard.smallPositions[0][0] );
				bitBoard.board1.should.be( 1 );
			});
			it( "Test setCell 2", {
				final bitBoard = BitBoard.create();
				bitBoard.setCellP1( BitBoard.smallPositions[0][1]);
				bitBoard.board1.should.be( 2 );
			});
			it( "Test setCell 3", {
				final bitBoard = BitBoard.create();
				bitBoard.setCellP1( BitBoard.smallPositions[0][2]);
				bitBoard.board1.should.be( 4 );
			});
			it( "Test setCell 3", {
				final bitBoard = BitBoard.create();
				bitBoard.setCellP1( BitBoard.smallPositions[1][0]);
				bitBoard.board1.should.be( 8 );
			});
			it( "Test setCell 7", {
				final bitBoard = BitBoard.create();
				bitBoard.setCellP1( BitBoard.smallPositions[2][2]);
				bitBoard.board1.should.be( 256 );
			});
		});
		
		describe( "Test BitBoard getCell", {
			final bitBoard = BitBoard.create();
			bitBoard.setCellP1( BitBoard.smallPositions[0][0] );
			bitBoard.setCellP1( BitBoard.smallPositions[0][1] );
			bitBoard.setCellP1( BitBoard.smallPositions[0][2] );
			bitBoard.setCellP1( BitBoard.smallPositions[1][0] );
			bitBoard.setCellP1( BitBoard.smallPositions[2][2] );

			it( "Test getCell 1", {
				bitBoard.getCell( bitBoard.board1, BitBoard.smallPositions[0][0] ).should.be( 1 );
			});
			it( "Test getCell 2", {
				bitBoard.getCell( bitBoard.board1, BitBoard.smallPositions[0][1]).should.be( 1 );
			});
			it( "Test getCell 3", {
				bitBoard.getCell( bitBoard.board1, BitBoard.smallPositions[0][2]).should.be( 1 );
			});
			it( "Test getCell 3", {
				bitBoard.getCell( bitBoard.board1, BitBoard.smallPositions[1][0]).should.be( 1 );
			});
			it( "Test getCell 7", {
				bitBoard.getCell( bitBoard.board1, BitBoard.smallPositions[2][2]).should.be( 1 );
			});
		});
		
		describe( "Test BitBoard countCells player 1", {
			final bitBoard = BitBoard.create();
			bitBoard.board1 = bitBoard.setCell( bitBoard.board1, BitBoard.smallPositions[0][0] );
			bitBoard.board1 = bitBoard.setCell( bitBoard.board1, BitBoard.smallPositions[0][1] );
			bitBoard.board1 = bitBoard.setCell( bitBoard.board1, BitBoard.smallPositions[0][2] );
			bitBoard.board1 = bitBoard.setCell( bitBoard.board1, BitBoard.smallPositions[1][0] );
			bitBoard.board1 = bitBoard.setCell( bitBoard.board1, BitBoard.smallPositions[2][2] );

			it( "Test countCells", {
				bitBoard.countCells( bitBoard.board1 ).should.be( 5 );
			});
		});
	}
}