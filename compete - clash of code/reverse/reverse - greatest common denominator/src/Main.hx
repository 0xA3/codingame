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
Input	Expected output
18 30	6
		3 5

		02 Test 2
Input	Expected output
63 15	3
		21 5

03 Test 3
Input	Expected output
84 64	4
		21 16

04 Test 4
Input	Expected output
42 96	6
		7 16

05 Test 5
Input	Expected output
73 28	1
		73 28

06 Test 6
Input	Expected output
53 53	53
		1 1
*/


function main() {

	final inputs = readline().split(' ');
	final x = parseInt( inputs[0] );
	final y = parseInt( inputs[1] );

	final a = gcd( x, y );
	print( a );
	print( '${x / a} ${y / a}' );
}

function gcd( v1:Int, v2:Int ) {
	if( v2 == 0 ) return v1;
	else return gcd( v2, v1 % v2 );
}