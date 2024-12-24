package ai.contexts;

import ai.data.TCell;

class OutputTCell {
	public static function output( cellType:TCell ) {
		switch cellType {
			case TCell.NoCell: return "NO_CELL";
			case TCell.Empty: return "EMPTY";
			case TCell.Wall: return "WALL";
			case TCell.Root: return "ROOT";
			case TCell.Basic: return "BASIC";
			case TCell.Tentacle: return "TENTACLE";
			case TCell.Harvester: return "HARVESTER";
			case TCell.Sporer: return "SPORER";
			case TCell.A: return "A";
			case TCell.B: return "B";
			case TCell.C: return "C";
			case TCell.D: return "D";
			default: return "UNKNOWN";
		}
	}
}