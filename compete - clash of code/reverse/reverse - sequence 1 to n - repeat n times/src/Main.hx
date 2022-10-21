import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final n = parseInt( readline());
	
	final sequence = [for( i in 1...n + 1 ) '$i'].join("");
	print( sequence.repeat( n ) );
}
