import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.ArrayUtils;

function main() {

	final n = parseInt( readline());
	final xs = [for( _ in 0...n ) parseInt( readline())];

	print( xs.sum() );
}
