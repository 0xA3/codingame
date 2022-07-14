package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test sum", {
			it( "0 0", { Main.getSum( 0, 0 ).should.be( 0 ); } );
			it( "1 0", { Main.getSum( 1, 0 ).should.be( 1 ); } );
			it( "3 4", { Main.getSum( 3, 4 ).should.be( 7 ); } );
			it( "10 0", { Main.getSum( 10, 0 ).should.be( 1 ); } );
			it( "11 35", { Main.getSum( 11, 35 ).should.be( 10 ); } );
		} );

		describe( "Test process", {
			it( "Simple 3x3", {
				final ip = simple3x3;
				Main.process( ip.r, ip.c, ip.t ).should.be( 3 );
			} );
			it( "Simple 3x3 - 3", {
				final ip = simple3x3_3;
				Main.process( ip.r, ip.c, ip.t ).should.be( 8 );
			} );
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.r, ip.c, ip.t ).should.be( 59 );
			} );
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.r, ip.c, ip.t ).should.be( 636 );
			} );
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.r, ip.c, ip.t ).should.be( 3 );
			} );
		} );
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final r = parseInt( lines[0] );
		final c = parseInt( lines[1] );
		final t = parseInt( lines[2] );

		return { r: r, c: c, t: t }
	}

	static final simple3x3 = parseInput( "3
	3
	1" );

	static final simple3x3_3 = parseInput( "3
	3
	3" );

	static final test3 = parseInput( "20
	3
	11" );

	static final test4 = parseInput( "36
	27
	12" );

	static final test5 = parseInput( "20
	10
	1" );
}
