package xa3;

import Std.int;

class NumberConvert {

	static final digits62 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	static final n2DecMap = [for( i in 0...digits62.length ) digits62.charAt( i ) => i];

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

	public static function fromBin( s:String ) return fromBaseN( s, 2 );
	public static function fromHex( s:String ) return fromBaseN( s, 16 );
	public static function fromOct( s:String ) return fromBaseN( s, 8 );

	public static function fromBaseN( s:String, sourceBase:Int ) {
		var dec = 0;
		for( i in 0...s.length ) {
			dec *= sourceBase;
			final char = s.charAt( i ).toUpperCase();
			if( !n2DecMap.exists( char )) throw 'Error: illegal char ${s.charAt( i )} in input value $s';
			dec += n2DecMap[char];
		}
		return dec;
	}
	
	public static function fToBin( v:Float ) return fToBaseN( v, 2 );
	public static function fToHex( v:Float ) return fToBaseN( v, 16 );
	public static function fToOct( v:Float ) return fToBaseN( v, 8 );

	public static function fToBaseN( v:Float, targetBase:Int ) {
		var encoded = "";
		final digits = digits62.substr( 0, targetBase );
		var value = v;
		do {
			encoded = digits.charAt( int( value % targetBase )) + encoded;
			value = Math.ffloor( value / targetBase );
		} while( value > 0 );

		return encoded;
	}

	public static function fFromBin( s:String ) return fFromBaseN( s, 2 );
	public static function fFromHex( s:String ) return fFromBaseN( s, 16 );
	public static function fFromOct( s:String ) return fFromBaseN( s, 8 );

	public static function fFromBaseN( s:String, sourceBase:Int ) {
		var dec = 0.0;
		for( i in 0...s.length ) {
			dec *= sourceBase;
			final char = s.charAt( i );
			if( !n2DecMap.exists( char )) throw 'Error: illegal char ${s.charAt( i )} in input value $s';
			dec += n2DecMap[char];
		}
		return dec;
	}
}