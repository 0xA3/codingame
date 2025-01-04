package ai.contexts;

import ai.contexts.Type;
import ai.data.TAction;
import ai.data.TCell;
import ai.data.TDir;

class Action {
	
	static final dirs = [N => "N", E => "E", S => "S", W => "W", X => "X"];
	
	public static function toString( action:TAction ) {
		switch action {
			case NotPossible: return "WAIT";
			case Grow( id, x, y, type, direction, text ):
				return type == TCell.Basic
					? 'GROW $id $x $y ${Type.toString( type )} $text'
					: 'GROW $id $x $y ${Type.toString( type )} ${dirs[direction]} $text';
			case Wait: return "WAIT";
		}
	}
}