package game.data;

import game.data.Action.ActionType;

class Command {
	
	public final actionId:Int; // the unique ID of this spell or recipe
	public final actionType:ActionType; // CAST, OPPONENT_CAST, LEARN, BREW
	public final times:Int; // how many times to cast the spell

	function new( actionId:Int, actionType:ActionType, times:Int ) {
		this.actionId = actionId;
		this.actionType = actionType;
		this.times = times;
	}

	public static function fromAction( action:Action, times = 1 ) {
		return new Command( action.actionId, action.actionType, times );
	}

	public inline function output() {
		return switch actionType {
			case Wait: 'WAIT';
			case Rest: 'REST';
			default: '${type()} $actionId' + ( times > 1 ? ' $times' : '' );
		}
	}

	function type() {
		return switch actionType {
			case Brew: "BREW";
			case Cast: "CAST";
			case OpponentCast: "OPPONENT_CAST";
			case Learn: "LEARN";
			case Rest: "REST";
			case Wait: "WAIT";
		}
	}

}