package xa3;

import Std.int;

using StringTools;

class StringUtils {
	
	extern public static inline function count( s1:String, s2:String ) {
		var startIndex = -1;
		var n = 0;
		
		while( true ) {
			startIndex = s1.indexOf( s2, startIndex + 1 );
			if( startIndex == -1 ) break;
			n++;
		};
		return n;
	}

	extern public static inline function repeat( s:String, n:Int ) {
		if( n == 0 ) return "";
		return [for( _ in 0...n ) s].join( "" );
	}
}