package xa3;

import Math.sqrt;
import Std.int;
import Std.parseFloat;
import Std.parseInt;
import Std.string;

using Lambda;

class MathUtils {

	extern public static inline function abs( v:Int ) return v < 0 ? -v : v;
	extern public static inline function avg( a:Float, b:Float ) return ( a + b ) / 2;
	extern public static inline function clamp( v:Int, min:Int, max:Int ) return MathUtils.max( min, MathUtils.min( max, v ));
	extern public static inline function divisors( v:Int ) return [for( i in 1...int( v / 2 ) + 1 ) if( v % i == 0 ) i];
	extern public static inline function divisorSum( v:Int ) return divisors( v ).fold(( d, sum ) -> sum + d, 0 );
	extern public static inline function fclamp( v:Float, min:Float, max:Float ) return Math.max( min, Math.min( max, v ));
	extern public static inline function isEven( v:Int ) return v % 2 == 0;
	extern public static inline function isOdd( v:Int ) return v % 2 == 1;
	extern public static inline function log( x:Float, base:Float ) return int( Math.log( x ) / Math.log( base ));
	extern public static inline function manhattanDist( v1:Int, v2:Int ) return abs( v2 - v1 );
	extern public static inline function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
	extern public static inline function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
	extern public static inline function sign( v:Float ) return v < 0 ? -1 : v > 0 ? 1 : 0;
	extern public static inline function deg2Rad( v:Float ) return v / 180 * Math.PI;
	extern public static inline function rad2deg( v:Float ) return v / Math.PI * 180;

	extern public static inline function digitSum( v:Int ) {
		final digits = string( v ).split( "" ).map( s -> parseInt( s ));
		return digits.fold(( v, sum ) -> sum + v, 0 );
	}

	extern public static inline function factorial( v:Int ) {
		var f = 1;
		for( i in 1...v + 1 ) f *= i;
		return f;
	}
	
	extern public static inline function fibonacci( n:Int ) {
		if( n == 0 ) return 0;
		if( n == 1 ) return 1;
		var a = 0;
		var b = 1;
		for( _ in 0...n - 1 ) {
			final next = a + b;
			a = b;
			b = next;
		}
		return b;
	}

	extern public static inline function fibonacciSequence( a:Int, b:Int, n:Int ) {
			final sequence = [a, b];
		for( _ in 0...n ) sequence.push( sequence[sequence.length - 1] + sequence[sequence.length - 2] );
		return sequence;
	}

	public static function primes( n:Int ) {
		final sieve = algorithms.SieveOfAtkin.create( n );
		final primes = [for( i in 0...sieve.length ) if( sieve[i] ) i];
		return primes;
	}
	
	extern public static inline function greatestCommonFactor( a:Int, b:Int ) return greatestCommonDenominator( a, b );
	extern public static inline function greatestCommonDivisor( a:Int, b:Int ) return greatestCommonDenominator( a, b );

	extern public static inline function greatestCommonDenominator( a:Int, b:Int ) {
		var r = 0;
		while(( a % b ) > 0 ) {
			r = a % b;
			a = b;
			b = r;
		}
		return b;
	}

	public static function isPrime( n:Int ) {
		if( n <= 1 ) return false;
		for( d in 2...int( sqrt( n )) + 1 ) {
			if( n % d == 0 ) return false;
		}
		return true;
	}

	public static function primeFactors( n:Int ) {
		final primes = primes( int( n / 2 ));
	
		final factors = [];
		var n2 = n;
		while( n2 > 1 ) {
			var found = false;
			for( prime in primes ) {
				if( n2 % prime == 0 ) {
					factors.push( prime );
					n2 = int( n2 / prime );
					found = true;
					break;
				}
			}
			if( !found ) break;
		}
		return factors;
	}

	public static function round( v:Float, decimals = 0 ):Float {

		if( decimals == 0 ) return Math.round( v );

		final stringV = string( v );
		
		if( stringV.indexOf( "e" ) != -1 ) { // do standard rounding
			final pow = Math.pow( 10, decimals );
			return Math.round( v * pow ) / pow;

		} else { // do string rounding that also works with very big numbers and many decimals
			
			final stringVParts = stringV.split( "." );
			final sInt = stringVParts[0];
			final sDec = stringVParts.length == 2 ? stringVParts[1] : "";
			if( sDec.length <= decimals ) return v;
			
			final v = Std.parseInt( sDec.charAt( decimals ));
			if( v < 5 ) return parseFloat( '${sInt}.${sDec.substr( 0, decimals )}' );

			var sUp = "0";
			for( i in 1...decimals + 1 ) {
				final v = Std.parseInt( sDec.charAt( decimals - i ));
				final vUp = v + 1;
				if( vUp < 10 ) {
					sUp = string( vUp ) + sUp;
					return parseFloat( '${sInt}.${sDec.substring( 0 , decimals - i )}$sUp' );
				} else {
					sUp += "0";
				}
			}
			final int = parseFloat( sInt );
			final intUp = int < 0 ? int -1 : int + 1;
			return intUp;
		}
	}
}