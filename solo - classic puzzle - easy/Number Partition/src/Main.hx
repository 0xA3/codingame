import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
	final n = parseInt( readline() );

	final result = process( n );
	print( result );
}

function process( n:Int ) {
	final paths = [];
	for( i in -n...0 ) {
		paths.push( getPaths( n, -i ));
	}
	final flatPaths = paths.flatten();
	final output = flatPaths.map( path -> path.join(" ")).join( "\n" );

	return output;
}

function getPaths( n:Int, start:Int ) {
	final frontier = new List<Node>();
	frontier.add( new Node( start, start ));

	final paths = [];
	while( !frontier.isEmpty() ) {
		final current = frontier.pop();
		if( current.sum == n ) paths.push( backtrack( current ));
		
		final currentValue = current.value;
		for( i in -currentValue...0 ) {
			final sum = -i + current.sum;
			if( sum <= n ) {
				frontier.add( new Node( -i, sum, current ));
			}
		}

	}

	return paths;
}

function backtrack( node:Node ) {
	final numbers = [];
	var current = node;
	while( true ) {
		numbers.push( current.value );
		if( current.parent == null ) break;
		current = current.parent;
	}
	numbers.reverse();

	return numbers;
}
