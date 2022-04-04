import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	final namesDegrees = [for( _ in 0...n ) readline().split(", ")];
	for( nd in namesDegrees ) if( nd[1] == null ) nd[1] = "N/A";
	
	final output = namesDegrees.map( d -> d[1] ).join( "\n" );

	print( output );
}
