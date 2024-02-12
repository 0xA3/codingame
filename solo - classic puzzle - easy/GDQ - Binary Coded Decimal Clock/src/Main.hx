import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using NumberConvert;
using StringUtils;

function main() {

	final time = readline();

	final result = process( time );
	print( result );
}

function process( time:String ) {
	final bin = time.split( ":" )
		.map( s -> s.split("")).flatten()
		.map( s -> parseInt( s ))
		.map( v -> v.toBin() )
		.map( s -> s.extend( 4 ))
		.slice( 1 );
	
	final rows = [for( i in 0...4 ) [for( column in bin ) column.charAt( i )]];
	final output = rows.map( row ->
		"|" +
		row.map( s -> ( s == "0" ? "_" : "#" ).repeat( 5 )).join( "|" ) +
		"|"
	).join( "\n" );

	return output;
}

