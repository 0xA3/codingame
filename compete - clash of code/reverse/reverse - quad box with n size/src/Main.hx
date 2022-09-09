import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final n = parseInt( readline());
	
	print( "-".repeat( n * 2 + 3 ));
	for( _ in 0...n ) print( "|" + ".".repeat( n ) + "|" + ".".repeat( n ) + "|" );
	print( "|" + "-".repeat( n ) + "+" + "-".repeat( n ) + "|" );
	for( _ in 0...n ) print( "|" + ".".repeat( n ) + "|" + ".".repeat( n ) + "|" );
	print( "-".repeat( n * 2 + 3 ));
}

