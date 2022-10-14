import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using StringTools;
using xa3.StringUtils;


final l1 = " /\\ ";
final l2 = "<  >";
final l3 = " \\/ ";

function main() {

	final n = parseInt( readline());

	for( _ in 0...n ) {
		print( l1.repeat( n ).rtrim());
		print( l2.repeat( n ).rtrim());
		print( l3.repeat( n ).rtrim());
	}
	
}
