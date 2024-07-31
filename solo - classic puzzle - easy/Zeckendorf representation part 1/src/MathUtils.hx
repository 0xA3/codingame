import haxe.Int64;

using Lambda;

class MathUtils {
	
	public static function sum( a:Array<Int64> ) {
		return a.fold(( v, sum ) -> sum + v, 0i64 );
	}
}