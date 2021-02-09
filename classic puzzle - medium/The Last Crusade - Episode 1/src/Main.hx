import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static var posMap = [
		"TOP" => 0,
		"LEFT" => 1,
		"RIGHT" => 2
	];

	static function main() {
		
		final inputs = readline().split(' ');
		final w = parseInt( inputs[0] ); // number of columns.
		final h = parseInt( inputs[1] ); // number of rows.
		final lines = [for( i in 0...h ) readline().split(" ").map( a -> parseInt( a ))]; // represents a line in the grid and contains W integers. Each integer represents one room of a given type.
		final exit = parseInt( readline() ); // the coordinate along the X axis of the exit (not useful for this first mission, but must be read).

		// printErr( inputs.join(" "));
		// printErr( lines.map( line -> line.join(" ")).join( "\n") );
		// printErr( exit );
		
		final tunnel = new Tunnel( lines, exit );

		while( true ) {
			var inputs = readline().split(' ');
			final xi = parseInt( inputs[0] );
			final yi = parseInt( inputs[1] );
			final pos = posMap[inputs[2]];

			// printErr( inputs.join(" "));
		
			final result = tunnel.next( xi, yi, pos );
			print( result );
		}
	}

}
