import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.pow;
import Std.parseInt;
import Std.string;

/*
Consider a string representing a positive integer n and another positive integer k.

You have to :
a. Reverse n's digits.
b. Raise every digit to the k-th power.
c. Concatenate all those string number representations and output the result r.

Examples :

1. If n = 12345 and k= 2 :
a. First, we consider n's reverse digits : [5, 4, 3, 2, 1].
b. Then we compute every k-th power: [5^2, 4^2, 3^2, 2^2, 1^2] = [25, 16, 9, 4, 1].
c. Finally, we concatenate and output the result r = 2516941.

2. If n = 7112236 and k= 3 then r = 216278811343.

Input
12345 2

Output
2516941

*/

function main() {

	final x = readline().split(" ");
	final n = x[0].split( "" ).map( s -> parseInt( s ));
	final k = parseInt( x[1] );
	n.reverse();
	final n2 = n.map( v -> string( pow( v, k ) )).join( "" );
	
	print( n2 );
}
