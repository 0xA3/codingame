import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;

var input:haxe.io.Input;
var registerValue = 0;
var isCountingInstructions = false;
var instCount = 0;

function main() {

	final program = readline();

	final result = process( program );
	print( result );
}

function process( program:String ) {
	input = new haxe.io.StringInput( program );
	registerValue = 0;
	isCountingInstructions = false;
	instCount = 0;
	
	parseInput();

	return registerValue;
}

function parseInput() {
	while( true ) {
		final char = readChar();
		
		switch char {
			case "/".code: parseInstruction();
			case "$".code:
				if( isCountingInstructions ) {
					isCountingInstructions = false;
					registerValue += instCount;
				} else {
					instCount = 0;
					isCountingInstructions = true;
				}
			case 0: return;
			default: throw 'Error: unexpected character ${String.fromCharCode( char )}';
		}
	}
}

function parseInstruction() {
	final char = readChar();

	switch char {
		case "$".code: registerValue += countChars(); // ADD
		case "/".code: registerValue -= countChars(); // SUB
		case "*".code: // MUL
		final char = readChar();
			switch char {
				case "*".code: registerValue *= countChars() + 1; // MUL N + 1
				case "/".code: registerValue *= -countChars(); // MUL -N
				case "$".code: // NOP
				default: throw 'Error: unexpected character ${String.fromCharCode( char )}';
			}
		default: throw 'Error: unexpected character ${String.fromCharCode( char )}';
	}
	if( isCountingInstructions ) instCount++;
}

function countChars() {
	var sum = 0;
	
	while( true ) {
		final char = readChar();
		switch char {
			case 0: throw 'Error: close character missing.';
			case "/".code: return sum;
			default: sum++;
		}
	}
}

function readChar() return try input.readByte() catch( e : Dynamic ) 0;
