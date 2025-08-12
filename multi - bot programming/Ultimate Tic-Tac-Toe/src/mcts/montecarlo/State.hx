package mcts.montecarlo;

import CodinGame.printErr;
import mcts.tictactoe.IBoard;

class State {
	
	public static final NO_STATE = new State( -1, null );
	public static var stateCount = 0;

	public final id:Int;
	public var board:IBoard;
	public var player:Int;
	public var visitCount:Int;
	public var winScore:Float;

	public var isInPool = false;

	function new( player:Int, board:IBoard, visitCount = 0, winScore = 0.0 ) {
		this.id = stateCount;
		this.board = board;
		this.player = player;
		this.visitCount = visitCount;
		this.winScore = winScore;
		
		#if interp
		if( stateCount == null ) stateCount = 0;
		#end

		stateCount++;
	}

	public static function init() {
		stateCount = 0;
	}

	public static function create( player:Int, board:IBoard) {
		return new State( player, board );
	}

	public function getOpponent() {
		return 3 - player;
	}

	public function getAllPossibleStates( statePool:StatePool ) {
		// printErr( 'getAllPossibleStates' );
		// constructs a list of all possible states from current state
		final possibleStates:Array<State> = [];
		final availablePositions = board.getEmptyPositions();
		// final ps = [for( position in availablePositions ) '$position'].join( ',' );
		// printErr( 'availablePositions: $ps' );
		// printErr( '${board}' );
		// board.checkForErrors();

		for( p in availablePositions ) {
			final newState = statePool.get( player, board );
			newState.board.performMove( newState.player, p );
			possibleStates.push( newState );
		}
		
		return possibleStates;
	}

	public function incrementVisit() {
		visitCount++;
	}

	public function addScore( score:Float ) {
		if( this.winScore != Integer.MIN_VALUE ) {
			winScore += score;
		}
	}

	public function randomPlay() {
		final availablePositions = board.getEmptyPositions();
		// final ps = [for( position in availablePositions ) '$position'].join( ',' );
		// printErr( 'availablePositions: $ps' );
		// printErr( '${board}' );
		// board.checkForErrors();
		
		if( availablePositions.length == 0 ) {
			// printErr( '${board}status: ${board.printStatus()}' );
			throw 'Error: no available positions\n${board}';
		}

		final totalPossibilities = availablePositions.length;
		final selectRandom = Std.int( Math.random() * totalPossibilities );
		// printErr( 'randomPosition: ${availablePositions[selectRandom]}' );
		board.performMove( player, availablePositions[selectRandom] );
	}

	extern public inline function togglePlayer() {
		player = 3 - player;
	}

	public function toString() {
		return 'player: $player, visitCount: $visitCount, winScore: $winScore';
	}
}