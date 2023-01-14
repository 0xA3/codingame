import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.sqrt;
import Std.parseInt;

/*
Given an integer a and an odd prime number p, the Legendre symbol (a / p) tells us whether or not a is a square modulo p.

The Legendre symbol is defined as:
0 if p divides a
1 if a is a square modulo p (in other words, if you can find an integer b such that p divides b² - a)
-1 otherwise

Write a program that computes Legendre symbols. You do not have to check if p is prime.


Examples:

(35/7) = 0 because 7 divides 35

(265/193) = 1 because 193 divides 74² - 265

(12/5) = -1 because 5 does not divide 12, and 12 is not a square modulo 5

*/

function main() {

	final a = parseInt( readline());
	final p = parseInt( readline());

	print( process( a, p ));
}

function process( a:Int, p:Int ) {
	if( a % p == 0 ) return 0;
	for( k in 0...100 ) if( sqrt( p * k + a ) % 1 == 0 ) return 1;
	
	return -1;
}
