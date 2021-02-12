import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.int;
import Std.parseInt;

using Lambda;

class Main {
	
	public static var posMap = [
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

		printErr( inputs.join(" "));
		printErr( lines.map( line -> line.join(" ")).join( "\n") );
		printErr( exit );
		
		final cells = lines.flatMap( line -> line.map( cell -> int( abs( cell ))));
		final locked = lines.flatMap( line -> line.map( cell -> cell < 0 ));
		final tunnel = new Tunnel( cells, w, locked, exit );
		
		while( true ) {
			final indy = parseLocation( readline());

			final r = parseInt( readline()); // the number of rocks currently in the grid.
			final rocks = [for( i in 0...r ) parseLocation( readline() )];
		
			final action = tunnel.getAction( indy, rocks );
			print( action );
		}

	}

	static function parseLocation( s:String ) {
		final inputs = readline().split(' ');
		final x = parseInt( inputs[0] );
		final y = parseInt( inputs[1] );
		final pos = posMap[inputs[2]];
		final l:Location = { x: x, y: y, pos: pos };
		return l;
	}


}

typedef Location = {
	final x:Int;
	final y:Int;
	final pos:Int;
}