import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;
/*
The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:

01 Test 1
Input					Expected output
80 85 90 100 105 115	PUZdis

02 Test 2
Input					Expected output
90 98 105 67 69 75		ZbiCEK

03 Test 3
Input					Expected output
91 82 69 65 68 93		[READ]


04 Test 4

Input
65 67 68 69 70 80 81 82 83 84 85 100 101 102 103 104 105 106 107 108 109 110 111 112 113 120 121 122 123 124 125 126

Expected output
ACDEFPQRSTUdefghijklmnopqxyz{|}~
*/

function main() {

	final string = readline();
	final ascii = string.split(" ");
	final chars = [for( a in ascii ) String.fromCharCode( parseInt( a ))];
	print( chars.join( "" ));
}
