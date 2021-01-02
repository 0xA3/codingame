import haxe.Int64;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		
		final result = process2( n );
		print( result );
	}

	//      1/n = 1/x + 1/y
	//      1/n = 1/(a+n) + 1/(b+n)         | let x := a+n and y := b+n
	//      1/n = (b+n+a+n)/(a+n)(b+n)
	//      (a+n)(b+n) = n(b+n+a+n)
	//      ab+an+bn+n² =  bn+n²+an+n²
	//      ab = n²

	//      if a is divisor of n² then 1/n = 1/(a+n) + 1/(b+n) with b = n²/a
	static function process( n:Int ) {

		final results:Array<String> = [];
		for( i in 1...n + 1 ) {
			if(( n * n ) % i == 0) results.push ( '1/$n = 1/${ n * n / i + n } + 1/${ i + n}' );
		}
		
		return results.join( "\n" );
	}

	// 1/n = 1/x + 1/y
	// 1/n - 1/y = 1/x

	// Simplify 1/y - 1/n
	// https://www.mathway.com/popular-problems/Algebra/205252

	// To write 1/y as a fraction with a common denominator, multiply by n/n
	// To write 1/n as a fraction with a common denominator, multiply by y/y
	
	// 1/y * n/n - 1/n * y/y
	
	// Write each expression with a common denominator of ny, by multiplying each by an appropriate factor of 1

	// (y - n)/(yn) = 1/x
	// unit fraction implies (y-n)|(yn)
	static function process2( n:Int ) {
		
		final results:Array<String> = [];
		
		for( y in n + 1...2 * n + 1 ) {
			final numerator = y - n;
			final denominator = y * n;

			if( denominator % numerator == 0 ) {
				results.push( '1/$n = 1/${denominator / numerator} + 1/$y' );
			}
		}
		
		return results.join( "\n" );
	}

}
