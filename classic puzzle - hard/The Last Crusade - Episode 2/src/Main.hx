import BreadthFirstSearch;
import CheckRotations;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.int;
import Std.parseInt;
import data.Location;
import parser.ParseLocation;

using Lambda;

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final w = parseInt( inputs[0] ); // number of columns.
		final h = parseInt( inputs[1] ); // number of rows.
		final lines = [for( i in 0...h ) readline().split(" ").map( a -> parseInt( a ))]; // represents a line in the grid and contains W integers. Each integer represents one room of a given type.
		final exit = ( h - 1 ) * w + parseInt( readline() ); // the coordinate along the X axis of the exit (not useful for this first mission, but must be read).

		// printErr( 'w $w h $h' );
		// printErr( inputs.join(" "));
		// printErr( lines.map( line -> line.join(" ")).join( "\n") );
		// printErr( exit );

		var cells = lines.flatMap( line -> line.map( cell -> int( abs( cell ))));
		final locked = lines.flatMap( line -> line.map( cell -> cell < 0 ));
		
		final tunnel = new Tunnel( locked, w );
		while( true ) {
			final indy = parseLocation( readline(), w );
			final r = parseInt( readline()); // the number of rocks currently in the grid.
			final rocks = [for( i in 0...r ) parseLocation( readline(), w )];
			
			final action = process( indy, rocks, tunnel, cells, exit );
			print( action );

		}

	}

	static inline function process( indy:Location, rocks:Array<Location>, tunnel:Tunnel, cells:Array<Int>, exit:Int ) {

		// printErr( tunnel.cellsToString( tunnel.combineWithLocked( cells, locked )) );
		// printErr( 'Indy ${tunnel.locationToString( indy )}' );
		// printErr( 'Rocks\n' + rocks.map( rock -> tunnel.locationToString( rock )).join( "\n" ));
		
		final paths = breadthFirstSearch( indy, rocks, tunnel, cells, exit );
		final validPaths = paths.filter( path -> checkRotations( tunnel, path ));
		if( validPaths.length == 0 ) throw "Error: no path found.";
		validPaths.sort(( a, b ) -> a.length - b.length );
		final path = validPaths[0];
		
		final action = tunnel.getNextAction( cells, path );
		return action;
	}

	
}
