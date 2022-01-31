class Converter {

	public static inline function separate( s:String, charMap:Map<String, Int> ) return s.split( "" ).map( s -> charMap[s] );
	public static inline function combine( a:Array<Int>, charCodeMap:Map<Int, String> ) return a.map( v -> charCodeMap[v] ).join( "" );
	
	public static inline function toCharcodes( s:String ) return s.split( "" ).map( s -> s.charCodeAt( 0 ));
}