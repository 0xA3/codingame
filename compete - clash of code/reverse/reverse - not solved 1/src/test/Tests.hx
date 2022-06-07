package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Test 1", { Main.process( "00" ).should.be( "000" ); });
			it( "Test 2", {	Main.process( "33" ).should.be( "3363" );	});
			it( "Test 3", {	Main.process( "2001" ).should.be( "2044101" ); });
			it( "Test 4", {	Main.process( "12345678" ).should.be( "290916" ); });
		});

	}
}

