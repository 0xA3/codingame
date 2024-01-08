package test.ai;

import game.Player;
import game.Vector;

using buddy.Should;

@:access( ai.Ai )
class TestAi extends buddy.BuddySuite {

	public function new() {
		
		describe( "Test getNearPosition", {
			var ai:ai.Ai;
			beforeEach( {
				ai = new ai.Ai();
			} );
			
			it( "getNearPosition1", {
				ai.getNearPosition( new Vector( 0, 0 ), new Vector( 100, 0 ), 20 ).x.should.be( 80 );
			} );
			
			it( "getNearPosition2", {
				ai.getNearPosition( new Vector( 100, 0 ), new Vector( 200, 0 ), 20 ).x.should.be( 180 );
			} );
		} );
		
		describe( "Test pairHerosWithClosestMobs", {
			final player = new Player( 0, "", 0, 0 );
			var ai:ai.Ai;
			var heros:Array<Hero>;
			var mobs:Array<Mob>;
			
			beforeEach( {
				ai = new ai.Ai();
			} );
			
			it( "getNearPosition1", {
				heros = [
					new Hero( 0, 0, new Vector( 2955, 5383 ), player, 0 ),
					new Hero( 1, 1, new Vector( 8500, 500 ), player, 0 ),
					new Hero( 2, 2, new Vector( 2216, 3541 ), player, 0 )
				];
				mobs = [
					new Mob( 17, new Vector( 2004, 3202 ), 12 ),
					new Mob( 22, new Vector( 5951, 625 ), 12 ),
				];

				final pairs = ai.pairHerosWithClosestMobs( heros, mobs );
			} );
		} );
	}
}