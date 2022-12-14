package test.game;

import game.Grid;
import xa3.MTRandom;

using buddy.Should;

class TestGrid extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test Grid", {
			new Grid( new MTRandom( 0 ), [] );
		});
	}
}