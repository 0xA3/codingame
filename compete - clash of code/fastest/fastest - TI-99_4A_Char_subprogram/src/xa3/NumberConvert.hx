package xa3;

import Std.int;

class NumberConvert {

	static final digits62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	static final base2DecMap = [for( i in 0...digits62.length) digits62.charAt( i ) => i];
	static final hex2DecMap = [for( i in 0...16 ) digits62.charAt( i ) => i];
	
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

	public static function hexToDec( hex:String ) {
		var dec = 0;
		for( i in 0...hex.length ) {
			dec *= 16;
			final char = hex.charAt( i ).toUpperCase();
			if( !hex2DecMap.exists( char )) throw 'Error: illegal char in hex value $hex';
			dec += hex2DecMap[char];
		}
		return dec;
	}
}