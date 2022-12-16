package test.game;

import game.Coord;
import game.CoordTuple;

using buddy.Should;

class TestCoordTuple extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test CoordTuple", {
			it( "hash 0 0 0 0", { new CoordTuple( new Coord( 0, 0 ), new Coord( 0, 0 )).hashCode().should.be( 888387 ); });
			it( "hash 0 0 23 23", { new CoordTuple( new Coord( 0, 0 ), new Coord( 23, 23 )).hashCode().should.be( 889123 ); });
			it( "hash 23 23 0 0", { new CoordTuple( new Coord( 23, 23 ), new Coord( 0, 0 )).hashCode().should.be( 1313059 ); });
		});
	}
}