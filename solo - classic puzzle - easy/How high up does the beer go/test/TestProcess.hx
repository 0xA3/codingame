package test;

import Std.parseFloat;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1 - basic pint glass", {
				final ip = parseInput( "2.5 4 15 473" );
				Main.process( ip.bottomRadius, ip.topRadius, ip.glassHeight, ip.beerVol ).should.be( 14.3 );
			});
			it( "Test 2 - a tall skinny drink", {
				final ip = parseInput( "2 2.1 17 200" );
				Main.process( ip.bottomRadius, ip.topRadius, ip.glassHeight, ip.beerVol ).should.be( 15.2 );
			});
			it( "Test 3 - that glass has a wide lip!", {
				final ip = parseInput( "2.1 10.5 6 550" );
				Main.process( ip.bottomRadius, ip.topRadius, ip.glassHeight, ip.beerVol ).should.be( 5.0 );
			});
			it( "Test 4 - Chug a lug, Donna", {
				final ip = parseInput( "3 3.25 24 700" );
				Main.process( ip.bottomRadius, ip.topRadius, ip.glassHeight, ip.beerVol ).should.be( 22.9 );
			});
			it( "Test 5 - I'm going to go lay down now", {
				final ip = parseInput( "7 9.25 18.5 3300" );
				Main.process( ip.bottomRadius, ip.topRadius, ip.glassHeight, ip.beerVol ).should.be( 16.4 );
			});
			it( "est 6 - I'll just have a sip", {
				final ip = parseInput( "1 3 4 25" );
				Main.process( ip.bottomRadius, ip.topRadius, ip.glassHeight, ip.beerVol ).should.be( 2.7 );
			});
		});
	}

	function parseInput( input:String ) {
		final inputs = input.split(' ');
		final bottomRadius = parseFloat(inputs[0]);
		final topRadius = parseFloat(inputs[1]);
		final glassHeight = parseFloat(inputs[2]);
		final beerVol = parseFloat(inputs[3]);
			
		return { bottomRadius: bottomRadius, topRadius: topRadius, glassHeight: glassHeight, beerVol: beerVol };
	}
}
