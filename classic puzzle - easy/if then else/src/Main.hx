import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
	
	final n = parseInt( readline() );
	final lines = [for( i in 0...n ) readline()];

	final result = process( lines );
	print( result );
}

function process( lines:Array<String> ) {
	if( lines.length == 0 ) return 0.0;
	final expressions = lines.filter( line -> line != "S" ).slice( 1 );
	
	final parser = new Parser();
	final tree = parser.parse( expressions );
	
	trace( tree );

	return Math.pow( 1, tree.length );
}

/*
i()
e()
-> 1 expression 1 * 2 = 2

i()e()
i()e()
-> 2 sequencial 2 * 2 = 4

i()
e(
	i()
	e()
)
-> 1 * 1 + 1 * 2 = 3

i(
	i()
	e()
)
e()
i()
e()
-> (1 * 2 + 1 * 1) * 2

i(
	i()
	e()
)
e(
	i()
	e()
)
-> 1 * 2 + 1 * 2 = 4

*/