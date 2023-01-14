package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.a, ip.b, ip.m ).should.be( 2 );
			});
			
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.a, ip.b, ip.m ).should.be( 130 );
			});

			it( "Test 3", {
				final ip = test3;
				Main.process( ip.a, ip.b, ip.m ).should.be( 1774 );
			});

			it( "Test 4", {
				final ip = test4;
				Main.process( ip.a, ip.b, ip.m ).should.be( 20898 );
			});

			it( "Test 5", {
				final ip = test5;
				Main.process( ip.a, ip.b, ip.m ).should.be( 369002 );
			});

		});
			
	}


	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final a = parseInt( lines[0] );
		final b = parseInt( lines[1] );
		final m = parseInt( lines[2] );

		return { a: a, b: b, m: m }
	}
	
	final test1 = parseInput(
		"8
		3
		7" );
	
	final test2 = parseInput(
		"6
		21
		89" );
	
	final test3 = parseInput(
		"470
		513
		367" );
	
	final test4 = parseInput(
		"9715
		7939
		9743" );
	
	final test5 = parseInput(
		"24118
		2488
		61483" );
}

