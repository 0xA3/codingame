import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using MagicSquare;

function main() {

	final rows = [for( _ in 0...3 ) readline()];
	final allButtonsPressed = readline().split( "" ).map( s -> parseInt( s ));
	
	final result = process( rows, allButtonsPressed );
	print( result );
}

function process( rows:Array<String>, allButtonsPressed:Array<Int> ) {

	var grid = rows.flatMap( line -> line.split(" ").map( s -> s == "*" ));
	for( button in allButtonsPressed ) grid = grid.press( button );
	
	for( button in 1...10 ) {
		final state = grid.press( button );
		if( state.isSolution() ) return button;
	}

	throw 'Error: no solution found';
}
