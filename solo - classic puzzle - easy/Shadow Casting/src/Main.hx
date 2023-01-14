import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final input = [for( i in 0...n ) readline().split( "" )];
		
	final result = process( input );
	print( result );
}

function process( input:Array<Array<String>> ) {
	
	final maxLength = input.fold(( line, max ) -> line.length > max ? line.length : max, 0 );
	final grid:Array<Array<String>> = [for( _ in 0...input.length + 2 ) [for( _ in 0...maxLength + 2 ) " "]];

	for( y in 0...input.length ) { for( x in 0...input[y].length ) {
		if( input[y][x] != " " ) {
			grid[y][x] = input[y][x];
			grid[y + 1][x + 1] = "-";
			grid[y + 2][x + 2] = "`";
		}
	}}

	final output = grid.map( line -> line.join( "" ).rtrim() ).join( "\n" );
	// trace( "\n" + output );
	return output;
}
