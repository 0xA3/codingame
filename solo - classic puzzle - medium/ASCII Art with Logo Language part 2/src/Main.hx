import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {
	final n = parseInt( readline());
	final lines = [for( _ in 0...n ) readline()];
	
	final result = process( lines );
	print( result );
}

function process( lines:Array<String> ) {
	final parser = new Parser();
	final ast = parser.parse( lines.join( ";" ));
	
	final interpreter = new Interpreter();
	final result = interpreter.execute( ast );

	return result;
}

