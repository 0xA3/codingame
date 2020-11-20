package game.data;

import CodinGame.printErr;
import game.data.Action;

using Lambda;

enum TBoard {
	InProgress();
	Draw( score:Float );
	Win( playerNo:Int, score:Float );
}

class Board {
	
	public static inline var MAX_MOVES = 100;
	public static inline var POTIONS_TO_WIN = 6;

	static final restAction = new Action( -1, Rest );
	public static final waitAction = new Action( -2, Wait );
	public static final waitActionId = -2;

	public final me:Player;
	public final opponent:Player;
	public var actions:Map<Int, Action> = [];

	public var action:Action;
	public var totalMoves:Int;
	public var maxScore:Int;

	public function new( me:Player, opponent:Player, actions:Map<Int, Action>, totalMoves = 0, maxScore = 0 ) {
		this.me = me;
		this.opponent = opponent;
		this.actions = actions;
		this.totalMoves = totalMoves;
		this.maxScore = maxScore;
	}

	public static function createEmpty( name:String ) {
		return new Board( new Player( name ), new Player(), [] );
	}

	public inline function updatePlayer( playerNo:Int, inv0:Int, inv1:Int, inv2:Int, inv3:Int, score:Int ) {
		final player = playerNo == 1 ? me : opponent;
		player.update( inv0, inv1, inv2, inv3, score );
	}

	public function initActions() {
		for( actionId in actions.keys() ) {
			if( actionId != restAction.actionId ) actions.remove( actionId );
		}
	}
	
	public function addAction( action:Action ) {
		actions.set( action.actionId, action );
		if( action.actionType == Brew ) {
			maxScore += action.price;
		}
	}

	public function removeAction( actionId:Int ) {
		if( actions.exists( actionId )) {
			maxScore -= actions[actionId].price;
			actions.remove( actionId );
		}
	}

	public function getNodeValue() {
		if( action != null && action.actionType == Brew ) {
			return me.score / maxScore / totalMoves;
		}
		return 0.0;
	}

	public function performAction( playerNo:Int, actionId:Int ) {
		totalMoves++;
		this.action = actions[actionId];
		// printErr( 'player $playerNo ${outputAction()}' );
		final player = playerNo == 1 ? me : opponent;
		switch action.actionType {
			case Brew:
				player.performAction( action );
				actions.remove( actionId );
				player.potions += 1;
				// trace( 'player $playerNo BREW $actionId score ${player.score} potions ${player.potions}' );
			case Cast:
				player.performAction( action );
				action.castable = false;
				actions.set( restAction.actionId, restAction );
				// trace( 'player $playerNo cast $actionId' );
			case Rest:
				for( a in actions ) {
					switch a.actionType {
						case Cast: a.castable = true;
						default: // no-op
					}
				}
				actions.remove( actionId );
			case Nothing: // no-op
			case OpponentCast: // no-op
			case Learn: // no-op
			case Wait: // no-op
		}
	}

	// BREW <id> | CAST <id> [<times>] | LEARN <id> | REST | WAIT
	public function outputAction() {
		if( action == null ) return 'WAIT error action is null';
		return switch action.actionType {
			case Brew: 'BREW ${action.actionId}';
			case Cast: 'CAST ${action.actionId}';
			case Learn: 'LEARN ${action.actionId}';
			case Rest: "REST";
			case Wait: "WAIT";
			case OpponentCast: throw "Error: OpponentCast is no valid output";
			case Nothing: throw "Error: Nothing is no valid output";
		}
	}

	public function checkStatus( playerNo = 1 ) {
		
		final meScore = ( 100 - totalMoves ) * me.score  / 1000;
		if( action != null && action.actionType == Wait ) {
			final opponentScore = ( 100 - totalMoves ) * opponent.score / 1000; // + getRestItemsScore( opponent );
			if( meScore > opponentScore ) return Win( 1, meScore );
			if( meScore < opponentScore ) return Win( 2, opponentScore );
			return Draw( meScore );
		}
		
		if( me.potions == POTIONS_TO_WIN || opponent.potions == POTIONS_TO_WIN || totalMoves >= MAX_MOVES ) {
			final opponentScore = ( 100 - totalMoves ) * opponent.score / 1000; // + getRestItemsScore( opponent );
			if( meScore > opponentScore ) return Win( 1, meScore );
			if( meScore < opponentScore ) return Win( 2, opponentScore );
			return Draw( meScore );
		}
		
		// final actionScore = getActionScore();
		return InProgress;
	}

	inline function getRestItemsScore( player:Player ) {
		return player.inventory.fold(( inv, sum ) -> inv + sum, 0 );
	}

	inline function getActionScore() {
		if( action == null ) return 0;
		return switch action.actionType {
			case Brew: action.price;
			case Cast: action.delta.mapi(( i, delta ) -> delta * ( i + 1 )).fold(( delta, sum ) -> delta + sum, 0 );
			case Learn: action.delta.mapi(( i, delta ) -> delta * ( i + 1 )).fold(( delta, sum ) -> delta + sum, 0 );
			default: 0;
		}
	}

	public function getPossibleActionIds( playerNo:Int ) {
		final player = playerNo == 1 ? me : opponent;
		
		final possibleActionIds:Array<Int> = [];
		for( action in actions ) if( action.checkDoable( player )) possibleActionIds.push( action.actionId );
		// trace( 'player $playerNo possibleActionIds $possibleActionIds' );
		if( possibleActionIds.length == 0 ) {
			possibleActionIds.push( waitAction.actionId );
			actions.set( waitAction.actionId, waitAction );
		}

		return possibleActionIds;
	}
	
	public function clone() {
		final clonedActions:Map<Int, Action> = [];
		for( actionId => action in actions ) clonedActions.set( actionId, action.clone() );
		return new Board( me.clone(), opponent.clone(), clonedActions, totalMoves, maxScore );
	}

	public function toString() {
		return 'me: $me, opponent: $opponent, action: $action, totalMoves: $totalMoves';
	}

}