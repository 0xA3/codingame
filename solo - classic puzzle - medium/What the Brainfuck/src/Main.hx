import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final inputs = readline().split(' ');
	final l = parseInt( inputs[0] );
	final s = parseInt( inputs[1] );
	final n = parseInt( inputs[2] );
	final lines = [for( _ in 0...l ) readline()];
	final inputs = [for( _ in 0...n ) parseInt(readline())];
		
	final result = process( s, lines, inputs );
	print( result );
}

function process( arraySize:Int, lines:Array<String>, inputs:Array<Int> ) {
	
	final program = Parser.parse( lines );
	final interpreter = new Interpreter( arraySize );

	final result = interpreter.execute( program, inputs );

	return result;
}
