package ai.contexts;

import ai.data.TCell;

class Type {
	public static function toString( type:TCell ) {
		return switch type {
			case NoCell: "NoCell";
			case Empty: "Empty";
			case Wall: "Wall";
			case Root: "Root";
			case Basic: "Basic";
			case Tentacle: "Tentacle";
			case Harvester: "Harvester";
			case Sporer: "Sporer";
			case A: "A";
			case B: "B";
			case C: "C";
			case D: "D";
		}
	}

}