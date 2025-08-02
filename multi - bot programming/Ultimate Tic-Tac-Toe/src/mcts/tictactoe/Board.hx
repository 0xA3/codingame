package mcts.tictactoe;

import CodinGame.printErr;
import haxe.ds.Vector;

class Board {
	
	public final positions:Array<Array<Position>>;
	public var boardValuesInt = 0;
	public final boardValues:Vector<Vector<Int>>;
	public var totalMoves:Int;

	public static inline var DEFAULT_BOARD_SIZE = 3;

	public static inline var IN_PROGRESS  = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;

	public var move = Position.NO_POSITION;
	
	public function new( positions:Array<Array<Position>>, boardValues:Vector<Vector<Int>>, totalMoves = 0 ) {
		this.positions = positions;
		this.boardValues = boardValues;
		this.totalMoves = totalMoves;
	}

	public static function create( boardSize:Int ) {
		final positions = createPositions( boardSize );
		final boardValues = createEmptyBoardValues( boardSize );
		return new Board( positions, boardValues );
	}

	public static function copy( board:Board ) {
		final boardSize = board.boardValues.length;
		final boardValues = createEmptyBoardValues( boardSize );
		for( y in 0...boardSize ) {
			final m = boardValues[y].length;
			for( x in 0...m ) {
				boardValues[y][x] = board.boardValues[y][x];
			}
		}
		return new Board( board.positions, boardValues, board.totalMoves );
	}

	static function createPositions( boardSize:Int ) {
		final positions:Array<Array<Position>> = [for( y in 0...boardSize ) [for( x in 0...boardSize ) { x: x, y: y }]];
		return positions;
	}

	static function createEmptyBoardValues( boardSize:Int ) {
		final boardValues = new Vector<Vector<Int>>( boardSize );
		for( y in 0...boardValues.length ) {
			boardValues[y] = new Vector<Int>( boardSize );
			for( x in 0...boardSize ) boardValues[y][x] = 0;
		}
		return boardValues;
	}

	public function performMove( player:Int, p:Position) {
		totalMoves++;
		if( boardValues[p.y][p.x] != 0 ) {
			printErr( toString() );
			throw 'Error: position $p is not empty\n';
		}
		boardValues[p.y][p.x] = player;
		move = p;
	}

	public function checkStatus() {
		final boardSize = boardValues.length;
		final maxIndex = boardSize - 1;
		final diag1 = new Vector<Int>( boardSize );
		final diag2 = new Vector<Int>( boardSize );

		for( y in 0...boardSize ) {
			final row = boardValues[y];
			final col = new Vector<Int>( boardSize );
			for( x in 0...boardSize ) {
				col[x] = boardValues[x][y];
			}

			final checkRowForWin = checkForWin( row );
			if( checkRowForWin != 0 ) return checkRowForWin;

			final checkColForWin = checkForWin( col );
			if( checkColForWin != 0 ) return checkColForWin;

			diag1[y] = boardValues[y][y];
			diag2[y] = boardValues[maxIndex - y][y];
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
		for( y in 0...boardValues.length ) {
			for( x in 0...boardValues.length ) {
				if( boardValues[y][x] == 0 ) emptyPositions.push( positions[y][x] );
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