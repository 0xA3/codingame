package game;

import game.data.Action;

using Lambda;

class Board {
	
	public static inline var MAX_MOVES = 100;

	public static inline var IN_PROGRESS = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;
	
	public final players:Array<Player>;
	public var actions:Map<Int, Action> = [];

	var totalMoves:Int;

	public function new( players:Array<Player>, actions:Map<Int, Action>, totalMoves = 0 ) {
		this.players = players;
		this.actions = actions;
		this.totalMoves = totalMoves;
	}

	public static function createEmpty() {
		final players = [new Player(), new Player()];
		final actions:Map<Int, Action> = [];
		return new Board( players, actions );
	}

	public static function fromBoard( board:Board ) {
		final players = [board.players[0].copy(), board.players[1].copy()];
		final actions:Map<Int, Action> = [];
		for( id => action in board.actions ) actions.set( id, action.copy() );
		return new Board( players, actions, board.totalMoves );
	}

	public function clearActions() {
		actions = [];
		actions.set( -1, new Action( -1, "LEARN" ));
		actions.set( -2, new Action( -2, "WAIT" ));
	}
	
	public function setAction( id:Int, action:Action ) {
		actions.set( id, action );
	}

	public function performAction( player:Int, action:Action ) {
		totalMoves++;
		switch action.actionType {
			case Brew: players[player - 1].performAction( action );
			case Cast:
				players[player - 1].performAction( action );
				actions[action.actionId].castable = false;
			case Rest:
				for( a in actions ) {
					switch a.actionType {
						case Cast: a.castable = true;
						default: // no-op
					}
				}
			case OpponentCast: // no-op
			case Learn: // no-op
			case Wait: // no-op
		}
	}

	public function checkStatus() {
		if( players[0].potions == 6 || players[1].potions == 6 || totalMoves == 100 ) {
			final p1Score = players[0].score + players[0].inventory.fold(( i, sum ) -> i + sum, 0 );
			final p2Score = players[1].score + players[1].inventory.fold(( i, sum ) -> i + sum, 0 );
			if( p1Score > p2Score ) return P1;
			if( p1Score < p2Score ) return P2;
			return DRAW;
		}

		return IN_PROGRESS;
	}

	public function getPossibleActions( player:Int ) {
		final possibleActions:Array<Action> = [];
		for( action in actions ) if( action.checkDoable( players[player - 1] )) possibleActions.push( action );
		return possibleActions;
	}

}