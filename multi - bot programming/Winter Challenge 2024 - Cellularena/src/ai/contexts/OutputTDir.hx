package ai.contexts;

import ai.data.TDir;

class OutputTDir {
	
	public static function toString( tDir:TDir ) {
		return switch tDir {
			case TDir.N: "N";
			case TDir.E: "E";
			case TDir.S: "S";
			case TDir.W: "W";
			case TDir.X: "X";
		}
	}
}