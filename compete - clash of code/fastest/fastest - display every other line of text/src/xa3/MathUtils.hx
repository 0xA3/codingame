package xa3;

import Math.sqrt;
import Std.int;

class MathUtils {
	
	public static function log( x:Float, base:Float ) return int( Math.log( x ) / Math.log( base ));

	public static function isPrime( n:Int ) {
		if( n <= 1 ) return false;
		for( d in 2...int( sqrt( n )) + 1 ) {
			if( n % d == 0 ) return false;
		}
		return true;
	}
}