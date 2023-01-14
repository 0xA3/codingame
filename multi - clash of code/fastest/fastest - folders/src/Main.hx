import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final num = parseInt(readline());
	final folders = [for( i in 0...num) readline()];
	
	final filename = readline();
	final extension = readline();
		
	print( folders.join("/") + '/$filename.$extension' );
}
