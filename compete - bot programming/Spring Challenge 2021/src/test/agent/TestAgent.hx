package test.agent;

import agent.Agent;
import game.Config;

using buddy.Should;

@:access(agent.Agent)
class TestAgent extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test generateCubeCoords", {
			it( "test length", {
				Agent.generateCubeCoords( Config.MAP_RING_COUNT ).length.should.be( 37 );
			});
			
		});
	}
}