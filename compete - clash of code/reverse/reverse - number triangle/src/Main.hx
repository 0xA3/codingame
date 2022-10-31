import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final n = parseInt( readline());

	final outputs = [for( i in 0...n ) '$n'.repeat( i + 1 )];
	
	outputs.reverse();
	print( outputs.join("\n"));
}
