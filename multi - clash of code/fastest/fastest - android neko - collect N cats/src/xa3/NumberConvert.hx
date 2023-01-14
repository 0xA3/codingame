package xa3;

import Std.int;

class NumberConvert {

	static final digits62 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	public static function toBin( v:Int ) return toBaseN( v, 2 );
	public static function toHex( v:Int ) return toBaseN( v, 16 );
	public static function toOct( v:Int ) return toBaseN( v, 8 );

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