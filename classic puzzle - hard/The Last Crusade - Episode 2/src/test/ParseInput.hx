package test;
import Main;
import Math.abs;
import Std.int;
import Std.parseInt;
import Transformations;

using Lambda;
using StringTools;

@:access(Main)
function parseInput( input:String ) {
	
	final inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
	var inputs = inputLines[0].split(' ');
	final w = parseInt( inputs[0] ); // number of columns.
	final h = parseInt( inputs[1] ); // number of rows.
	final lines = [for( i in 0...h ) inputLines[i + 1].split(" ").map( a -> parseInt( a ))]; // represents a line in the grid and contains W integers. Each integer represents one room of a given type.
	final exit = ( h - 1 ) * w + parseInt( inputLines[1 + h] ); // the coordinate along the X axis of the exit (not useful for this first mission, but must be read).

	final cells = lines.flatMap( line -> line.map( cell -> int( abs( cell ))));
	final locked = lines.flatMap( line -> line.map( cell -> cell < 0 ));

	final location = inputLines[1 + h + 1];
	
	final start = Main.parseLocation( location, w );

	return { cells: cells, width: w, locked: locked, exit: exit, start: start };
}
