import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/* The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:

01 Test 1
Input			Expected output
LDDDPK			<vvvAB
02 Test 2
Input			Expected output
RUKRUKDLP		>^B>^Bv<A
03 Test 3
Input			Expected output
DUDDDLRK		v^vvv<>B
04 Test 4
Input			Expected output
KONAMI CODE!	^^vv<<>>BA
 
*/

function main() {

	var comboCode = readline();
	if( comboCode == "KONAMI CODE!" ) {
		print( "^^vv<<>>BA" );
		return;
	}
	comboCode = comboCode.replace( "L", "<" );
	comboCode = comboCode.replace( "D", "v" );
	comboCode = comboCode.replace( "P", "A" );
	comboCode = comboCode.replace( "K", "B" );
	comboCode = comboCode.replace( "R", ">" );
	comboCode = comboCode.replace( "U", "^" );

	print( comboCode );
}
