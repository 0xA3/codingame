using Lambda;

class ArrayUtils {

	extern public static inline function sum( a:Array<Int> ) return a.fold(( v, sum ) -> sum + v, 0 );
}