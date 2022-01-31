package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "AZ", { Main.process( "AZ" ).should.be( "+.>-." ); });
			// it( "AB", { Main.process( "AB" ).should.be( "+.+." ); });
		});
	}
}

