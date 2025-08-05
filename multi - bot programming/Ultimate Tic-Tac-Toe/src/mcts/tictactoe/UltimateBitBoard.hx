package mcts.tictactoe;

import CodinGame.printErr;
import Std.int;
import haxe.ds.Vector;

class UltimateBitBoard extends BitBoard implements IBoard {
	
	public static inline var BOARD_SIZE = 9;
	public static inline var BOARD_CELLS_NUM = 9 * 9;
	public static inline var IN_PROGRESS  = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;

	public final smallBoards:Vector<BitBoard>;

	public var previousBoardIndex = -1;

	function new( positions:Array<Array<Position>>, smallBoards:Vector<BitBoard>, board1 = 0, board2 = 0, totalMoves = 0 ) {
		super( positions, board1, board2, totalMoves );
		this.smallBoards = smallBoards;
	}

	public static function create( positions:Array<Array<Position>> ) {
		final positions = createPositions();
		final smallBoardPositions = [for( y in 0...BitBoard.BOARD_SIZE ) [for( x in 0...BitBoard.BOARD_SIZE ) positions[y][x]]];
		
		final smallBoards = new Vector<BitBoard>( BOARD_CELLS_NUM );
		for( i in 0...BOARD_CELLS_NUM ) smallBoards[i] = BitBoard.create( smallBoardPositions );
		
		return new UltimateBitBoard( positions, smallBoards );
	}

	override public function copy() {
		if( status != IN_PROGRESS ) return this;
		
		final smallBoardsCopy = new Vector<BitBoard>( smallBoards.length );
		for( i in 0...smallBoards.length ) smallBoardsCopy[i] = smallBoards[i].copy();
		
		return new UltimateBitBoard( positions, smallBoardsCopy, board1, board2, totalMoves );
	}

	public static function createPositions() {
		final positions:Array<Array<Position>> = [for( y in 0...BOARD_SIZE ) [for( x in 0...BOARD_SIZE ) { x: x, y: y }]];
		return positions;
	}

	override public function performMove( player:Int, p:Position) {
		final boardIndex = Transform.getIndex( p.x, p.y );
		final smallBoard = smallBoards[boardIndex];
		
		if( smallBoard.status != IN_PROGRESS ) {
			printErr( toString() );
			throw 'Error: small board $boardIndex is already finished\n';
		}
		
		final localX = Transform.getLocalX( p.x );
		final localY = Transform.getLocalY( p.y );
		smallBoard.performMove( player, smallBoard.positions[localY][localX] );

		final bigBoardLocalY = int( boardIndex / 3 );
		final bigBoardLocalX = boardIndex % 3;
		final bigBoardPos = positions[bigBoardLocalY][bigBoardLocalX];
		
		if( player == P1 ) setCellP1( bigBoardPos )
		else if( player == P2 ) setCellP2( bigBoardPos );
		else throw 'Error: illegal player $player';
		
		totalMoves++;
		smallBoard.status = getStatusAfterMove( bigBoardPos );
		
		final moveX = Transform.getGlobalX( boardIndex, localX );
		final moveY = Transform.getGlobalY( boardIndex, localY );
		
		previousBoardIndex = boardIndex;
		move = positions[moveY][moveX];
	}

	override public function toString() {
		// var s = 'totalMoves $totalMoves\n';
		var s = "";
		final grid = [];
		for( y in 0...BOARD_SIZE ) {
			grid.push( [] );
			for( x in 0...BOARD_SIZE ) {
				final index = Transform.getIndex( x, y );
				final smallBoard = smallBoards[index];

				final localX = Transform.getLocalX( x );
				final localY = Transform.getLocalY( y );

				final p1 = smallBoard.getCell( board1, positions[y][x] );
				final p2 = smallBoard.getCell( board2, positions[y][x] );
				if( x % 3 == 0 ) grid[y].push( '|' );
				if( p1 == 1 && p2 == 1 ) throw 'Error: position ${positions[y][x]} is occupied by both players\n';
				// if( p1 == 1 && p2 == 1 ) {
				// 	printErr( 'Error: position ${positions[y][x]} is occupied by both players\n' );
				// 	grid[y].push( '#' );
				// }
				else if( p1 == 1 ) grid[y].push( 'X' );
				else if( p2 == 1 ) grid[y].push( 'O' );
				else grid[y].push( '.' );
			}
			grid[y].push( '|' );
		}
		final verticalSeparator = " - - - - - - - - - - - -";
		grid.insert( 3, [verticalSeparator] );
		grid.insert( 7, [verticalSeparator] );

		for( y in 0...grid.length ) {
			s += grid[y].join(" ") + "\n";
		}
		return s;
	}
}