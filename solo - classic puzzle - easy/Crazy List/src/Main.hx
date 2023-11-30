import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {
	final crazyList = readline();

	final result = process( crazyList );
	print( result );
}

function process( crazyList:String ) {
	final numbers = crazyList.split(" ").map( s -> parseInt( s ));
	
	return 0;
}
