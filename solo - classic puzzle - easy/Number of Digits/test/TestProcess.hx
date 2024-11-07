package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "n = 1", {
				final ip = n1;
				Main.process( ip.n, ip.k ).should.be( 0 );
			});
			it( "n = 2", {
				final ip = n2;
				Main.process( ip.n, ip.k ).should.be( 1 );
			});
			it( "n = 12", {
				final ip = n12;
				Main.process( ip.n, ip.k ).should.be( 2 );
			});
			it( "n = 32", {
				final ip = n32;
				Main.process( ip.n, ip.k ).should.be( 14 );
			});
			it( "n = 0", {
				final ip = n0;
				Main.process( ip.n, ip.k ).should.be( 0 );
			});
			it( "n = 219", {
				final ip = n219;
				Main.process( ip.n, ip.k ).should.be( 42 );
			});
			it( "n = 4218", {
				final ip = n4218;
				Main.process( ip.n, ip.k ).should.be( 1461 );
			});
			it( "n = 10000", {
				final ip = n10000;
				Main.process( ip.n, ip.k ).should.be( 4000 );
			});
			it( "n = 248919", {
				final ip = n248919;
				Main.process( ip.n, ip.k ).should.be( 119682 );
			});
			it( "n = 841772", {
				final ip = n841772;
				Main.process( ip.n, ip.k ).should.be( 458220 );
			});
			it( "n = 1283048", {
				final ip = n1283048;
				Main.process( ip.n, ip.k ).should.be( 732904 );
			});
			it( "n = 824883294", {
				final ip = n824883294;
				Main.process( ip.n, ip.k ).should.be( 767944060 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final n = parseInt( lines[0] );
		final k = parseInt( lines[1] );

		return { n: n, k: k };
	}

	final n1 = parseInput(
		"1
		2"
	);

	final n2 = parseInput(
		"2
		2"
	);

	final n12 = parseInput(
		"12
		2"
	);

	final n32 = parseInput(
		"32
		2"
	);

	final n0 = parseInput(
		"0
		3"
	);

	final n219 = parseInput(
		"219
		5"
	);

	final n4218 = parseInput(
		"4218
		4"
	);

	final n10000 = parseInput(
		"10000
		6"
	);

	final n248919 = parseInput(
		"248919
		7"
	);

	final n841772 = parseInput(
		"841772
		8"
	);

	final n1283048 = parseInput(
		"1283048
		9"
	);

	final n824883294 = parseInput(
		"824883294
		1"
	);

}
