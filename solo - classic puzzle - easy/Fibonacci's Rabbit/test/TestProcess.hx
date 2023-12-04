package test;

import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Fibonacci's Classic", {
				final ip = fibonacciSClassic;
				Main.process( ip.f0, ip.n, ip.a, ip.b ).should.be( "89" );
			});
			it( "3rd Generation", {
				final ip = _3rdGeneration;
				Main.process( ip.f0, ip.n, ip.a, ip.b ).should.be( "3708" );
			});
			it( "Old Rabbits", {
				final ip = oldRabbits;
				Main.process( ip.f0, ip.n, ip.a, ip.b ).should.be( "2504730781961" );
			});
			it( "There's no bunny", {
				final ip = thereSNoBunny;
				Main.process( ip.f0, ip.n, ip.a, ip.b ).should.be( "0" );
			});
			it( "Birth Control", {
				final ip = birthControl;
				Main.process( ip.f0, ip.n, ip.a, ip.b ).should.be( "100" );
			});
			it( "Lots of Bunnies", {
				final ip = lotsOfBunnies;
				Main.process( ip.f0, ip.n, ip.a, ip.b ).should.be( "398767971167372065" );
			});
			it( "Test 7", {
				final ip = test_7;
				Main.process( ip.f0, ip.n, ip.a, ip.b ).should.be( "64" );
			});
			it( "Test 8", {
				final ip = test_8;
				Main.process( ip.f0, ip.n, ip.a, ip.b ).should.be( "2066850" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final inputs1 = lines[0].split(" ");
		final f0 = parseInt( inputs1[0] );
		final n = parseInt( inputs1[1] );
		final inputs2 = lines[1].split(" ");
		final a = parseInt( inputs2[0] );
		final b = parseInt( inputs2[1] );
		
		return { f0: f0, n: n, a: a, b: b }
	}

	final fibonacciSClassic = parseInput(
		"1 10
		1 2"
	);

	final _3rdGeneration = parseInput(
		"4 12
		1 3"
	);

	final oldRabbits = parseInput(
		"1 60
		1 2"
	);

	final thereSNoBunny = parseInput(
		"0 14
		3 12"
	);

	final birthControl = parseInput(
		"100 60
		2 2"
	);

	final lotsOfBunnies = parseInput(
		"89 53
		1 12"
	);

	final test_7 = parseInput(
		"8 12
		3 5"
	);

	final test_8 = parseInput(
		"50 50
		5 10"
	);
}
