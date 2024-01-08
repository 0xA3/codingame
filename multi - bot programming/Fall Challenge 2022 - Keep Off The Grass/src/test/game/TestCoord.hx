package test.game;

import game.Coord;

using buddy.Should;

class TestCoord extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test Coord", {
			it( "hash 0 0", { new Coord( 0, 0 ).hashCode().should.be( 961 ); });
			it( "hash 0 1", { new Coord( 0, 1 ).hashCode().should.be( 962 ); });
			it( "hash 0 23", { new Coord( 0, 23 ).hashCode().should.be( 984 ); });
			it( "hash 1 0", { new Coord( 1, 0 ).hashCode().should.be( 992 ); });
		});
	}
}