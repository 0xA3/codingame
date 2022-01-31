class Converter {

	public static inline function toCharcodes( s:String ) return s.split( "" ).map( s -> s.charCodeAt( 0 ));
	public static inline function combine( a:Array<Int> ) return a.map( v -> Main.ALPHABET.charAt( v )).join( "" );
}