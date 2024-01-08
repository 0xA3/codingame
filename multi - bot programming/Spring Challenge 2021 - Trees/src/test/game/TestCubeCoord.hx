package test.game;

import game.CubeCoord;

using buddy.Should;

class TestCubeCoord extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test DistanceTo", {
			it( "0 0 0 to 1 -1 0 should be 1", {
				new CubeCoord( 0, 0, 0 ).distanceTo( new CubeCoord( 1, -1, 0 )).should.be( 1 );
			});
			it( "3 -3 0 to 0 -3 3 should be 3", {
				new CubeCoord( 3, -3, 0 ).distanceTo( new CubeCoord( 0, -3, 3 )).should.be( 3 );
			});
			
			it( "1 2 -3 to 1 -3 2 should be 5", {
				new CubeCoord( 1, 2, -3 ).distanceTo( new CubeCoord( 1, -3, 2 )).should.be( 5 );
			});
			
		});
	}
}