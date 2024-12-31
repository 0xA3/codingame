package ai.contexts;

import ai.data.TAction;
import ai.data.TDir;
import ai.data.TGrow;

class Action {
	
	static final dirs = [N => "N", E => "E", S => "S", W => "W", X => "X"];
	
	public static function toOutput( action:TAction ) {
		switch action {
			case NotPossible: return "WAIT";
			case Grow( id, x, y, type, direction ):
				return type == TGrow.Basic
					? 'GROW $id $x $y $type'
					: 'GROW $id $x $y $type ${dirs[direction]}';
			case Wait: return "WAIT";
		}
	}

}