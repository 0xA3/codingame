import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.MathUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Factor Tree is one of the methods to perform the prime factorization of a number. In this method a number is factorized into branches until it cannot be factorized anymore. For example, for a number 180 its Factor Tree will be like:
2 90
2 2 45
2 2 3 15
2 2 3 3 5

Note that the last number is always being factorized into two factors and this process is repeated until there is nothing to factorize.

In this problem you are given a positive composite integer N. Your goal is to output its Factor Tree.

*/

function main() {

	final n = parseInt( readline());

	final factors = [];
	var n2 = n;
	while( n2 > 1 ) {
		var found = false;
		for( p in 2...n2 ) {
			if( n2 % p == 0 ) {
				factors.push( p );
				n2 = int( n2 / p );
				found = true;
				print( '${factors.join(" ")} $n2' );
				break;
			}
		}
		if( !found ) break;
	}
}
