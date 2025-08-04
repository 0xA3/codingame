package mcts.montecarlo;

import CodinGame.printErr;
import mcts.tictactoe.IBoard;

class State {
	
	public var board:IBoard;
	public var player:Int;
	public var visitCount:Int;
	public var winScore:Float;

	function new( player:Int, board:IBoard, visitCount = 0, winScore = 0.0 ) {
		this.board = board;
		this.player = player;
		this.visitCount = visitCount;
		this.winScore = winScore;
	}

	public static function create( player:Int, board:IBoard) {
		return new State( player, board );
	}

	public static function copy( state:State ) {
		final board = state.board.copy();
		final player = state.player;
		final visitCount = state.visitCount;
		final winScore = state.winScore;

		return new State( player, board, visitCount, winScore );
	}

	public static function fromBoard( player:Int, board:IBoard ) {
		return new State( player, board.copy());
	}

	public function getOpponent() {
		return 3 - player;
	}

	public function getAllPossibleStates() {
		// printErr( 'getAllPossibleStates' );
		// constructs a list of all possible states from current state
		final possibleStates:Array<State> = [];
		final availablePositions = board.getEmptyPositions();
		// final ps = [for( position in availablePositions ) '$position'].join( ',' );
		// printErr( 'availablePositions: $ps' );
		// printErr( '${board}' );
		// board.checkForErrors();

		for( p in availablePositions ) {
			final newState = new State( 3 - player, board.copy() );
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
			throw 'Error: no available positions';
		}

		final totalPossibilities = availablePositions.length;
		final selectRandom = Std.int( Math.random() * totalPossibilities );
		// printErr( 'randomPosition: ${availablePositions[selectRandom]}' );
		board.performMove( player, availablePositions[selectRandom] );
	}

	public function togglePlayer() {
		player = 3 - player;
	}

	public function toString() {
		return 'player: $player, visitCount: $visitCount, winScore: $winScore';
	}
}