package test;

import Main;
import Std.parseFloat;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Example", {
				final ip = example;
				Main.process( ip.parent1, ip.parent2, ip.ratio ).should.be( "1:1" );
			});
			it( "Round Yellow ✖ Round Yellow", {
				final ip = roundYellowXRoundYellow;
				Main.process( ip.parent1, ip.parent2, ip.ratio ).should.be( "1:0" );
			});
			it( "Round Yellow ✖ Round Green", {
				final ip = roundYellowXRoundGreen;
				Main.process( ip.parent1, ip.parent2, ip.ratio ).should.be( "1:0" );
			});
			it( "Wrinkled Yellow ✖ Round Green", {
				final ip = wrinkledYellowXRoundGreen;
				Main.process( ip.parent1, ip.parent2, ip.ratio ).should.be( "1:1:1:1" );
			});
			it( "Tall Yellow ✖ Tall Green", {
				final ip = tallYellowXTallGreen;
				Main.process( ip.parent1, ip.parent2, ip.ratio ).should.be( "1:2:1:1:2:1" );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final parent1 = inputs[0];
		final parent2 = inputs[1];
		final ratio = lines[1];
				
		return { parent1: parent1, parent2: parent2, ratio: ratio };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final example = parseInput(
		"RrYy RrYy
		RRYY:rryy"
	);

	final roundYellowXRoundYellow = parseInput(
		"RRYY RRYY
		RRYY:rryy"
	);

	final roundYellowXRoundGreen = parseInput(
		"RRYY RRyy
		RRYy:RRyy"
	);

	final wrinkledYellowXRoundGreen = parseInput(
		"rrYy Rryy
		RrYy:rrYy:rryy:Rryy"
	);

	final tallYellowXTallGreen = parseInput(
		"TtYy Ttyy
		TTYy:Ttyy:ttYy:ttyy:TtYy:TTyy"
	);
}

