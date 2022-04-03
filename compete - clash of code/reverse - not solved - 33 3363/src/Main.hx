import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import Std.string;

using Lambda;
using StringTools;

/* The game mode is REVERSE: You do not have access to the statement. You have to guess what to do by observing the following set of tests:

01 Test 1
Input		Expected output
00			000

02 Test 2
Input		Expected output
33			3363

03 Test 3
Input		Expected output
2001		2044101

04 Test 4
Input		Expected output
12345678	1234477757445678

*/
 
function main() {

	final nums = readline().split( "" ).map( s -> parseInt( s ));

	final nums1 = nums.slice( 0, int( nums.length / 2 ));
	final nums2 = nums.slice( int( nums.length / 2 ));
	var output = nums1.join( "" );


	
	print( output );
}
