package algorithms;

import Std.int;
import haxe.ds.Vector;

class SieveOfAtkin {
	
	public static function create( limit:Int ) {
		final limitSqrt = int( Math.sqrt( limit )) + 1;
		final sieve = new Vector<Bool>( limit );
		var n = 0;
	 
		//prime start from 2, and 3
		sieve[2] = true;
		sieve[3] = true;
	 
		for( x in 1...limitSqrt ) {
			final xx = x*x;
			for( y in 1...limitSqrt ) {
				var yy = y*y;
				if (xx + yy >= limit) break;
				
				// first quadratic using m = 12 and r in R1 = {r : 1, 5}
				n = ( 4 * xx ) + yy;
				if( n <= limit && ( n % 12 == 1 || n % 12 == 5 )) {
					sieve[n] = !sieve[n];
				}
				// second quadratic using m = 12 and r in R2 = {r : 7}
				n = ( 3 * xx ) + yy;
				if( n <= limit && ( n % 12 == 7 )) {
					sieve[n] = !sieve[n];
				}
				// third quadratic using m = 12 and r in R3 = {r : 11}
				n = ( 3 * xx ) - yy;
				if( x > y && n <= limit && ( n % 12 == 11 )) {
					sieve[n] = !sieve[n];
				}
			}
		}
	 
		// false each primes multiples
		for( n in 5...limitSqrt ) {
			if( sieve[n] ) {
				final x = n * n;
				var i = x;
				while( i <= limit ) {
					sieve[i] = false;
					i += x;
				}
			}
		}
	 
		//primes values are the one which sieve[x] = true
		return sieve;
	}
}