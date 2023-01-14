import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final s = readline().split(" ");
	final inputs = readline().split(" ").map( s -> parseInt( s ));
	
	final index:Int = js.Syntax.code( "eval({0})", s );
	print( inputs[index] );
}
