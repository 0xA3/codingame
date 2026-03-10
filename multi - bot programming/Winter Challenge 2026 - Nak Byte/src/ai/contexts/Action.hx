package ai.contexts;

import ai.data.TAction;

class Action {

	public static function toString( action:TAction ) {
		switch action {
			// case None: throw 'Error: Action.None';
			case HunkerDown: return "HUNKER_DOWN";
			case Message( text ): return 'MESSAGE $text';
			case Move( x, y ): return 'MOVE $x $y';
			case Shoot( id ): return 'SHOOT $id';
			case Throw( x, y ): return 'THROW $x $y';
		}
	}
}