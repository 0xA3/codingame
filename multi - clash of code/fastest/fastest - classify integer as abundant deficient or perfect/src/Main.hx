import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

/*
Classify given integer as abundant, deficient, or perfect.

Abundant numbers are less than the sum of all their proper divisors.
Deficient numbers are greater than the sum of their proper divisors.
Perfect numbers equal the sum of their proper divisors.
Note that while a number divides itself, it is not considered a proper divisor. One is defined as a divisor.

Input
15

Output
deficient
*/

function main() {

	final n = parseInt( readline());
	
	final properDivisors = [for( i in 1...n ) if( n % i == 0 ) i];
	final sum = properDivisors.fold(( v, sum ) -> sum + v, 0 );
	
	if( n < sum ) print( "abundant" );
	else if( n > sum ) print( "deficient" );
	else print( "perfect" );
}
