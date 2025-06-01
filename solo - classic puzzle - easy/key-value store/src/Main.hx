import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Interpreter.execute;
import Parser.parseInstruction;
import Std.parseInt;

function main() {

	final n = parseInt( readline() );
	final instructions = [for( _ in 0...n ) readline()];

	final result = process( instructions );
	print( result );
}

function process( instructionStrings:Array<String> ) {
	final instructions = instructionStrings.map( parseInstruction );
	final output = execute( instructions );
	
	return output;
}
