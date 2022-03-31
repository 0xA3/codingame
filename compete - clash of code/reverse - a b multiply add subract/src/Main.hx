import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.string;

using Lambda;
using StringTools;

/*
The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:
01 Test 1
Input Expected output
8 2   16106

02 Test 2
Input Expected output
5 4   2091

03 Test 3
Input Expected output
9 6   54153

04 Test 4
Input Expected output
20 3  602317
*/

function main() {

	final inputs = readline().split(' ');
	final a = parseInt( inputs[0] );
	final b = parseInt( inputs[1] );
	
	print( '${a * b}${a + b}${a - b}' );
}

