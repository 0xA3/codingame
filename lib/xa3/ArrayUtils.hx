package xa3;

import Std.int;
import xa3.MathUtils;
import xa3.StringUtils.repeat;

class ArrayUtils {

	extern public static inline function alignRight( a:Array<String> ) {
		final m = maxLength( a );
		return a.map( s -> repeat(" ", m - s.length ) + s );
	}
	
	extern public static inline function alignCenter( a:Array<String> ) {
		final center = int( maxLength( a ) / 2 );
		return a.map( s -> repeat(" ", center - int( s.length / 2 )) + s );
	}

	extern public static inline function fact( a:Array<Int> ) {
		var fact = 1;
		for( v in a ) fact *= v;
		return fact;
	}
	
	extern public static inline function ffact( a:Array<Float> ) {
		var fact = 1.0;
		for( v in a ) fact *= v;
		return fact;
	}
	
	extern public static inline function max( a:Array<Int> ) {
		var m = 0;
		for( v in a ) m = MathUtils.max( m, v );
		return m;
	}
	
	extern public static inline function fmax( a:Array<Float> ) {
		var m = 0.0;
		for( v in a ) m = Math.max( m, v );
		return m;
	}

	extern public static inline function maxLength( a:Array<String> ) {
		var m = 0;
		for( s in a ) m = MathUtils.max( m, s.length );
		return m;		
	}

	extern public static inline function min( a:Array<Int> ) {
		var m = 0;
		for( v in a ) m = MathUtils.min( m, v );
		return m;
	}
	
	extern public static inline function fmin( a:Array<Int> ) {
		var m = 0.0;
		for( v in a ) m = Math.min( m, v );
		return m;
	}

	extern public static inline function sum( a:Array<Int> ) {
		var sum = 0;
		for( v in a ) sum += v;
		return sum;
	}
	
	extern public static inline function fsum( a:Array<Float> ) {
		var sum = 0.0;
		for( v in a ) sum += v;
		return sum;
	}
}