import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline());
	final word = readline();
	
	final n1 = n % word.length;

	print( word.substr( n1 ) + word.substr( 0, n1 ));
}
