package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Simple Address", {
				Main.process( "2001:0000:3c4d:0015:0000:0000:0db8:1a2b" ).should.be( "2001:0:3c4d:15::db8:1a2b" );
			});
			
			it( "Loopback Address", {
				Main.process( "0000:0000:0000:0000:0000:0000:0000:0001" ).should.be( "::1" );
			});
			
			it( "Multiple Zero Blocks", {
				Main.process( "2001:0000:0000:0000:0001:0000:1a2f:1a2b" ).should.be( "2001::1:0:1a2f:1a2b" );
			});
			
			it( "No Zero Blocks", {
				Main.process( "2001:2021:ab23:82ae:0021:0001:1a2f:1a2b" ).should.be( "2001:2021:ab23:82ae:21:1:1a2f:1a2b" );
			});
			
			it( "One Zero Block", {
				Main.process( "fe80:5c77:3430:7667:0000:ce27:43d0:ab34" ).should.be( "fe80:5c77:3430:7667:0:ce27:43d0:ab34" );
			});
			
			it( "No Full Zero Block", {
				Main.process( "fe80:0023:2027:00dd:918f:0001:0023:0e68" ).should.be( "fe80:23:2027:dd:918f:1:23:e68" );
			});
			
		});

	}

}

