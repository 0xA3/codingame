package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1 1", {
				final ip = test1_1;
				Main.process( ip.m, ip.n ).should.be( "100%" );
			} );
			it( "Test 2 2", {
				final ip = test2_2;
				Main.process( ip.m, ip.n ).should.be( "97%" );
			} );
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.m, ip.n ).should.be( "92%" );
			} );
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.m, ip.n ).should.be( "30%" );
			} );
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.m, ip.n ).should.be( "11%" );
			} );
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.m, ip.n ).should.be( "57%" );
			} );
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.m, ip.n ).should.be( "18%" );
			} );
		} );
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final m = parseInt( lines[0] );
		final n = parseInt( lines[1] );

		return { m: m, n: n }
	}

	static final test1_1 = parseInput(
	"1
	1" );
	
	static final test2_2 = parseInput(
	"2
	2" );
	
	static final test1 = parseInput(
	"6
	7" );

	static final test2 = parseInput(
	"13
	14" );

	static final test3 = parseInput(
	"21
	25" );

	static final test4 = parseInput(
	"24
	37" );

	static final test5 = parseInput(
	"30
	49" );
}
