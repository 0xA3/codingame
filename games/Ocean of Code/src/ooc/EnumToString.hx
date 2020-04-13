package ooc;

class EnumToString {
	
	public static function mString( direction:Direction ) {
		return switch direction {
			case North: "N";
			case West: "W";
			case South: "S";
			case East: "E";
		}
	}

	public static function cString( action:ChargeAction ) {
		return switch action {
			case ChargeTorpedo: 'TORPEDO';
			case ChargeSonar: 'SONAR';
			case ChargeSilence: 'SILENCE';
		}
	}

	public static function eString( action:ExecuteAction ) {
		return switch action {
			case FireTorpedo(p): 'TORPEDO ${p.x} ${p.y}';
		}
	}

}