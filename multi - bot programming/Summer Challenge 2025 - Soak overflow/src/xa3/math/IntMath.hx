package xa3.math;

class IntMath {
	extern public static inline function min( a:Int, b:Int ) return a < b ? a : b;
	extern public static inline function max( a:Int, b:Int ) return a > b ? a : b;
	extern public static inline function abs( v:Int ) return v < 0 ? -v : v;
}