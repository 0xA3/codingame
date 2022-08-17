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

Input
ABCDefghIJKLmnop

Expected output
ABCDIJKL
efghmnop


02 Test 2
Input
LpSOFdpgO

Expected output
LSOFO
pdpg


03 Test 3
Input
UPPERCASE
Expected output
UPPERCASE


04 Test 4
Input
aaaaaaaaa

Expected output

aaaaaaaaa
*/

function main() {

	final t = readline().split( "" );
	
	var upper = "";
	var lower = "";
	for( char in t ) {
		if( char.charCodeAt( 0 ) < 97 ) upper += char else lower += char;
	}
	
	print( '$upper\n$lower' );
}
