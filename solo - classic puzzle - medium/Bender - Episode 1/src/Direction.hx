enum Direction {
	South;
	East;
	North;
	West;
}

class PrintDirection {
	
	public static function print( d:Direction ) {
		return switch d {
			case South: "SOUTH";
			case East: "EAST";
			case North: "NORTH";
			case West: "WEST";
		}
	}
}