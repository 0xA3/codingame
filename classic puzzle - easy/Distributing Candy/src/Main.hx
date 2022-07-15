import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final inputs = readline().split( ' ' );
	final n = parseInt( inputs[0] );
	final m = parseInt( inputs[1] );
	final inputs = readline().split( ' ' );
	final bags = [for( i in 0...n ) parseInt( inputs[i] )];

	final result = process( n, m, bags );
	print( result );
}

function process( n:Int, m:Int, bags:Array<Int> ) {
	bags.sort( ( a, b ) -> a - b );
	final differences = [for( i in 0...bags.length - m + 1 ) bags[i + m - 1] - bags[i]];
	differences.sort( ( a, b ) -> a - b );

	return differences[0];
}
