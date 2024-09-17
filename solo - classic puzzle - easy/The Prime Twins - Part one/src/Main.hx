import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.sqrt;
import Std.int;
import Std.parseInt;

function main() {

	final n = parseInt( readline());

	final result = process( n );
	print( result );
}

function process( n:Int ) {

	var i = n + 1;
	var firstPrime = 2;
	while( true ) {
		if( isPrime( i )) {
			if( i == firstPrime + 2 ) return '$firstPrime $i';
			 else firstPrime = i;
		}
		i++;
	}
	return "";
}

function isPrime( n:Int ) {
	if( n <= 1 ) return false;
	for( d in 2...int( sqrt( n )) + 1 ) {
		if( n % d == 0 ) return false;
	}
	return true;
}
