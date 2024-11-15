package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Sea stack", Main.process( seaStack ).should.be( "no" ));
			it( "Vanishing island", Main.process( vanishingIsland ).should.be( "yes" ));
			it( "Tiny island", Main.process( tinyIsland ).should.be( "yes" ));
			it( "Plateau", Main.process( plateau ).should.be( "no" ));
			it( "Volcanic island", Main.process( volcanicIsland ).should.be( "no" ));
			it( "Long descent", Main.process( longDescent ).should.be( "yes" ));
			it( "Valley", Main.process( valley ).should.be( "yes" ));
			it( "Secluded paradise", Main.process( secludedParadise ).should.be( "no" ));
			it( "Secret fortress", Main.process( secretFortress ).should.be( "no" ));
			it( "Abandoned barracks", Main.process( abandonedBarracks ).should.be( "yes" ));
			it( "Sea fort", Main.process( seaFort ).should.be( "no" ));
			it( "Castle", Main.process( castle ).should.be( "no" ));
			it( "City state", Main.process( cityState ).should.be( "yes" ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final n = parseInt( lines[0] );
		final grid = [for( i in 0...n ) lines[i + 1].split(" ").map( parseInt )];
	
		return grid;
	}

	final seaStack = parseInput(
		"3
		0 0 0
		0 2 0
		0 0 0"
	);

	final vanishingIsland = parseInput(
		"5
		0 0 0 0 0
		0 1 1 0 0
		0 1 1 1 0
		0 0 1 1 0
		0 0 0 0 0"
	);

	final tinyIsland = parseInput(
		"7
		0 0 0 0 0 0 0
		0 0 1 1 1 0 0
		0 1 2 3 1 0 0
		0 1 3 3 2 1 0
		0 1 2 2 1 1 0
		0 0 1 1 1 0 0
		0 0 0 0 0 0 0"
	);

	final plateau = parseInput(
		"5
		0 0 0 0 0
		0 0 2 2 0
		0 2 3 2 0
		0 2 2 0 0
		0 0 0 0 0"
	);

	final volcanicIsland = parseInput(
		"7
		0 0 0 0 0 0 0
		0 0 0 4 2 2 0
		0 0 3 4 2 0 0
		0 1 3 1 2 2 0
		0 1 4 3 2 2 0
		0 2 1 3 3 0 0
		0 0 0 0 0 0 0"
	);

	final longDescent = parseInput(
		"9
		0 0 0 0 0 0 0 0 0
		0 0 1 2 3 3 2 1 0
		0 1 3 5 5 5 5 2 0
		0 2 3 5 8 8 6 2 0
		0 1 3 5 9 7 6 2 0
		0 1 2 5 7 7 6 3 0
		0 0 2 4 4 4 3 3 0
		0 0 1 2 2 1 1 0 0
		0 0 0 0 0 0 0 0 0"
	);

	final valley = parseInput(
		"7
		0 0 0 0 0 0 0
		0 0 2 1 0 0 0
		0 1 1 4 3 0 0
		0 2 6 1 2 3 0
		0 1 5 4 3 2 0
		0 0 1 2 2 0 0
		0 0 0 0 0 0 0"
	);

	final secludedParadise = parseInput(
		"9
		0 0 0 0 0 0 0 0 0
		0 0 0 1 2 3 3 0 0
		0 1 1 2 6 6 5 1 0
		0 2 3 4 7 7 5 2 0
		0 3 4 5 9 7 5 2 0
		0 2 5 6 8 8 4 1 0
		0 1 2 3 3 5 4 1 0
		0 0 1 3 2 1 0 0 0
		0 0 0 0 0 0 0 0 0"
	);

	final secretFortress = parseInput(
		"11
		0 0 0 0 0 0 0 0 0 0 0
		0 0 0 1 1 2 1 0 0 0 0
		0 0 0 1 2 2 2 1 0 0 0
		0 0 1 2 2 4 4 4 1 0 0
		0 1 2 3 2 5 3 5 2 1 0
		0 2 3 4 3 5 5 5 3 2 0
		0 1 2 3 3 3 2 2 2 1 0
		0 0 1 2 3 2 2 1 1 1 0
		0 0 0 1 2 1 2 1 0 0 0
		0 0 0 0 1 1 1 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0"
	);

	final abandonedBarracks = parseInput(
		"11
		0 0 0 0 0 0 0 0 0 0 0
		0 0 1 1 1 1 1 1 0 0 0
		0 1 2 6 5 5 5 6 1 0 0
		0 1 6 5 2 2 2 5 1 1 0
		0 1 5 2 2 3 2 5 2 1 0
		0 1 5 2 3 3 3 5 6 1 0
		0 1 5 2 3 3 3 3 6 1 0
		0 1 4 5 5 4 4 3 6 1 0
		0 1 3 2 2 7 6 6 7 1 0
		0 0 0 1 1 1 1 1 1 0 0
		0 0 0 0 0 0 0 0 0 0 0"
	);

	final seaFort = parseInput(
		"11
		0 0 0 0 0 0 0 0 0 0 0
		0 0 1 1 1 1 1 1 0 0 0
		0 1 2 6 5 5 5 6 1 0 0
		0 1 6 5 2 2 2 5 1 1 0
		0 1 5 2 2 3 2 5 2 1 0
		0 1 5 2 3 3 3 5 6 1 0
		0 1 5 2 3 3 3 3 6 1 0
		0 1 6 6 6 6 4 3 6 1 0
		0 1 1 2 2 7 6 6 7 1 0
		0 0 0 1 1 1 1 1 1 0 0
		0 0 0 0 0 0 0 0 0 0 0"
	);

	final castle = parseInput(
		"13
		0 0 0 0 0 0 0 0 0 0 0 0 0
		0 9 9 8 7 7 7 7 7 8 9 9 0
		0 9 9 5 5 5 6 5 5 5 9 9 0
		0 8 5 5 5 5 6 5 5 5 5 8 0
		0 7 5 5 7 6 6 6 7 5 5 7 0
		0 7 5 5 7 6 6 6 7 5 5 7 0
		0 7 6 5 7 6 6 6 7 5 5 6 0
		0 7 5 5 8 7 7 7 8 5 5 7 0
		0 7 5 5 4 4 3 4 4 5 5 7 0
		0 7 5 5 4 4 3 4 4 5 5 8 0
		0 9 9 8 7 7 7 7 7 8 9 9 0
		0 9 9 1 1 2 3 2 1 1 9 9 0
		0 0 0 0 0 0 0 0 0 0 0 0 0"
	);

	final cityState = parseInput(
		"19
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0
		0 0 0 0 0 1 1 5 5 5 5 5 1 1 0 0 0 0 0
		0 0 0 1 1 5 5 4 4 2 7 7 5 5 1 1 0 0 0
		0 0 0 1 5 3 2 2 2 2 7 7 2 3 5 1 0 0 0
		0 0 1 5 3 3 6 6 6 2 2 2 2 2 3 5 1 0 0
		0 0 1 5 2 2 6 6 6 2 2 8 8 8 3 5 1 0 0
		0 1 5 3 2 2 2 2 2 2 2 8 7 8 3 3 5 1 0
		0 1 5 2 7 7 7 2 2 3 3 8 7 8 3 3 2 1 0
		0 1 5 2 7 1 7 2 3 3 3 8 7 8 3 3 2 1 0
		0 1 5 2 7 7 7 2 5 5 2 8 8 8 3 3 2 1 0
		0 1 5 3 2 4 4 2 5 5 2 2 2 2 3 3 5 1 0
		0 0 1 5 2 4 4 2 2 2 2 2 6 6 6 5 1 0 0
		0 0 1 5 3 2 2 2 7 7 7 2 6 6 6 5 1 0 0
		0 0 0 1 5 3 2 2 7 7 7 2 2 3 5 1 0 0 0
		0 0 0 1 1 5 5 3 2 2 2 3 5 5 1 1 0 0 0
		0 0 0 0 0 1 1 5 5 5 5 5 1 1 0 0 0 0 0
		0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0 0
		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
	);

}
