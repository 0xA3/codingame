package xa3;

class MathUtils {
	public static inline var INTEGER_MAX_VALUE = 2147483647;
	public static inline var INTEGER_MIN_VALUE = -2147483648;
	
	public static function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
	public static function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;

	public static function dist2( x1:Int, y1:Int, x2:Int, y2:Int ) return ( x1 - x2 ) * ( x1 - x2 ) + ( y1 - y2 ) * ( y1 - y2 );
}
