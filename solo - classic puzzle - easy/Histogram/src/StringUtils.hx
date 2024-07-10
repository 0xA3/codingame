class StringUtils {
	
	extern public static inline function repeat( s:String, n:Int ) {
		if( n == 0 ) return "";
		
		final buf = new StringBuf();
    	for ( _ in 0...n ) buf.add( s );
    	return buf.toString();
	}
}