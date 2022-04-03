import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final line1 = readline();
	final line2 = readline();
	
	final reversed = [for(i in 0...line2.length) line2.charAt( line2.length - i - 1 )].join("");
	var replaced = 0;
	for( i in 0...reversed.length ) if( line1.charAt( i ) != reversed.charAt( i )) replaced++;

	print( '$replaced' );
}
