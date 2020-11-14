package mcts.montecarlo;

import game.data.Action;
import game.Board;

class State {
	
	public var board:Board;
	public var action:Action;
	public var playerNo:Int;
	public var visitCount:Int;
	public var winScore:Float;

	function new( board:Board, playerNo = 1, visitCount = 0, winScore = 0.0 ) {
		this.board = board;
		this.playerNo = playerNo;
		this.visitCount = visitCount;
		this.winScore = winScore;
	}

	public static function createEmpty() {
		final board = Board.createEmpty();
		return new State( board );
	}

	public static function fromState( state:State ) {
		final board = Board.fromBoard( state.board );
		final playerNo = state.playerNo;
		final visitCount = state.visitCount;
		final winScore = state.winScore;

		return new State( board, playerNo, visitCount, winScore );
	}

	public static function fromBoard( board:Board ) {
		return new State( Board.fromBoard( board ));
	}

	public function getOpponent() {
		return 3 - playerNo;
	}

	public function getAllPossibleStates() {
		// constructs a list of all possible states from current state
		final possibleStates:Array<State> = [];
		final possibleActions = board.getPossibleActions( playerNo );
		for( p in possibleActions ) {
			final newState = new State( Board.fromBoard( board ), 3 - playerNo );
			newState.board.performAction( newState.playerNo, p );
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
		final possibleActions = board.getPossibleActions( playerNo );
		final totalPossibilities = possibleActions.length;
		final selectRandom = Std.int( Math.random() * totalPossibilities );
		board.performAction( playerNo, possibleActions[selectRandom] );
	}

	public function togglePlayer() {
		playerNo = 3 - playerNo;
	}

}