package xa3.math;

class IntMath {
	public static function min( a:Int, b:Int ) return a < b ? a : b;
	public static function max( a:Int, b:Int ) return a > b ? a : b;
	public static function abs( v:Int ) return v < 0 ? -v : v;
}