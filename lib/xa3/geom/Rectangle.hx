package xa3.geom;

import Math.max;
import Math.min;

class Rectangle {
	
	extern public static inline function area( r:Array<Float> ) {
		return ( r[2] - r[0] ) * ( r[3] - r[1] );
	}
	
	extern public static inline function overlappingArea( r1:Array<Float>, r2:Array<Float> ) {
		final dx = min( r1[2], r2[2] ) - max( r1[0], r2[0] );
		final dy = min( r1[3], r2[3] ) - max( r1[1], r2[1] );
		
		return dx > 0 && dy > 0 ? dx * dy : 0;
	}
}