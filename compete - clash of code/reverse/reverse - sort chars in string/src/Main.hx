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
CBA		ABC

02 Test 2
Input	Expected output
AhYKi	AKYhi

03 Test 3
Input	Expected output
3#4#15	##1345

04 Test 4
Input	Expected output
[#*9Ea	#*9E[a

*/

function main() {

	final n = readline().split( "" );
	n.sort(( a, b ) -> a.charCodeAt( 0 ) - b.charCodeAt( 0 ));
	
	print( n.join( "" ));
}
