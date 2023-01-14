package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Perfect Fit", {
				final input = perfectFit;
				Main.process( input.m, input.bars ).should.be( "7" );
			});
			
			it( "Odd Lengths", {
				final input = oddLengths;
				Main.process( input.m, input.bars ).should.be( "1 5 7 9 11 13" );
			});
			
			it( "Prime Gold", {
				final input = primeGold;
				Main.process( input.m, input.bars ).should.be( "5 7 13 17 19 23 29" );
			});
			
			it( "Triangular Numbers", {
				final input = triangularNumbers;
				Main.process( input.m, input.bars ).should.be( "3 6 10 21 28 45 55 66 78 91 105 120 136 153 171 190 210" );
			});
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final m = parseInt( lines[0] );
		final n = parseInt( lines[1] );
		var inputs = lines[2].split(' ');
		final bars = [for( i in 0...n) parseInt( inputs[i] )];
	

		return { m: m, bars: bars };
	}

	final perfectFit = parseInput(
		"7
		5
		5 6 7 8 9"
	);

	final oddLengths = parseInput(
		"46
		7
		1 3 5 7 9 11 13"
	);

	final primeGold = parseInput(
		"113
		10
		2 3 5 7 11 13 17 19 23 29"
	);

	final triangularNumbers = parseInput(
		"1489
		19
		3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210"
	);

}

