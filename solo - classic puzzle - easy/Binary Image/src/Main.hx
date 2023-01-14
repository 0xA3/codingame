import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final h = parseInt( readline() );
	final rows = [for( i in 0...h ) readline().split(" ").map( s -> parseInt( s ))];
		
	final result = process( rows );
	print( result );
}

function process( inputRows:Array<Array<Int>> ) {
	
	final outputRows = inputRows.map( row -> {
		var color = 0;
		row.flatMap( v -> {
			color = 1 - color;
			decode( v, color );
		});
	});
	
	final length0 = outputRows[0].length;
	for( i in 1...outputRows.length ) if( outputRows[i].length != length0 ) return "INVALID";
	
	final output = outputRows.map( row -> row.join( "" )).join( "\n" );
	// trace( "\n" + output );
	
	return output;
}

function decode( length:Int, color:Int ) return [for( _ in 0...length ) color == 0 ? "O" : "."];
