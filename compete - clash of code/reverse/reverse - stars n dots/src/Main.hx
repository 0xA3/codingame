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

Expected output
...
*..
**.
***

02 Test 2
Input
4

Expected output
....
*...
**..
***.
****

03 Test 3
Input
5

Expected output
.....
*....
**...
***..
****.
*****

04 Test 4
Input
6

Expected output
......
*.....
**....
***...
****..
*****.
******

*/

function main() {

	final n = parseInt( readline());
	
	final rows = [];
	for( i in 0...n + 1 ) {
		final stars = [for( _ in 0...i ) "*"];
		final dots = [for( _ in i...n) "."];
		rows.push( stars.concat( dots ).join( "" ));
	}
	print( rows.join( "\n" ));
}
