package xa3;

import Std.int;

class NumberConvert {

	static final digits = "0123456789ABCDEF";
	static final n2DecMap = [for( i in 0...digits.length ) digits.charAt( i ) => i];

	public static function toBin( v:Int ) return toBaseN( v, 2 );
	
	public static function toBaseN( v:Int, targetBase:Int ) {
		var encoded = "";
		final digits = digits.substr( 0, targetBase );
		var value = v;
		do {
			encoded = digits.charAt( value % targetBase ) + encoded;
			value = int( value / targetBase );
		} while( value > 0 );

		return encoded;
	}
	
	public static function fromHex( s:String ) return fromBaseN( s, 16 );

	public static function fromBaseN( s:String, sourceBase:Int ) {
		var dec = 0;
		for( i in 0...s.length ) {
			dec *= sourceBase;
			final char = s.charAt( i );
			if( !n2DecMap.exists( char )) throw 'Error: illegal char ${s.charAt( i )} in input value $s';
			dec += n2DecMap[char];
		}
		return dec;
	}
}