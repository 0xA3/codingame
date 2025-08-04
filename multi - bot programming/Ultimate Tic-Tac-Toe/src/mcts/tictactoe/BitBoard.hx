package mcts.tictactoe;

import CodinGame.printErr;

class BitBoard implements IBoard {
	
	public static inline var BOARD_SIZE = 3;
	public static inline var BOARD_CELLS_NUM = 3 * 3;
	public static inline var IN_PROGRESS  = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;

	public final positions:Array<Array<Position>> = [];
	public var board1 = 0;
	public var board2 = 0;
	public var totalMoves:Int;

	public var move = Position.NO_POSITION;
	public var status = IN_PROGRESS;

	function new( positions:Array<Array<Position>>, board1 = 0, board2 = 0, totalMoves = 0 ) {
		this.positions = positions;
		this.board1 = board1;
		this.board2 = board2;
		this.totalMoves = totalMoves;
	}

	public static function create( positions:Array<Array<Position>> ) {
		return new BitBoard( positions );
	}

	public static function createPositions() {
		final positions:Array<Array<Position>> = [for( y in 0...BOARD_SIZE ) [for( x in 0...BOARD_SIZE ) { x: x, y: y }]];
		return positions;
	}

	public function copy() {
		if( status != IN_PROGRESS ) return this;
		return new BitBoard( positions, board2, totalMoves );
	}

	public function performMove( player:Int, p:Position ) {
		if( getCell( board1 | board2, p ) != 0 ) {
			printErr( toString() );
			throw 'Error: position $p is not empty\n';
		}
		
		if( player == P1 ) setCellP1( p )
		else if( player == P2 ) setCellP2( p );
		else throw 'Error: illegal player $player';
		
		totalMoves++;
		status = getStatusAfterMove( p );
		move = p;
	}

	function getStatusAfterMove( p:Position) {
		final rowResult = checkRowForWin( p.y );
		if( rowResult != 0 ) return rowResult;
		
		final colResult = checkColForWin( p.x );
		if( colResult != 0 ) return colResult;
		
		if( p.y == p.x ) {
			final diagDownResult = checkDiagDownForWin();
			if( diagDownResult != 0 ) return diagDownResult;
		}
		
		if( p.y + p.x == BOARD_SIZE - 1 ) {
			final diagUpResult = checkDiagUpForWin();
			if( diagUpResult != 0 ) return diagUpResult;
		}

		return totalMoves < BOARD_CELLS_NUM ? IN_PROGRESS : DRAW;
	}

	function checkRowForWin( y:Int ) {
		var playerAtPos0 = getValue( positions[y][0] );
		for( x in 1...BOARD_SIZE ) if( getValue( positions[y][x] ) != playerAtPos0 ) return 0;
		return playerAtPos0;
	}

	function checkColForWin( x:Int ) {
		var playerAtPos0 = getValue( positions[0][x] );
		for( y in 1...BOARD_SIZE ) if( getValue( positions[y][x] ) != playerAtPos0 ) return 0;
		return playerAtPos0;
	}

	function checkDiagDownForWin() {
		var playerAtTopLeft = getValue( positions[0][0] );
		for( i in 1...BOARD_SIZE ) if( getValue( positions[i][i] ) != playerAtTopLeft ) return 0;
		return playerAtTopLeft;
	}

	function checkDiagUpForWin() {
		var playerAtBottomLeft = getValue( positions[BOARD_SIZE - 1][0] );
		for( i in 1...BOARD_SIZE ) if( getValue( positions[BOARD_SIZE - 1 - i][i] ) != playerAtBottomLeft ) return 0;
		return playerAtBottomLeft;
	}

	function getValue( p:Position ) return getCell( board1, p ) == 1 ? 1 : getCell( board2, p ) == 1 ? 2 : 0;

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
		final emptyPositions = [];
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
				else if( p1 == 1 ) grid[y].push( 'X' );
				else if( p2 == 1 ) grid[y].push( 'O' );
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