import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils.divisorSum;

/*
Given 2 integers a,b output if they are amicable numbers.

Two numbers are amicable if the sum of divisors of one number are equal to the other number.

For example:
number 220 has divisors 1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110 which sum up to 284
number 284 has divisors 1, 2, 4, 71, 142 which sum up to 220

Therefore numbers 220 and 284 are amicable numbers

*/

function main() {

	final inputs = readline().split(" ");
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );
	
	if( divisorSum( a ) == b ) print( "Amicable" );
	else print( "Not amicable" );
}
