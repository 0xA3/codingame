import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static inline var SIZE = 16;

	static function main() {
		final lines = [for( i in 0...16 ) readline()];

		final result = process( lines );
		print( result );
	}

	static function process( lines:Array<String> ) {
		
		final grid = new Grid( lines, SIZE );
		// trace( "\n" + grid );

		grid.fill();
		
		final molehillsInside = grid.countMolehillsInside();

		return molehillsInside;
	}

}
