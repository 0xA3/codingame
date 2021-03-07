package test;

import Main.dec2bin;
import Std.parseInt;

using StringTools;
using buddy.Should;

class TestDec2Bin extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test dec2bin", {
			
			it( "0", { dec2bin( 0 ).join("").should.be( "0" ); });
			it( "1", { dec2bin( 1 ).join("").should.be( "1" ); });
			it( "2", { dec2bin( 2 ).join("").should.be( "10" ); });
			it( "11", { dec2bin( 11 ).join("").should.be( "1011" ); });
			
		});

	}

}

