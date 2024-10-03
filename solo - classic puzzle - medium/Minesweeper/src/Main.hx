import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	while( true ) {
		final grid = [for( i in 0...16 ) readline().split( " " )];
		final output = process( grid );

		print( output );
	}
}

function process( grid:Array<Array<String>> ) {

	printErr( grid.map( row -> row.join(" ")).join( "\n" ));

	final x = Std.random( 30 );
	final y = Std.random( 16 );

	return '$x $y';
}
