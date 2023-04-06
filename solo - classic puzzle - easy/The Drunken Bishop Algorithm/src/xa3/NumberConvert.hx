package xa3;

import Std.int;

class NumberConvert {

	static final digits62 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	static final n2DecMap = [for( i in 0...digits62.length ) digits62.charAt( i ) => i];

	#if js
	extern public static inline function toBin( v:Int ):String return js.Syntax.code( "Number({0}).toString(2)", v );
	extern public static inline function toHex( v:Int ):String return js.Syntax.code( "Number({0}).toString(16)", v );
	extern public static inline function toOct( v:Int ):String return js.Syntax.code( "Number({0}).toString(8)", v );
	extern public static inline function toBaseN( v:Int, targetBase:Int ):String return js.Syntax.code( "Number({0}).toString({1})", v, targetBase );
	#else
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
	#end
}