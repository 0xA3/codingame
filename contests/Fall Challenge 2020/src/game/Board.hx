package game;

import game.data.Action;

using Lambda;

class Board {
	
	public static inline var MAX_MOVES = 100;

	public static inline var IN_PROGRESS = -1;
	public static inline var DRAW = 0;
	public static inline var P1 = 1;
	public static inline var P2 = 2;
	
	static final restAction = new Action( -1, Rest );
	public static final waitAction = new Action( -2, Wait );
	
	public final me:Player;
	public final opponent:Player;
	public var actions:Map<Int, Action> = [];

	var totalMoves:Int;

	public function new( me:Player, opponent:Player, actions:Map<Int, Action>, totalMoves = 0 ) {
		this.me = me;
		this.opponent = opponent;
		this.actions = actions;
		this.totalMoves = totalMoves;
	}

	public static function createEmpty() {
		return new Board( new Player(), new Player(), [] );
	}

	public static function fromBoard( board:Board ) {
		final actions:Map<Int, Action> = [];
		for( id => action in board.actions ) actions.set( id, action.copy() );
		return new Board( board.me.copy(), board.opponent.copy(), actions, board.totalMoves );
	}

	public inline function updatePlayer( playerNo:Int, inv0:Int, inv1:Int, inv2:Int, inv3:Int, score:Int ) {
		final player = playerNo == 1 ? me : opponent;
		player.update( inv0, inv1, inv2, inv3, score );
	}

	public function initActions() {
		actions = [];
	}
	
	public function setAction( id:Int, action:Action ) {
		actions.set( id, action );
	}

	public function performAction( playerNo:Int, action:Action ) {
		final player = playerNo == 1 ? me : opponent;
		totalMoves++;
		switch action.actionType {
			case Brew:
				player.performAction( action );
				player.potions += 1;
			case Cast:
				player.performAction( action );
				actions[action.actionId].castable = false;
				actions.set( -1, restAction );
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
		if( me.potions == 6 || opponent.potions == 6 || totalMoves == 100 ) {
			final p1Score = me.score + me.inventory.fold(( i, sum ) -> i + sum, 0 );
			final p2Score = opponent.score + opponent.inventory.fold(( i, sum ) -> i + sum, 0 );
			if( p1Score > p2Score ) return P1;
			if( p1Score < p2Score ) return P2;
			return DRAW;
		}

		return IN_PROGRESS;
	}

	public function getPossibleActions( playerNo:Int ) {
		final player = playerNo == 1 ? me : opponent;
		final possibleActions:Array<Action> = [];
		for( action in actions ) if( action.checkDoable( player )) possibleActions.push( action );
		if( possibleActions.length == 0 ) possibleActions.push( waitAction );

		return possibleActions;
	}

}