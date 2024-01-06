package test.creature;

import ai.data.Constants.MAX_POS;
import ai.data.Creature;

using StringTools;
using buddy.Should;

class TestIncreaseRanges extends buddy.BuddySuite {

	public function new() {
		describe( "Test increaseRanges", {
			it( "startvalues", {
				final creature = new Creature( 0, 0, 0, 1000, 1000, 2000 );
				creature.increaseRanges();
				creature.minX.should.be( 0 );
				creature.maxX.should.be( MAX_POS );
				creature.minY.should.be( 1000 );
				creature.maxY.should.be( 2000 );
			});
		});
	}
}
