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
AAAABBBCCDAA

Expected output
AAAA BBB CC D AA


02 Test 2
Input
BbbABC

Expected output
B bb A B C


03 Test 3
Input
ZZOOZZPPAAA

Expected output
ZZ OO ZZ PP AAA


04 Test 4
Input
abcdefgh

Expected output
a b c d e f g h


05 Test 5
Input
AaBbCcDDdEe

Expected output
A a B b C c DD d E e
*/

function main() {

	final line = readline();
	var output = "";

	var currentChar = line.charAt( 0 );
	for( i in 0...line.length ) {
		if( line.charAt( i ) != currentChar ) {
			output += " ";
			currentChar = line.charAt( i );
		}
		output += line.charAt( i );
		
	}
	
	print( output );
}
