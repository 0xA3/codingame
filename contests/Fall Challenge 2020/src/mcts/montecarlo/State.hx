package mcts.montecarlo;

import game.data.Action;
import game.Board;

class State {
	
	public var board:Board;
	public var playerNo:Int;
	public var visitCount:Int;
	public var winScore:Float;

	public function new( board:Board, playerNo = 1, visitCount = 0, winScore = 0.0 ) {
		this.board = board;
		this.playerNo = playerNo;
		this.visitCount = visitCount;
		this.winScore = winScore;
	}

	public static function createEmpty() {
		final board = Board.createEmpty();
		return new State( board );
	}

	public function clone() {
		return new State( board.clone(), playerNo, visitCount, winScore );
	}

	public static function fromBoard( board:Board ) {
		return new State( board.clone());
	}

	public function getOpponent() {
		return 3 - playerNo;
	}

	public function getAllPossibleStates() {
		// constructs a list of all possible states from current state
		final possibleActionIds = board.getPossibleActionIds( playerNo );
		
		final possibleStates:Array<State> = [];
		for( actionId in possibleActionIds ) {
			final newState = new State( board.clone(), playerNo );
			newState.board.performAction( newState.playerNo, actionId );
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

	public function checkStatus() {
		return board.checkStatus( playerNo );
	}
	
	public function randomPlay() {
		final possibleActionIds = board.getPossibleActionIds( playerNo );
		final selectRandom = Std.int( Math.random() * possibleActionIds.length );
		final randomAction = possibleActionIds[selectRandom];
		board.performAction( playerNo, randomAction );
	}

	public function togglePlayer() {
		playerNo = 3 - playerNo;
	}

}