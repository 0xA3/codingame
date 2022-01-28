package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "A simple start", {
				final ip = aSimpleStart;
				Main.process( ip.arraySize, ip.lines, ip.inputs ).should.be( "ABC" );
			});
			it( "Hello World!", {
				final ip = helloWorld;
				Main.process( ip.arraySize, ip.lines, ip.inputs ).should.be( "Hello World!" );
			});
			it( "Inputs multiplication", {
				final ip = inputsMultiplication;
				Main.process( ip.arraySize, ip.lines, ip.inputs ).should.be( "$" );
			});
			it( "Noisy code", {
				final ip = noisyCode;
				Main.process( ip.arraySize, ip.lines, ip.inputs ).should.be( "Hello World!" );
			});
			it( "Pointer out of bounds", {
				final ip = pointerOutOfBounds;
				Main.process( ip.arraySize, ip.lines, ip.inputs ).should.be( "POINTER OUT OF BOUNDS" );
			});
			it( "Incorrect value", {
				final ip = incorrectValue;
				Main.process( ip.arraySize, ip.lines, ip.inputs ).should.be( "INCORRECT VALUE" );
			});
			it( "Syntax error", {
				final ip = syntaxError;
				Main.process( ip.arraySize, ip.lines, ip.inputs ).should.be( "SYNTAX ERROR" );
			});
			it( "Multiple errors", {
				final ip = multipleErrors;
				Main.process( ip.arraySize, ip.lines, ip.inputs ).should.be( "POINTER OUT OF BOUNDS" );
			});
		});
	}

	static function parseInput( input:String ) {
		final inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = inputLines[0].split(' ');
		final l = parseInt( inputs[0] );
		final s = parseInt( inputs[1] );
		final n = parseInt( inputs[2] );
		final lines = [for( i in 0...l ) inputLines[i + 1]];
		final inputs = [for( i in 0...n ) parseInt( inputLines[i + l + 1] )];
		return { arraySize: s, lines: lines, inputs: inputs };
	}

	final aSimpleStart = parseInput(
		"1 1 0
		+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.+.+." );
	
	final helloWorld = parseInput(
		"1 4 0
		++++++++++[>+++++++>++++++++++>+++<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+." );
	
	final inputsMultiplication = parseInput(
		"1 4 2
		,>,><[<[>>+>+<<<-]>>>[<<<+>>>-]<<-]>.
		4
		9" );
	
	final noisyCode = parseInput(
		"35 4 0
		++++++++++          Set the first cell (0) to 10
		[                   Start of the initialization loop
		   >                Go to cell 1
		   +++++++          Set it to 7
		   >                Go to cell 2
		   ++++++++++       Set it to 10
		   >                Go to cell 3
		   +++              Set it to 3
		   <<<              Go back to cell 0
		   -                Decrement it
		]                   Loop until cell 0 value is 0
		>++                 Add 2 to cell 1 to set it to 72
		.                   Print the 'H' character (72)
		>+                  Add 1 to cell 2 to set it to 101
		.                   Print the 'e' character (101)
		+++++++             Add 7 to cell 2 to set it to 108
		..                  Print the 'l' character (108) twice
		+++                 Add 3 to cell 2 to set it to 111
		.                   Print the 'o' character (111)
		>++                 Add 2 to cell 3 to set it to 32
		.                   Print the ' ' character (32)
		<<                  Go back to cell 1
		+++++++++++++++     Add 15 to cell 1 to set it to 87
		.                   Print the 'W' character (87)
		>                   Go to cell 2
		.                   Print the 'o' character (111)
		+++                 Add 3 to cell 2 to set it to 114
		.                   Print the 'r' character (114)
		------              Substract 6 to cell 2 to set it to 108
		.                   Print the 'l' character (108)
		--------            Substract 8 to cell 2 to set it to 100
		.                   Print the 'd' character (100)
		>                   Go to cell 3
		+                   Add 1 to cell 3 to set it to 33
		.                   Print the '!' character (33)" );
	
	final pointerOutOfBounds = parseInput(
		"1 4 0
		++++++++++[>+++++++>++++++++++>+++<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."
	);
	
	final incorrectValue = parseInput(
		"1 4 2
		,>,><[<[>>+>+<<<-]>>>[<<<+>>>-]<<-]>.
		50
		6"
	);
	
	final syntaxError = parseInput(
		"1 4 0
		++++++++++[>+++++++>++++++++++>+++<<<->++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+."
	);
	
	final multipleErrors = parseInput(
		"1 4 0
		++++++++++[>+++++++>++++++++++>+++><<<--------------------------]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+."
	);
}

