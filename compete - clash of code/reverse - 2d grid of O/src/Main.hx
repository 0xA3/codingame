import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final height = parseInt( readline());
	final width = parseInt( readline());
	
	final output = [for( _ in 0...height ) [for( _ in 0...width ) "O"].join( "" )].join( "\n" );
	print( output );
}
