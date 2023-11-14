class StringUtils {
	
	extern public static inline function repeat( s:String, n:Int ) {
		if( n == 0 ) return "";
		
		final buf = new StringBuf();
    	for ( _ in 0...n ) buf.add( s );
    	return buf.toString();
	}

	public static function mapReplace( s:String, map:Map<String, String> ) {
		return [for( i in 0...s.length ) {
			final char = s.charAt( i );
			map.exists( char ) ? map[char] : char;
		}].join( "" );
	}

}