package xa3;

class DoubleDigit {

	public static function double( value:Int ):String {
		return char( value, "0" );
	}

	public static function space( value:Int ):String {
		return char( value, " " );
	}

	public static function char( value:Int, char:String ):String {

		if ( value < 10 ) {
			return char + Std.string( value );
		} else {
			return Std.string( value );
		}
	}
}