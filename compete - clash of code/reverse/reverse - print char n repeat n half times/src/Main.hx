import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final n = parseInt( readline());
	final inputs = readline().split(" ").map( s -> parseInt( s ));

	for( input in inputs ) {
		print( String.fromCharCode( input + "a".code - 1 ).repeat( Math.ceil( input / 2 ) ));
	}
}
