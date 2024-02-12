import Std.int;

class NumberConvert {

	public static function toBin( v:Int ) {
		var encoded = "";
		final digits = "01";
		var value = v;
		do {
			encoded = digits.charAt( value % 2 ) + encoded;
			value = int( value / 2 );
		} while( value > 0 );

		return encoded;
	}
}