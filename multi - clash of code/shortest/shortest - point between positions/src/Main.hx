import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

import Std.parseInt;

/*
Your program must find the point that is exactly between two other points.

You are given the coordinates (x, y) of two points which bind a line segment.
The midpoint of this line segment is the target point.

Be careful with float numbers and use . as a decimal mark.
*/

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final x1 = parseInt( inputs[0] );
		final y1 = parseInt( inputs[1] );
		
		final inputs = readline().split(' ');
		final x2 = parseInt( inputs[0] );
		final y2 = parseInt( inputs[1] );
		
		final x = x1 + ( x2 - x1 ) / 2;
		final y = y1 + ( y2 - y1 ) / 2;

		print( '$x $y' );
	}
}

