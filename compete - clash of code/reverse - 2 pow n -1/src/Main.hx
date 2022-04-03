import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:
01 Test 1
Input Expected output
4     15

02 Test 2
Input Expected output
1     1

03 Test 3
Input Expected output
20    1048575

04 Test 4
Input Expected output
39    549755813887

05 Test 5
Input Expected output
2     3

06 Test 6
Input Expected output
9     511
*/

function main() {

	final n = parseInt( readline());
	
	print( '${Math.pow( 2, n) - 1}' );
}
