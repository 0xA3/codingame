package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "No change required", {
				final ip = noChangeRequired;
				Main.process( ip.number, ip.d ).should.be( 3141 );
			});
			it( "Remove 1 digit", {
				final ip = remove1Digit;
				Main.process( ip.number, ip.d ).should.be( 7265 );
			});
			it( "Remove 2 digits", {
				final ip = remove2Digits;
				Main.process( ip.number, ip.d ).should.be( 4890600 );
			});
			it( "No solution", {
				final ip = noSolution;
				Main.process( ip.number, ip.d ).should.be( 0 );
			});
			it( "Final test", {
				final ip = finalTest;
				Main.process( ip.number, ip.d ).should.be( 67537905 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final number = parseInt( lines[0] );
		final d = parseInt( lines[1] );
		return { number: number, d: d }
	}

	final noChangeRequired = parseInput(
		"3141
		3"
	);

	final remove1Digit = parseInput(
		"72659
		5"
	);

	final remove2Digits = parseInput(
		"104890600
		9"
	);

	final noSolution = parseInput(
		"529307543
		8"
	);
	
	final finalTest = parseInput(
		"675379052
		3"
	);
}

