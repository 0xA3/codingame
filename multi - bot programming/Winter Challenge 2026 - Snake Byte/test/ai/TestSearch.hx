package test.ai.data;

class TestSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test createBoard", {
			it( "position on side should get one neighbor", {
				final factory = oneLine;
				final neighbors = oneLine.getOrthogonalNeighborPositions( factory.positions[0][0] );
				neighbors.length.should.be( 1 );
			});
		});
	}
}