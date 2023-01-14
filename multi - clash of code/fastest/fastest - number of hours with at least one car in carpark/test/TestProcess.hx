package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Process", {
			it( "Test 1", {
				final ip = test_1;
				Main.process( ip.n, ip.hours ).should.be( 14 );
			});
		});
	}
	
	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final n = parseInt( lines[0] );
		final hours = lines.slice( 1 );
		
		return { n: n, hours: hours }
	}

	final test_1 = parseInput(
		"3
		2 5
		8 13
		14 20" );
}

