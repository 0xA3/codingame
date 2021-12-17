import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;

var Z = "Z".charCodeAt( 0 );

function main() {

	final n = parseInt( readline() );
	final names = [for( i in 0...n ) readline()];

	final result = process( names );
	print( result );
}

function process( names:Array<String> ) {
	
	names.sort(( a, b ) -> return a < b ? -1 : 1 );
	
	final index = int( names.length / 2 );
	final before = names[index - 1];
	final after = names[index];
	
	// trace( 'before: $before, after: $after' );
	for( i in 0...before.length ) {
		for( o in 0...2 ) {
			final s = get( before, i, o );
			// trace( '$s >= $before && $s < $after: ${s >= before && s < after}' );
			if( s >= before && s < after ) return s;
		}
	}
	
	throw 'Error: no solution found';
}

function get( word:String, i:Int, o:Int ) {
	return word.substr( 0, i ) + String.fromCharCode( min( Z, word.charCodeAt( i ) + o ));
}
