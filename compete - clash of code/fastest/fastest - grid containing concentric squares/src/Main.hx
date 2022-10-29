import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils.abs;
import xa3.MathUtils.max;

/*
Print a grid containing concentric squares around a center point, with the following rules:
1. Each squares are separated by 1 character from each other.
2. The squares are hollow, one-character thick, and they gradually increase in size, starting from 3x3, to 7x7, 11x11, 15x15, and so on.
3. In the grid, empty spaces are represented by a space character, while spaces occupied by a square are represented by a #.
3. The program is given the size of the grid (width and height) and the coordinates of the center point of the squares (x, y) as input.

Notes:
1. The grid coordinates are zero-indexed, meaning that they start at (0, 0) instead of (1, 1).
2. Positive-y values go downwards instead of upwards; the coordinate (0, 0) represents the top-left corner of the grid.
3. The center of the rings can be located outside the grid!

Input
7 7
1 1

Output
### # #
# # # #
### # #
    # #
##### #
      #
#######

*/

function main() {

	final inputs = readline().split(" ");
	final width = parseInt( inputs[0] );
	final height = parseInt( inputs[1] );
	
	final inputs = readline().split(" ");
	final cx = parseInt( inputs[0] );
	final cy = parseInt( inputs[1] );

	for( y in 0...height ) {
		final line = [for( x in 0...width ) {
			final dx = abs( cx - x );
			final dy = abs( cy - y );
			final max = max( dx,  dy );
			max % 2 == 1 ? "#" : " ";
		}].join( "" );
		print( line );
	}

}
