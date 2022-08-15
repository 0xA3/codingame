import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

/*
Help the robot reach his destination.
Given the number of tiles N, calculate the minimum number of jumps required for the robot to reach his destination.

Here are the constraints:
1) The robot starts at 1st tile.
2) The destination is at Nth tile.
3) The robot can jump up to 4 tiles at any point (say current position is tile 2, then it can reach tile 3, 4, 5 or 6 in the next jump).
*/

function main() {

	final n = parseInt( readline());
	final jumps = Math.ceil(( n - 1 ) / 4 );
	print( jumps );
}
