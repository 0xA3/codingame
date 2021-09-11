package xa3;

class NumberConvert {

	public static function toAlphabetical( v:Int ) return convert( v, "ABCDEFGHIJKLMNOPQRSTUVWXYZ" );
	public static function toBinary( v:Int ) return convert( v, "01" );
	public static function toBase12( v:Int ) return convert( v, "0123456789AB" );
	public static function toHex( v:Int ) return convert( v, "0123456789ABCDEF" );
	public static function setMinLength( number:String, minLength:Int ) return number.length < minLength ? [for( i in 0...minLength - number.length ) "0"].join("") + number : number;

	public static function convert( v:Int, digits:String ) {
		final length = digits.length;
		var encoded ="";
		var d = v + 1;
		while( d > 0 ) {
			final r = ( d - 1 ) % length;
			encoded = digits.charAt( r ) + encoded;
			d = Std.int(( d - r ) / length );
		}
		return encoded;
	}

	static final hex2DecMap = [
		"0" => 0,
		"1" => 1,
		"2" => 2,
		"3" => 3,
		"4" => 4,
		"5" => 5,
		"6" => 6,
		"7" => 7,
		"8" => 8,
		"9" => 9,
		"a" => 10,
		"b" => 11,
		"c" => 12,
		"d" => 13,
		"e" => 14,
		"f" => 15
	];
	public static function hex2Dec( hex:String ) {
		var dec = 0;
		for( i in 0...hex.length ) {
			dec *= 16;
			final char = hex.charAt( i ).toLowerCase();
			if( !hex2DecMap.exists( char )) throw 'Error: illegal char in hex value $hex';
			dec += hex2DecMap[char];
		}
		return dec;
	}

}