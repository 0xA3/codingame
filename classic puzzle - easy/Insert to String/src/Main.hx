import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final s = readline();
	final changeCount = parseInt( readline() );
	final rawChanges = [for( _ in 0...changeCount ) readline()];

	final result = process( s, rawChanges );
	print( result );
}

function process( s:String, rawChanges:Array<String> ) {

	var lines = s.split( "\\n" );
	// printErr( "\n" + lines.join( "\n" ));

	final changes:Array<Change> = rawChanges.map( rawChange -> {
		final parts = rawChange.split( "|" );
		return { line: parseInt( parts[0] ), column: parseInt( parts[1] ), text: parts[2].replace( "\\n", "\n" ) }
	});

	changes.sort(( a, b ) -> {
		if( a.line < b.line ) return 1;
		if( a.line > b.line ) return -1;
		if( a.column < b.column ) return 1;
		if( a.column > b.column ) return -1;
		return 0;
	});

	for( change in changes ) {
		final line = lines[change.line];
		lines[change.line] = line.substr( 0, change.column ) + change.text + line.substr( change.column );
	}

	return lines.join( "\n" );
}

typedef Change = {
	final line:Int;
	final column:Int;
	final text:String;
}