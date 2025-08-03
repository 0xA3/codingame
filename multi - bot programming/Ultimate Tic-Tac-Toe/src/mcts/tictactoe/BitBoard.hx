package mcts.tictactoe;

import CodinGame.printErr;
import haxe.ds.Vector;

class BitBoard {
	
	public final positions:Array<Array<Position>> = [];
	public var board1 = 0;
	public var board2 = 0;
	public var totalMoves:Int;

	public static inline var BOARD_SIZE = 3;

	public static inline var IN_PROGRESS  = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;

	public var move = Position.NO_POSITION;
	public var status = IN_PROGRESS;

	public function new( positions:Array<Array<Position>>, board1 = 0, board2 = 0, totalMoves = 0 ) {
		this.positions = positions;
		this.board1 = board1;
		this.board2 = board2;
		this.totalMoves = totalMoves;
	}

	public static function create() {
		return new BitBoard( createPositions() );
	}

	public static function copy( board:BitBoard ) {
		return new BitBoard( board.positions, board.board1, board.board2, board.totalMoves );
	}

	static function createPositions() {
		final positions:Array<Array<Position>> = [for( y in 0...BOARD_SIZE ) [for( x in 0...BOARD_SIZE ) { x: x, y: y }]];
		return positions;
	}

	public function performMove( player:Int, p:Position) {
		totalMoves++;
		if( getCell( board1 | board2, p ) != 0 ) {
			printErr( toString() );
			throw 'Error: position $p is not empty\n';
		}
		if( player == P1 ) setCellP1( p )
		else if( player == P2 ) setCellP2( p );
		else throw 'Error: illegal player $player';
		
		move = p;
	}

	public function checkStatus() {
		final boardSize = BOARD_SIZE;
		final maxIndex = boardSize - 1;
		final diag1 = new Vector<Int>( boardSize );
		final diag2 = new Vector<Int>( boardSize );

		for( y in 0...boardSize ) {
			final row = new Vector<Int>( boardSize );
			for( x in 0...boardSize ) row[x] = getValue( positions[y][x] );
			final col = new Vector<Int>( boardSize );
			for( x in 0...boardSize ) {
				col[x] = getValue( positions[x][y] );
			}

			final checkRowForWin = checkForWin( row );
			if( checkRowForWin != 0 ) return checkRowForWin;

			final checkColForWin = checkForWin( col );
			if( checkColForWin != 0 ) return checkColForWin;

			diag1[y] = getValue( positions[y][y] );
			diag2[y] = getValue( positions[maxIndex - y][y] );
		}

		final checkDiag1ForWin = checkForWin( diag1 );
		if( checkDiag1ForWin != 0 ) return checkDiag1ForWin;

		final checkDiag2ForWin = checkForWin( diag2 );
		if( checkDiag2ForWin != 0 ) return checkDiag2ForWin;
		return getEmptyPositions().length > 0 ? IN_PROGRESS : DRAW;
	}

	function getValue( p:Position ) return getCell( board1, p ) == 1 ? 1 : getCell( board2, p ) == 1 ? 2 : 0;

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

	function setCellP1( p:Position ) board1 = setCell( board1, p );
	function setCellP2( p:Position ) board2 = setCell( board2, p );

	function setCell( board:Int, p:Position ) {
		final bit = 1 << ( p.y * BOARD_SIZE + p.x );
		return board |= bit;
	}

	function getCell( board:Int, p:Position ) {
		final mask = 1 << ( p.y * BOARD_SIZE + p.x );
		return ( board & mask ) != 0 ? 1 : 0;
	}

	function countCells( board:Int ) {
		var count = 0;
		var bb = board;

		while( bb != 0 ) {
			bb &= bb - 1;
			count++;
		}

		return count;
	}

	public function getEmptyPositions() {
		final board = board1 | board2;
		final emptyPositions:Array<Position> = [];
		for( y in 0...BOARD_SIZE ) {
			for( x in 0...BOARD_SIZE ) {
				if( getCell( board, positions[y][x] ) == 0 ) emptyPositions.push( positions[y][x] );
			}
		}

		return emptyPositions;
	}

	public function toString() {
		var s = 'totalMoves $totalMoves\n';
		final grid = [];
		for( y in 0...BOARD_SIZE ) {
			grid.push( [] );
			for( x in 0...BOARD_SIZE ) {
				final p1 = getCell( board1, positions[y][x] );
				final p2 = getCell( board2, positions[y][x] );
				if( p1 == 1 && p2 == 1 ) throw 'Error: position ${positions[y][x]} is occupied by both players\n';
				else if( p1 == 1 ) grid[y].push( 'O' );
				else if( p2 == 1 ) grid[y].push( 'X' );
				else grid[y].push( '.' );
			}
		}
		for( y in 0...grid.length ) {
			s += grid[y].join(" ") + "\n";
		}
		return s;
	}

	public function printStatus() {
		return switch status {
			case P1: "Player 1 wins";
			case P2:  "Player 2 wins";
			case DRAW:  "Game Draw";
			case IN_PROGRESS:  "Game in Progress";
			case other: throw 'Error: illegal value $other';
		}
		
	}
}