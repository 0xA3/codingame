package xa3;

import Std.int;

class NumberConvert {

	static final digits62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	
	public static function toBaseN( v:Int, targetBase:Int ) {
		var encoded = "";
		final digits = digits62.substr( 0, targetBase );
		var value = v;
		do {
			encoded = digits.charAt( value % targetBase ) + encoded;
			value = int( value / targetBase );
		} while( value > 0 );

		return encoded;
	}
}