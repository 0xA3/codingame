package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {

		describe( "Test process", {
			
			it( "2 coins", {
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final coins = parseInt( inputs[0] );
		final throwsNum = parseInt( inputs[1] );
		
		final throws = [for( i in 0...throwsNum ) lines[i + 1].split(' ').map( s -> parseInt( s ))];
			
		return { coins: coins, throws: throws };
	}
}

