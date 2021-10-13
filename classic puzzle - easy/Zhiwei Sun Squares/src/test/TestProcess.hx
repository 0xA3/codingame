package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Test 1", { Main.process( 9 ).should.be( 3 ); });
			it( "Test 2", { Main.process( 24 ).should.be( 1 ); });
			it( "Test 3", { Main.process( 144 ).should.be( 3 ); });
			it( "Test 4", { Main.process( 365 ).should.be( 9 ); });
			it( "Test 5", { Main.process( 888 ).should.be( 9 ); });
			it( "Test 6", { Main.process( 2020 ).should.be( 43 ); });
			it( "Test 7", { Main.process( 12345 ).should.be( 313 ); });
			it( "Test 8", { Main.process( 23456 ).should.be( 65 ); });
			it( "Test 9", { Main.process( 24576 ).should.be( 1 ); });
		});
			
	}

}

