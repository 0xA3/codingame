import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.MathUtils;
/*
A prime is said to be weak if it smaller than the average of the two surrounding primes.

For example, 13 is a weak prime since it is less than the average of the two surrounding primes 11 and 17.

A prime is said to be balanced if it is the average of the two surrounding primes, i.e., it is at equal distance from previous prime and next prime.

Otherwise the prime is known as strong.

Input
13

Output
WEAK
*/


function main() {

	final n = parseInt( readline());
	print( process( n ));
}

function process( n:Int ) {

	var previousPrime = n - 1;
	while( !previousPrime.isPrime() ) previousPrime--;
	
	var nextPrime = n + 1;
	while( !nextPrime.isPrime() ) nextPrime++;
	
	final avg = ( previousPrime + nextPrime ) / 2;

	printErr( 'n $n  prev $previousPrime  next $nextPrime  avg $avg' );

	return n < avg ? "WEAK" : n > avg ? "STRONG" : "BALANCED";
}
