package mcts.tictactoe;

import CodinGame.printErr;
import Std.int;
import haxe.ds.Vector;
import mcts.montecarlo.MonteCarloTreeSearch;

using Lambda;

class UltimateBitBoard extends BitBoard implements IBoard {
	
	public static inline var ULTIMATE_BOARD_SIZE = 9;
	public static inline var BOARD_CELLS_NUM = 9 * 9;
	public static inline var SMALL_BOARDS_NUM = 3 * 3;
	public static inline var IN_PROGRESS  = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;

	public static var ultimatePositions:Array<Array<Position>>;

	public final smallBoards:Vector<BitBoard>;
	public var nextIndex = -1;

	function new( smallBoards:Vector<BitBoard>, board1 = 0, board2 = 0, totalMoves = 0 ) {
		super( board1, board2, totalMoves );
		this.smallBoards = smallBoards;
	}

	public static function create() {
		final smallBoards = new Vector<BitBoard>( SMALL_BOARDS_NUM );
		for( i in 0...SMALL_BOARDS_NUM ) smallBoards[i] = BitBoard.create();
		
		return new UltimateBitBoard( smallBoards );
	}

	public static function createPositions() {
		ultimatePositions = [for( y in 0...ULTIMATE_BOARD_SIZE ) [for( x in 0...ULTIMATE_BOARD_SIZE ) { x: x, y: y }]];
		BitBoard.smallPositions = [for( y in 0...BitBoard.SMALL_BOARD_SIZE ) [for( x in 0...BitBoard.SMALL_BOARD_SIZE ) ultimatePositions[y][x]]];
	}
	
	override public function copy() {
		// if( status != IN_PROGRESS ) return this;
		
		final smallBoardsCopy = new Vector<BitBoard>( smallBoards.length );
		for( i in 0...smallBoards.length ) smallBoardsCopy[i] = smallBoards[i].copy();

		final boardCopy = new UltimateBitBoard( smallBoardsCopy, board1, board2, totalMoves );
		boardCopy.move = move;
		boardCopy.status = status;
		
		return boardCopy;
	}

	override public function getContentFrom( other:IBoard ) {
		super.getContentFrom( other );
		final otherUltimateBitBoard = cast( other, UltimateBitBoard );

		for( i in 0...smallBoards.length ) smallBoards[i].getContentFrom( otherUltimateBitBoard.smallBoards[i] );
	}

	override public function performMove( player:Int, p:Position) {
		final boardIndex = Transform.getIndex( p.x, p.y );
		final smallBoard = smallBoards[boardIndex];
		
		if( smallBoard.status != IN_PROGRESS ) {
			printErr( 'Error: small board $boardIndex is already finished\n' );
			printErr( toString() );
			throw 'Error: small board $boardIndex is already finished\n';
		}
		
		final localX = Transform.getLocalX( p.x );
		final localY = Transform.getLocalY( p.y );

		final beforeMove = 'small\n${smallBoardsToString()}\nover\n${toString()}';

		// printErr( 'player $player performMove $p in small board $boardIndex at ${localX}:${localY}  nextIndex ${localY * 3 + localX}' );
		smallBoard.performMove( player, BitBoard.smallPositions[localY][localX] );

		if( smallBoard.status != IN_PROGRESS ) {
			final overBoardY = int( boardIndex / 3 );
			final overBoardX = boardIndex % 3;
			final overBoardPosition = ultimatePositions[overBoardY][overBoardX];
			
			if( smallBoard.status == BitBoard.P1 ) setCellP1( overBoardPosition )
			else if( smallBoard.status == BitBoard.P2 ) setCellP2( overBoardPosition );
			else if( smallBoard.status == BitBoard.DRAW ) {
				setCellP1( overBoardPosition );
				setCellP2( overBoardPosition );
			}
			else throw 'Error: illegal player $player';
			
			totalMoves++;
			status = getStatusAfterMove( overBoardPosition );
			
			// printErr( 'smallboard $boardIndex status is ${smallBoard.status}' );
			// printErr( 'overboard status is ${status} totalMoves $totalMoves\n${overBoardToString()}' );

			var unfinishedSmallboards = 0;
			for( smallBoard in smallBoards ) if( smallBoard.status == IN_PROGRESS ) unfinishedSmallboards++;
			
			if( unfinishedSmallboards == 0 && status == IN_PROGRESS ) {
				printErr( 'Error: all small boards are finished but status is still IN_PROGRESS' );
				printErr( 'totalMoves $totalMoves unfinishedSmallboards $unfinishedSmallboards' );
				printErr( 'startBoard\n${MonteCarloTreeSearch.startBoard.toString()}' );
				printErr( 'endBoard\n${toString()}' );
				
				throw 'Error: all small boards are finished but status is still IN_PROGRESS';
			}
		}
		
		if( smallBoardsToString() != overBoardToString() ) {
			printErr( 'beforeMove\n$beforeMove' );
			printErr( 'move $p in small board $boardIndex at ${localX}:${localY}  nextIndex ${getNextIndex( localX, localY )}' );
			printErr( 'smallBoardsToString\n${smallBoardsToString()}' );
			printErr( 'overBoardToString\n${toString()}' );
			throw 'Error: smallBoardsToString != overBoardToString';
		}

		move = p;
		nextIndex = getNextIndex( localX, localY );
	}

	extern inline function getNextIndex( localX:Int, localY:Int ) return localY * 3 + localX;

	override public function getEmptyPositions() {
		if( nextIndex == -1 ) return getAllEmptyPositions();
		
		final previousSmallBoard = smallBoards[nextIndex];
		final previousMove = previousSmallBoard.move;

		final nextBoard = smallBoards[nextIndex];

		if( nextBoard.status != IN_PROGRESS ) return getAllEmptyPositions();
		// if( nextBoard.status != IN_PROGRESS ) {
			// final smallStatie = [for( i in 0...smallBoards.length ) smallBoards[i].status].join( ',' );
			// printErr( 'ultimate status $status   smallStatie $smallStatie' );
			// return getAllEmptyPositions();
		// }

		final emptyPositions = getEmptyPositionsOfSmallBoard( nextIndex );
		
		return emptyPositions;
	}

	function getAllEmptyPositions() {
		var emptyPositions = [];
		for( i in 0...smallBoards.length ) {
			if( smallBoards[i].status != IN_PROGRESS ) continue;
			emptyPositions = emptyPositions.concat( getEmptyPositionsOfSmallBoard( i ) );
		}
		return emptyPositions;
	}

	function getEmptyPositionsOfSmallBoard( i:Int ) {
		final emptyPositions = [];
		final localEmptyPositions = smallBoards[i].getEmptyPositions();
		for( p in localEmptyPositions ) {
			final globalX = Transform.getGlobalX( i, p.x );
			final globalY = Transform.getGlobalY( i, p.y );
			emptyPositions.push( ultimatePositions[globalY][globalX] );
		}
		if( emptyPositions.length == 0 ) throw 'Error: no empty positions in small board $i\n${smallBoards[i]}';
		
		return emptyPositions;
	}

	function smallBoardsToString() {
		var s = "";
		s += [for( i in 0...3 ) statusToString( smallBoards[i].status )].join( ' ' ) + '\n';
		s += [for( i in 3...6 ) statusToString( smallBoards[i].status )].join( ' ' ) + '\n';
		s += [for( i in 6...9 ) statusToString( smallBoards[i].status )].join( ' ' ) + '\n';
		return s;
	}

	function statusToString( status:Int ) {
		if( status == DRAW ) return '#';
		if( status == P1 ) return 'X';
		if( status == P2 ) return 'O';
		return '.';
	}

	function overBoardToString() {
		var s = "";
		final bits1 = [for( i in 0...smallBoards.length ) {
			final mask = 1 << i;
			( board1 & mask ) != 0 ? 1 : 0;
		}];
		final bits2 = [for( i in 0...smallBoards.length ) {
			final mask = 1 << i;
			( board2 & mask ) != 0 ? 1 : 0;
		}];
		
		final status = [for( i in 0...bits1.length ) {
			final b1 = bits1[i];
			final b2 = bits2[i];
			if( b1 == 1 && b2 == 1 ) DRAW;
			else if( b1 == 1 ) P1;
			else if( b2 == 1 ) P2;
			else IN_PROGRESS;
		}];
		
		final combined = status.map( statusToString );
		s += combined.slice( 0, 3 ).join( ' ' ) + '\n';
		s += combined.slice( 3, 6 ).join( ' ' ) + '\n';
		s += combined.slice( 6, 9 ).join( ' ' ) + '\n';

		return s;
	}

	override public function toString() {
		// var s = 'totalMoves $totalMoves\n';
		var s = "";
		s += overBoardToString();
		final grid = [];
		for( y in 0...ULTIMATE_BOARD_SIZE ) {
			grid.push( [] );
			for( x in 0...ULTIMATE_BOARD_SIZE ) {
				final index = Transform.getIndex( x, y );
				final smallBoard = smallBoards[index];

				final localX = Transform.getLocalX( x );
				final localY = Transform.getLocalY( y );

				final p1 = smallBoard.getCellP1( ultimatePositions[localY][localX] );
				final p2 = smallBoard.getCellP2( ultimatePositions[localY][localX] );
				if( x % 3 == 0 ) grid[y].push( '|' );
				if( p1 == 1 && p2 == 1 ) throw 'Error: position ${ultimatePositions[y][x]} is occupied by both players\n';
				// if( p1 == 1 && p2 == 1 ) {
				// 	printErr( 'Error: position ${positions[y][x]} is occupied by both players\n' );
				// 	grid[y].push( '#' );
				// }
				else if( p1 == 1 ) {
					// printErr( 'position $x:$y  player 1' );
					grid[y].push( 'X' );
				}
				else if( p2 == 1 ) {
					// printErr( 'position $x:$y  player 2' );
					grid[y].push( 'O' );
				}
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