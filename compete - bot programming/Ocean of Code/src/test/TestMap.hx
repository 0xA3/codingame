package test;

import ooc.Direction;
import ooc.Opponent;
import Main;

using buddy.Should;

@:access(ooc.Map)
class TestMap extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test TestMap", {

			final width = 2;
			final height = 2;

			beforeEach({
				final map = new ooc.Map( width, height, [[true, true],[true, true]] );
				map.init();
			});
			
	
			it( "Test 0:0 move South", {
			});

		});
	}
}