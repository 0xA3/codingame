import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:
01 Test 1
Input
Expected output
1
2 3
5
02 Test 2
Input
Expected output
5
2 3
5
7
9
11
13
03 Test 3
Input
Expected output
2
5 6
11
16
04 Test 4
Input
Expected output
6
10 10
20
30
40
50
60
70

*/

function main() {

	final n = parseInt( readline());
	final poly = readline().split(" ").map( v -> parseInt( v ));

	final start = poly[0] + poly[1];
	final nums = [for( i in 0...n ) start + i * poly[0]];
	
	print( nums.join( "\n" ));
}
