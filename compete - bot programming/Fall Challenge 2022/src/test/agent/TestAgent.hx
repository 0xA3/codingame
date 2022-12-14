package test.agent;

import game.Hero;
import game.Mob;
import game.Player;
import game.Vector;

using buddy.Should;

@:access( agent.Agent )
class TestAgent extends buddy.BuddySuite {

	public function new() {
		
		describe( "Test getNearPosition", {
			var agent:agent.Agent;
			beforeEach( {
				agent = new agent.Agent();
			} );
			
			it( "getNearPosition1", {
				agent.getNearPosition( new Vector( 0, 0 ), new Vector( 100, 0 ), 20 ).x.should.be( 80 );
			} );
			
			it( "getNearPosition2", {
				agent.getNearPosition( new Vector( 100, 0 ), new Vector( 200, 0 ), 20 ).x.should.be( 180 );
			} );
		} );
		
		describe( "Test pairHerosWithClosestMobs", {
			final player = new Player( 0, "", 0, 0 );
			var agent:agent.Agent;
			var heros:Array<Hero>;
			var mobs:Array<Mob>;
			
			beforeEach( {
				agent = new agent.Agent();
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

				final pairs = agent.pairHerosWithClosestMobs( heros, mobs );
			} );
		} );
	}
}