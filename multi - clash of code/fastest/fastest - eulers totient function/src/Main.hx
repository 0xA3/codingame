import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import xa3.MathUtils.greatestCommonDivisor;

/*
Euler's totient function Φ(n), also known as Euler's phi function, counts the number of integers between 1 and n inclusive which are coprime to n. Two numbers are coprime if their greatest common divisor equals 1.
https://cp-algorithms.com/algebra/phi-function.html

Input
10

Output
4

*/

function main() {

	final n = parseInt( readline());
	
	var sum = 0;
	for( i in 1...n + 1 ) {
		if( greatestCommonDivisor( i, n ) == 1 ) sum++;
	}
	
	print( sum );
}
