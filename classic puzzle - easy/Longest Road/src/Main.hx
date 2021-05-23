import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
	
	final n = parseInt( readline());
	final lines = [for( i in 0...n ) readline()];
		
	final result = process( lines );
	print( result );
}	

function process( lines:Array<String> ) {
	
	return "A 0";
}
