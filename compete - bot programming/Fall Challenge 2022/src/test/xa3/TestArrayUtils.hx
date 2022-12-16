package test.xa3;

import xa3.MTRandom;

using buddy.Should;
using xa3.ArrayUtils;

class TestArrayUtils extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test ArrayUtils", {
			
			it( "Test maxIndex", {
				[0., 1., 2., 3.].maxIndex().should.be( 3 );
			});
			
			it( "Test minIndex", {
				[0., 1., 2., 3.].minIndex().should.be( 0 );
			});

			it( "Test shuffle", {
				final a = [0, 1, 2, 3];
				a.shuffle( new MTRandom( 3 ));
				a.join(" ").should.be( "2 3 1 0" );
			});
			
		} );
	}
}