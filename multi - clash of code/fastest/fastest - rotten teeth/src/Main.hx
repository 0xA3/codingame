import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

/*
You are given a patient. Every patient has a unique amount of teeth. Each tooth is either healthy 1, rotten 0 or pulled out -. Pull out any rotten teeth you find.
Input
Line 1: Integer N for the amount of rows of teeth in a mouth
Next N lines: Rows of teeth

Output
Output the entire mouth of the patient after you have pulled out all the rotten teeth.
*/

function main() {

	final n = parseInt( readline());
	final rows = [for( _ in 0...n ) readline()];

	for( i in 0...n ) print( rows[i].replace( "0", "-" ));
}
