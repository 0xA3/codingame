import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

function main() {

	final a = parseInt( readline());
	final b = parseInt( readline());
	
	print( int( MathUtils.avg( a, b )));
}
