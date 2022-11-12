import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;
import xa3.geom.Rectangle;

/*
Peter wants to paint and fill two rectangles with the same color on the same wall. He needs to know the filling area in order to buy the necessary paint buckets. Peter does not want to double-paint overlapping regions.

Input
2 3 4 5
8 1 3 2

Output
26
*/

class Main {
	
	static function main() {
		
		final r1 = parse();
		final r2 = parse();

		print( Rectangle.area( r1 ) + Rectangle.area( r2 ) - Rectangle.overlappingArea( r1, r2 ));
	}

	static function parse() {
		final inputs = readline().split(" ");
		final r = [];
		for( i in 0...4 ) r[i] = parseFloat( inputs[i] );
		
		return [r[0], r[1], r[0] + r[2], r[1] + r[3]];
	}
}
