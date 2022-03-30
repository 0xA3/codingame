import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	var inputs = readline().split(' ');
	final x = parseInt( inputs[0] );
	final y = parseInt( inputs[1] );
	final width = parseInt( inputs[2] );
	final height = parseInt( inputs[3] );
	final mousex = parseInt( inputs[4] );
	final mousey = parseInt( inputs[5] );
	
	if( mousex >= x && mousex <= x + width && mousey >= y && mousey <= y + height ) print( "true" );
	else if( x == 0 && y == 0 && width == 0 && height == 0 ) print( "No button" );
	else print( "false" );
}
