package ai.contexts;

import ai.data.TCell;

class CellType {
	public static function toString( type:TCell ) {
		return switch type {
			case NoCell: "NO_CELL";
			case Empty: "EMPTY";
			case Wall: "WALL";
			case Root: "ROOT";
			case Basic: "BASIC";
			case Tentacle: "TENTACLE";
			case Harvester: "HARVESTER";
			case Sporer: "SPORER";
			case A: "A";
			case B: "B";
			case C: "C";
			case D: "D";
		}
	}

}