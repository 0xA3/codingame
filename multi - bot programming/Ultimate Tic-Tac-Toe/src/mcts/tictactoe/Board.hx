package mcts.tictactoe;

import haxe.ds.Vector;

class Board {
	
	public final boardValues:Vector<Vector<Int>>;
	public var totalMoves:Int;

	public static inline var DEFAULT_BOARD_SIZE = 3;

	public static inline var IN_PROGRESS  = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;

	public var move = Position.NO_POSITION;
	
	public function new( boardValues:Vector<Vector<Int>>, totalMoves = 0 ) {
		this.boardValues = boardValues;
		this.totalMoves = totalMoves;
	}

	public static function createEmpty() {
		final boardValues = createEmptyBoardValues( DEFAULT_BOARD_SIZE );
		return new Board( boardValues );
	}

	public static function fromBoardSize( boardSize:Int ) {
		final boardValues = createEmptyBoardValues( boardSize );
		return new Board( boardValues );
	}

	public static function fromBoard( board:Board ) {
		final boardSize = board.boardValues.length;
		final boardValues = createEmptyBoardValues( boardSize );
		for( i in 0...boardSize ) {
			final m = boardValues[i].length;
			for( j in 0...m ) {
				boardValues[i][j] = board.boardValues[i][j];
			}
		}
		return new Board( boardValues, board.totalMoves );
	}

	static function createEmptyBoardValues( boardSize:Int ) {
		final boardValues = new Vector<Vector<Int>>( boardSize );
		for( i in 0...boardValues.length ) {
			boardValues[i] = new Vector<Int>( boardSize );
			for( j in 0...boardSize ) boardValues[i][j] = 0;
		}
		return boardValues;
	}

	public function performMove( player:Int, p:Position) {
		totalMoves++;
		boardValues[p.x][p.y] = player;
		move = p;
	}

	public function checkStatus() {
		final boardSize = boardValues.length;
		final maxIndex = boardSize - 1;
		final diag1 = new Vector<Int>( boardSize );
		final diag2 = new Vector<Int>( boardSize );

		for( i in 0...boardSize ) {
			final row = boardValues[i];
			final col = new Vector<Int>( boardSize );
			for( j in 0...boardSize ) {
				col[j] = boardValues[j][i];
			}

			final checkRowForWin = checkForWin( row );
			if( checkRowForWin != 0 ) return checkRowForWin;

			final checkColForWin = checkForWin( col );
			if( checkColForWin != 0 ) return checkColForWin;

			diag1[i] = boardValues[i][i];
			diag2[i] = boardValues[maxIndex - i][i];
		}

		final checkDiag1ForWin = checkForWin( diag1 );
		if( checkDiag1ForWin != 0 ) return checkDiag1ForWin;

		final checkDiag2ForWin = checkForWin( diag2 );
		if( checkDiag2ForWin != 0 ) return checkDiag2ForWin;

		return getEmptyPositions().length > 0 ? IN_PROGRESS : DRAW;
	}

	function checkForWin( row:Vector<Int> ) {
		var isEqual = true;
		var previous = row[0];
		for( i in 0...row.length ) {
			if( previous != row[i] ) {
				isEqual = false;
				break;
			}
			previous = row[i];
		}

		return isEqual ? previous : 0;
	}

	public function toString() {
		var s = 'totalMoves $totalMoves\n';
		for( i in 0...boardValues.length ) {
			s += boardValues[i].join(" ") + "\n";
		}
		return s;
	}

	public function getEmptyPositions() {
		final emptyPositions:Array<Position> = [];
		for( i in 0...boardValues.length ) {
			for( j in 0...boardValues.length ) {
				if( boardValues[i][j] == 0 ) emptyPositions.push({ x: i, y: j });
			}
		}

		return emptyPositions;
	}

	public function printStatus() {
		return switch checkStatus() {
			case P1: "Player 1 wins";
			case P2:  "Player 2 wins";
			case DRAW:  "Game Draw";
			case IN_PROGRESS:  "Game in Progress";
			case other: throw 'Error: illegal value $other';
		}
		
	}
}