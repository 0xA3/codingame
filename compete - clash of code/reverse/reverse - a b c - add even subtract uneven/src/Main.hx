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
3
2
4

Expected output
3


02 Test 2
Input
3
1
2

Expected output
-2


03 Test 3
Input
3
5
1

Expected output
-9


04 Test 4
Input
4
2
6

Expected output
12


05 Test 5
Input
121
214
573

Expected output
-480


06 Test 6
Input
0
0
0

Expected output
0

07 Test 7
Input
1000
1000
1000

Expected output
3000


08 Test 8
Input
998
999
997

Expected output
-998


09 Test 9
Input
1
22
333

Expected output
-312


10 Test 10
Input
285
1
9

Expected output
-295


11 Test 11
Input
4
468
962

Expected output
1434

*/

function main() {

	final a = parseInt( readline());
	final b = parseInt( readline());
	final c = parseInt( readline());
	
	final list = [a, b, c];
	var sum = 0;
	for( k in list ) {
		if( k % 2 == 0 ) sum += k;
		else sum -= k;
	}
	print( sum );
}
