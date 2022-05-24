package xa3;

class MathUtils {
	public static inline function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
	public static inline function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
	public static inline function abs( v:Int ) return v >= 0 ? v : -v;
}
