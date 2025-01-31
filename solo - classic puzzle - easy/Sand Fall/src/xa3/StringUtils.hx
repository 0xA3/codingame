package xa3;

class StringUtils {
	extern public static inline function repeat( s:String, n:Int ) {
		if( n == 0 ) return "";
		
		final buf = new StringBuf();
		for ( _ in 0...n ) buf.add( s );
		return buf.toString();
	}

	extern public static inline function isLowerCase( s:String ) {
		if( s.length != 1 ) throw 'Error: $s must be one char';
		final charCode = s.charCodeAt( 0 );
		return charCode >= "a".code && charCode <= "z".code;
	}

}
