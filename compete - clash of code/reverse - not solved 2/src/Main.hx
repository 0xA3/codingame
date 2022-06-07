import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final n = parseInt( readline());
	final inputs = readline().split(" ");
	final xs = [for( i in 0...n ) parseInt( inputs[i] )];
	
	final result = process( xs );

	print( result );
}

function process( xs:Array<Int> ) {
	
	xs.sort(( a, b ) -> a - b );


	return xs[0];
}
