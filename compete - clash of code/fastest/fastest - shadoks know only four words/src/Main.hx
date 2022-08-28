import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.NumberConvert;

/*
The shadoks only know four words: GA, BU, ZO and MEU.
They use these four words to say the numbers.
For example:
0 is GA, 1 is BU, 2 is ZO and 3 is MEU.
4 is BUGA, 5 is BUBU, 8 is ZOGA, 16 is BUGAGA and so on.

Input
0

Output
GA
*/

final words = ["GA", "BU", "ZO", "MEU"];

function main() {

	final n = parseInt( readline());
	final base4 = n.toBaseN( 4 );
	final nums = base4.split( "" ).map( s -> parseInt( s ));

	final output = nums.map( v -> words[v] ).join( "" );
	print( output );
}
