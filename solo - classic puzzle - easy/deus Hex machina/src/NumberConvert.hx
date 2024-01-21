import Std.int;

class NumberConvert {

	static final digitsHex = "0123456789abcdef";
	static final n2DecMap = [for( i in 0...digitsHex.length ) digitsHex.charAt( i ) => i];

	public static function toBin( v:Int, isFill:Bool ) {
		var encoded = "";
		final digits = digitsHex.substr( 0, 2 );
		var value = v;
		do {
			encoded = digits.charAt( value % 2 ) + encoded;
			value = int( value / 2 );
		} while( value > 0 );

		if( !isFill || encoded.length == 4 ) return encoded;

		final filledEncoded = [for( _ in 0...4 - encoded.length) "0"].join( "" ) + encoded;
		return filledEncoded;
	}
	
	public static function fromHex( s:String ) return fromBaseN( s.toLowerCase(), 16 );

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