package ooc;

class DirectionString {
	
	public static function get( direction:Direction ) {
		return switch direction {
			case North: "N";
			case West: "W";
			case South: "S";
			case East: "E";
		}

	}

}