import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.parseFloat;
import xa3.MathUtils;
import xa3.MathUtils.eval;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Mc Chicken sells nuggets in packs of 6, 9 and 20. Given a number of nuggets N, you have to print - if possible - the largest number of packs that Mc Chicken has to sell to complete the order. If it's not possible, print NONE

Input
5

Output
NONE
*/

function main() {

	final n = parseInt( readline());
	// packs = 6a + 9b + 20c

	final packCombinations = [];
	for( a in 0...int( n / 6 )) {
		for( b in 0...int( n / 9 )) {
			for( c in 0...int( n / 20 )) {
				if( 6 * a + 9 * b + 20 * c == n ) packCombinations.push( a + b + c );
			}
		}
	}

	if( packCombinations.length == 0 ) print( "NONE" );
	else {
		packCombinations.sort(( a, b ) -> b - a );
		print( packCombinations[0] );
	}
}
