using StringTools;

class StringUtils {
	
	extern public static inline function extend( s:String, length:Int ) return [for( _ in 0...length - s.length ) "0"].join( "" ) + s;

	extern public static inline function repeat( s:String, n:Int ) {
		if( n == 0 ) return "";
		
		final buf = new StringBuf();
    	for ( _ in 0...n ) buf.add( s );
    	return buf.toString();
	}
}