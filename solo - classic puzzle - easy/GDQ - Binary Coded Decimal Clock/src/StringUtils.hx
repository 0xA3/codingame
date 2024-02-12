using StringTools;

class StringUtils {
	
	extern public static inline function extend( s:String, length:Int ) return [for( _ in 0...length - s.length ) "0"].join( "" ) + s;
}