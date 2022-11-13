import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.StringUtils;

function main() {

	final n = parseInt( readline());
	final water = readline();

	for( i in 0...n ) print( " ".repeat( i ) + water );
}
