package ai.contexts;

import ai.data.TAction;
import ai.data.TDir;
import ai.data.TGrow;

class Action {
	
	static final dirs = [N => "N", E => "E", S => "S", W => "W", X => "X"];
	
	public static function toString( action:TAction ) {
		switch action {
			case NotPossible: return "WAIT";
			case Grow( id, x, y, type, direction, text ):
				return type == TGrow.Basic
					? 'GROW $id $x $y $type $text'
					: 'GROW $id $x $y $type ${dirs[direction]} $text';
			case Wait: return "WAIT";
		}
	}
}