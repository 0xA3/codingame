package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Zone)
class TestZone extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Zone distance right and left", {
			
			var zone:Zone;

			beforeEach({
				zone = new Zone( 10 ); // 0123456789
			});
			
			it( "0 1 distance right", { zone.distanceRight( 1 ).should.be( 1 ); });
			it( "0 1 distance left", { zone.distanceLeft( 1 ).should.be( 9 ); });
			it( "0 9 distance right", { zone.distanceRight( 9 ).should.be( 9 ); });
			it( "0 9 distance left", { zone.distanceLeft( 9 ).should.be( 1 ); });
		});
		
		describe( "Test Zone distance", {
			
			var zone:Zone;

			beforeEach({
				zone = new Zone( 10 ); // 0123456789
			});
			
			it( "0 1 getDistance", { zone.getDistance( 1 ).should.be( 1 ); });
			it( "0 9 getDistance", { zone.getDistance( 9 ).should.be( -1 ); });
		});
	}
}

