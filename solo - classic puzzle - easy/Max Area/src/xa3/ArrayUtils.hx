package xa3;

import xa3.MathUtils;

class ArrayUtils {

	extern public static inline function maxIndex( a:Array<Int> ) {
		var m = 0;
		var index = 0;
		for( i in 0...a.length ) {
			var v = a[i];
			if( v > m ) {
				m = v;
				index = i;
			}
		}
		return index;
	}
	
	extern public static inline function max( a:Array<Int> ) {
		var m = 0;
		for( v in a ) m = MathUtils.max( m, v );
		return m;
	}
}