package xa3;

import xa3.MathUtils.INTEGER_MIN_VALUE;

class ArrayUtils {
	
	extern public static inline function max( a:Array<Int> ) {
		var m = INTEGER_MIN_VALUE;
		for( v in a ) m = MathUtils.max( m, v );
		return m;
	}
}