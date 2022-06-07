import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;
/*
The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:

01 Test 1
Input	Expected output
1		1

02 Test 2
Input	Expected output
2		3

03 Test 3
Input	Expected output
3		4

04 Test 4
Input	Expected output
5		7

05 Test 5
Input	Expected output
10		15

06 Test 6
Input	Expected output
25		37

07 Test 7
Input	Expected output
50		75

08 Test 8
Input	Expected output
100		150
*/

function main() {

	final n = parseInt( readline());
	
	print( Math.floor( n * 1.5 ) );
}
