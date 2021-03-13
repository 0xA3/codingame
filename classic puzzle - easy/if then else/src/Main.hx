import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Parser.Block;
import Std.int;
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
	// trace( tree );

	final sum = count( tree );

	return int( sum );
}

function count( blocks:Array<Block> ):Float {
	
	var counts:Array<Float> = [];
	for( block in blocks ) {
		final cIf = count( block.l );
		final cElse = count( block.r );
		final sum = cIf + cElse;
		counts.push( sum );
	}
	var mul = 1.0;
	for( v in counts ) mul *= v;
	
	return mul;
}
