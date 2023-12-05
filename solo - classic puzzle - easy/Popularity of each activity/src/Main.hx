import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {
	final height = parseInt( readline() );
	final rows = [for( _ in 0...height ) readline()];
	
	final result = process( rows );
	print( result );
}

function process( rows:Array<String> ) {
	final attendeesOfAreas = getAttendeesOfAreas( rows );
	final total = attendeesOfAreas.fold(( row, sum ) -> sum + row.fold(( area, sum ) -> sum + area, 0 ), 0 );
	final percentages = attendeesOfAreas.map( row -> row.map( v -> Math.round( v / total * 100 )));
	final outputs = percentages.map( row -> row.map( v -> {
		final stringValue = Std.string( v );
		final stringLength = stringValue.length;
		return [for( _ in 0...3 - stringLength ) "_"].join( "" ) + stringValue + "%";
	} ));

	final output = '$total attendees\n' + outputs.map( row -> row.join(" ")).join( "\n" );

	return output;
}

function getAttendeesOfAreas( rows:Array<String> ) {
	final areas:Array<Array<Int>> = [];
	var xAreas = [0, 0, 0];
	for( y in 0...rows.length ) {
		final parts = rows[y].split( ":" );
		for( x in 0...parts.length ) {
			final cells = parts[x].split( "" ).filter( s -> s == "*" );
			xAreas[x] += cells.length;
		}
		if( rows[y].charAt( 0 ) == "-" ) {
			areas.push( xAreas );
			xAreas = [0, 0, 0];
		}
	}
	areas.push( xAreas );

	return areas;
}