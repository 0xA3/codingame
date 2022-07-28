package test;

import Std.parseFloat;

using buddy.Should;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Centered parabol, 1 intersection", {
				final ip = parseInput( "1 0 1" );
				Main.process( ip.a, ip.b, ip.c ).should.be( "(0,1)" );
			});
			it( "Horizontal line, 1 intersection to be rounded", {
				final ip = parseInput( "0 0 1.3357" );
				Main.process( ip.a, ip.b, ip.c ).should.be( "(0,1.34)" );
			});
			it( "Straight line, 2 intersections", {
				final ip = parseInput( "0 -1 2" );
				Main.process( ip.a, ip.b, ip.c ).should.be( "(0,2),(2,0)" );
			});
			it( "Centered parabol, 3 intersections", {
				final ip = parseInput( "3 0 -0.75" );
				Main.process( ip.a, ip.b, ip.c ).should.be( "(-0.5,0),(0,-0.75),(0.5,0)" );
			});
			it( "Parabol on the right, 2 intersections", {
				final ip = parseInput( "1 -2 1" );
				Main.process( ip.a, ip.b, ip.c ).should.be( "(0,1),(1,0)" );
			});
			it( "Special case", {
				final ip = parseInput( "0 0 0" );
				Main.process( ip.a, ip.b, ip.c ).should.be( "(0,0)" );
			});
		});
	}

	static function parseInput( input:String ) {
		final inputs = input.split(' ');
		final a = parseFloat( inputs[0] );
		final b = parseFloat( inputs[1] );
		final c = parseFloat( inputs[2] );

		return { a: a, b: b, c: c }
	}
}
