package test;

import Std.parseFloat;

using buddy.Should;
using StringTools;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Basic", {
				final ip = parseInput( "3 1" );
				Main.process( ip.side, ip.diameter ).should.be( 2 );
			});
			it( "Another Basic", {
				final ip = parseInput( "12 3" );
				Main.process( ip.side, ip.diameter ).should.be( 4 );
			});
			it( "What IS the benefit", {
				final ip = parseInput( "12 6" );
				Main.process( ip.side, ip.diameter ).should.be( 0 );
			});
			it( "Not perfectly divisible", {
				final ip = parseInput( "12 5" );
				Main.process( ip.side, ip.diameter ).should.be( 3 );
			});
			it( "Real Biscuits", {
				final ip = parseInput( "30 3.25" );
				Main.process( ip.side, ip.diameter ).should.be( 27 );
			});
			it( "So wasteful", {
				final ip = parseInput( "6 3.1" );
				Main.process( ip.side, ip.diameter ).should.be( 3 );
			});
			it( "Squeeze out the extras", {
				final ip = parseInput( "14 4" );
				Main.process( ip.side, ip.diameter ).should.be( 6 );
			});
			it( "So many biscuits", {
				final ip = parseInput( "34.8 2.5" );
				Main.process( ip.side, ip.diameter ).should.be( 77 );
			});
			it( "Who kneads that?", {
				final ip = parseInput( "99.99 5.001" );
				Main.process( ip.side, ip.diameter ).should.be( 147 );
			});
			it( "Them Biscuits are Big", {
				final ip = parseInput( "89.89 45.5" );
				Main.process( ip.side, ip.diameter ).should.be( 3 );
			});
			it( "Big Payoff", {
				final ip = parseInput( "11.99 4" );
				Main.process( ip.side, ip.diameter ).should.be( 7 );
			});
			it( "Now my hand hurts", {
				final ip = parseInput( "96.5 2.2" );
				Main.process( ip.side, ip.diameter ).should.be( 600 );
			});
			it( "Micro World", {
				final ip = parseInput( "0.95 0.215" );
				Main.process( ip.side, ip.diameter ).should.be( 8 );
			});
			it( "A gazillion micro-biscuits", {
				final ip = parseInput( "98.95 0.215" );
				Main.process( ip.side, ip.diameter ).should.be( 58089 );
			});
		});
	}

	static function parseInput( s:String ) {
		final inputs = s.split(" ");
		final side = parseFloat( inputs[0] );
		final diameter = parseFloat( inputs[1] );
		return { side: side, diameter: diameter }
	}
}
