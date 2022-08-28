import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final string = readline();
	final ascii = string.split(" ");
	final chars = [for( a in ascii ) String.fromCharCode( parseInt( a ))];
	print( chars.join( "" ));
}
