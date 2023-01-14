import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

/*
For every x in the provided list, output 'T' if x is divisible by all given n primes p, else output 'F'.

Input
2
10
3 7
998 575 987 459 54 21 63 758 132 395

Output
FFTFFTTFFF

*/

function main() {

	final n = parseInt( readline());
	final m = parseInt( readline());
	final inputs = readline().split(' ');
	final primes = [for( i in 0...n ) parseInt( inputs[i] )];
	final inputs = readline().split(' ');
	final xs = [for( i in 0...m ) parseInt( inputs[i] )];

	final outputs = xs.map( x -> {
		final divisibles = primes.filter( prime -> x % prime == 0 );
		return divisibles.length == primes.length ? "T" : "F";
	});
	
	print( outputs.join( "" ));
}
