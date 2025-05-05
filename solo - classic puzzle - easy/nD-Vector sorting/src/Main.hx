import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;


function main() {

	final d = parseInt( readline() );
	final n = parseInt( readline() );
	final ords = readline().split(" ").map( s -> parseInt( s ) - 1 );
	final vectors = [for( _ in 0...n ) readline().split(" ").map( s -> parseInt( s ))];

	final result = process( d, ords, vectors );
	print( result );
}

function process( dimensions:Int, ords:Array<Int>, vectors:Array<Array<Int>> ) {
	final iVectors = [for( i in 0...vectors.length ) new IndexedVector( i, vectors[i] )];
	IndexedVector.sort( iVectors, ords );

	final result = [for( i in 0...vectors.length ) iVectors[i].index + 1].join( " " );
	
	// for( iVector in iVectors ) printErr( '$iVector' );
	// printErr( result );

	return result;
}
