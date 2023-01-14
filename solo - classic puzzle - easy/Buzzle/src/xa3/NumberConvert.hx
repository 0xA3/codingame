package xa3;

import Std.int;

class NumberConvert {

	static final digits62 = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	static final base2DecMap = [for( i in 0...digits62.length) digits62.charAt( i ) => i];
	static final hex2DecMap = [for( i in 0...16 ) digits62.charAt( i ) => i];

	public static function toAlphabetical( v:Int ) return convert( v, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
	public static function toBaseN( v:Int, base:Int ) return decToBase( v, base );
	public static function toBinary( v:Int ) return decToBase( v, 2 );
	public static function toBase12( v:Int ) return decToBase( v, 12 );
	public static function toHex( v:Int ) return decToBase( v, 16 );
	
	public static function toDec( s:String, base:Int  ) return baseToDec( s, base );
	
	public static function setMinLength( number:String, minLength:Int ) return number.length < minLength ? [for( _ in 0...minLength - number.length ) "0"].join( "" ) + number : number;

	public static function convert( v:Int, digits:String ) {
		var encoded = "";
		final targetBase = digits.length;
		do {
			encoded = digits.charAt( v % targetBase ) + encoded;
			v = int( v / targetBase );
		} while( v > 0 );
		
		return encoded;
	}

	static function decToBase( v:Int, targetBase:Int ) {
		var encoded = "";
		final digits = digits62.substr( 0, targetBase );
		var value = v;
		do {
			encoded = digits.charAt( value % targetBase ) + encoded;
			value = int( value / targetBase );
		} while( value > 0 );

		return encoded;
	}

	static function baseToDec( s:String, base:Int ) {
		var dec = 0;
		for( i in 0...s.length ) {
			dec *= base;
			final char = s.charAt( i );
			if( !base2DecMap.exists( char )) throw 'Error: illegal char ${char} in $s';
			dec += base2DecMap[char];
		}
		return dec;
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