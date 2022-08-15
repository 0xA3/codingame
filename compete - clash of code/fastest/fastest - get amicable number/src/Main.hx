import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
Amicable numbers are two numbers such as the sum of the proper divisors of each is equal to the other number.
For example 220 and 284 are amicable because:
sum(divisors(220)) = 1+2+4+5+10+11+20+22+44+55+110 = 284
sum(divisors(284)) = 1+2+4+71+142 = 220

Providing a list of integers you need to write a script that outputs their amicable numbers if any.
*/

function main() {

	final n = parseInt( readline());
	final values = readline().split( " " ).map( s -> parseInt( s ));

	final outputs = [];
	for( value in values ) {
		final divisorSum = getDivisorSum( value );
		final reverseDivisorSum = getDivisorSum( divisorSum );
		if( reverseDivisorSum == value ) outputs.push( divisorSum )
		else outputs.push( -1 );
		// printErr( 'value $value  divisorSum $divisorSum  reverse $reverseDivisorSum' );
	}
	print( outputs.join( "\n" ));
}

function getDivisorSum( v:Int ) {
	final divisors = [for( i in 1...int( v / 2 ) + 1 ) if( v % i == 0 ) i];
	// printErr( 'v $v  divisors $divisors' );
	return divisors.fold(( d, sum ) -> sum + d, 0 );
}
