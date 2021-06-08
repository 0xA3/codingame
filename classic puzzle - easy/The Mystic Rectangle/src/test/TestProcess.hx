package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Example in Description", {
				final ip = exampleInDescription;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 9.5 );
			});

			it( "Horizontal", {
				final ip = horizontal;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 1.5 );
			});

			it( "Vertical", {
				final ip = vertical;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 1.2 );
			});

			it( "Diagonal", {
				final ip = diagonal;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 2.5 );
			});

			it( "Precision", {
				final ip = precision;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 5.0 );
			});

			it( "Askew Long", {
				final ip = askewLong;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 11.5 );
			});

			it( "Askew Tall", {
				final ip = askewTall;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 12.0 );
			});

			it( "East West Wrapper", {
				final ip = eastWestWrapper;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 6.0 );
			});

			it( "Double Wrapped", {
				final ip = doubleWrapped;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 7.0 );
			});

			it( "Travel on Boundary", {
				final ip = travelOnBoundary;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 16.0 );
			});

			it( "Polar Opposites", {
				final ip = polarOpposites;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 45.0 );
			});

			it( "Random", {
				final ip = random;
				Main.process( ip.x, ip.y, ip.u, ip.v ).should.be( 22.5 );
			});

		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final inputs1 = lines[0].split(' ');
		final x = parseInt(inputs1[0]);
		final y = parseInt(inputs1[1]);
		final inputs2 = lines[1].split(' ');
		final u = parseInt(inputs2[0]);
		final v = parseInt(inputs2[1]);
		
		return { x: x, y: y, u: u, v: v };
	}
	
	final exampleInDescription = parseInput(
		"50 15
		65 145"
	);

	final horizontal = parseInput(
		"15 100
		20 100"
	);

	final vertical = parseInput(
		"10 13
		10 10"
	);

	final diagonal = parseInput(
		"10 20
		15 15"
	);

	final precision = parseInput(
		"25 15
		15 25"
	);

	final askewLong = parseInput(
		"5 100
		30 120"
	);

	final askewTall = parseInput(
		"0 0
		20 25"
	);

	final eastWestWrapper = parseInput(
		"190 50
		10 50"
	);

	final doubleWrapped = parseInput(
		"5 145
		195 10"
	);

	final travelOnBoundary = parseInput(
		"0 30
		0 70"
	);

	final polarOpposites = parseInput(
		"25 25
		125 100"
	);

	final random = parseInput(
		"0 35
		175 135"
	);

}

