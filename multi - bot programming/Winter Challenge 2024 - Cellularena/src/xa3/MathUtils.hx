package xa3;

import Math.abs;

using Lambda;

class MathUtils {
	public static inline var INTEGER_MAX_VALUE = 2147483647;
	public static inline var INTEGER_MIN_VALUE = -2147483648;
	
	extern public static inline function abs( v:Int ) return v < 0 ? -v : v;
	extern public static inline function avg( a:Array<Int> ) return sum( a ) / a.length;
	public static function dist2( x1:Int, y1:Int, x2:Int, y2:Int ) return ( x1 - x2 ) * ( x1 - x2 ) + ( y1 - y2 ) * ( y1 - y2 );

	public static function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
	extern public static inline function manhattanDist( v1:Int, v2:Int ) return abs( v2 - v1 );
	public static function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
	extern public static inline function sum( a:Array<Int> ) return a.fold(( v, sum ) -> sum + v, 0 );

	/**
	 * Returns the linear interpolation of two numbers if `ratio`
	 * is between 0 and 1, and the linear extrapolation otherwise.
	 *
	 * Examples:
	 *
	 * ```haxe
	 * lerp(a, b, 0) = a
	 * lerp(a, b, 1) = b
	 * lerp(5, 15, 0.5) = 10
	 * lerp(5, 15, -1) = -5
	 * ```
	 */
	public static inline function lerp( a:Float, b:Float, ratio:Float ) {
		return a + ratio * ( b - a );
	}

	/**
	 * Remaps a number from one range to another.
	 *
	 * @param 	value	The incoming value to be converted
	 * @param 	start1 	Lower bound of the value's current range
	 * @param 	stop1 	Upper bound of the value's current range
	 * @param 	start2  Lower bound of the value's target range
	 * @param 	stop2 	Upper bound of the value's target range
	 * @return The remapped value
	 */
	 public static function remapToRange( value:Float, start1:Float, stop1:Float, start2:Float, stop2:Float )	{
		return start2 + ( value - start1 ) * (( stop2 - start2 ) / ( stop1 - start1 ));
	}
}
