class Conversion {

	static inline var DELTA = 65;
	public static inline var MAX = 26;

	public static function toIndexes( s:String ):Array<Int> {
		return s.split( "" ).map( char -> ( char.charCodeAt( 0 ) - DELTA ) % MAX );
	}
	
	public static function toChars( a:Array<Int> ):String {
		return a.map( index -> String.fromCharCode(( index % MAX + DELTA ))).join( "" );
	}
}
