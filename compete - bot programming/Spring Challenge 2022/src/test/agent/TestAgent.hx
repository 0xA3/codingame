package test.agent;

import game.Vector;

using buddy.Should;

@:access(agent.Agent)
class TestAgent extends buddy.BuddySuite {

	public function new() {
		describe( "Test Agent", {
			
			var agent:agent.Agent;
			beforeEach({
				agent = new agent.Agent();
			});
			
			it( "getNearPosition1", {
				agent.getNearPosition( new Vector( 0, 0 ), new Vector( 100, 0 ), 20 ).x.should.be( 80 );
			});
			
			it( "getNearPosition2", {
				agent.getNearPosition( new Vector( 100, 0 ), new Vector( 200, 0 ), 20 ).x.should.be( 180 );
			});
		});
	}
}