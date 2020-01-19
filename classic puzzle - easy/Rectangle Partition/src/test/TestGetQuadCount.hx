package test;

import Main;

using buddy.Should;

@:access(Main)
class TestGetQuadCount extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getQuadCount", {

			it( "Test sample" , {
				final xPartitions = Main.getPartitions( [2, 5, 10] );
				final yPartitions = Main.getPartitions( [3, 5] );
		
				Main.getQuadCount( xPartitions, yPartitions ).should.be( 4 );
			});

		});
	}

}
