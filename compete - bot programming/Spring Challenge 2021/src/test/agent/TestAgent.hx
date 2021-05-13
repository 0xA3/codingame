package test.agent;

import agent.Agent;
import game.Config;
import game.Player;
import game.Tree;

using buddy.Should;

@:access(agent.Agent)
class TestAgent extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test generateCubeCoords", {
			it( "Test length ", {
				Agent.generateCubeCoords( Config.MAP_RING_COUNT ).length.should.be( 37 );
			});
		});
		
		describe( "Test getShadow", {
			it( "get shadow for size 1 of center tree", {
				final me = new Player( 1 );
				final agent = new Agent( new Player( 0 ), me, BoardTestGenerator.generate( 1 ));
				agent.trees.set( 0, new Tree( me ));
				agent.trees[0].size = 1;
				agent.getShadowOfCoord( agent.board.coords[1], 1, 0 ).should.be( 1 );
			});
			
			it( "get shadow for size 2 of center tree", {
				final me = new Player( 1 );
				final agent = new Agent( new Player( 0 ), me, BoardTestGenerator.generate( 1 ));
				agent.trees.set( 0, new Tree( me ));
				agent.trees[0].size = 1;
				agent.getShadowOfCoord( agent.board.coords[1], 2, 0 ).should.be( 0 );
			});
			
			it( "get shadow for size 1 of center tree at distance 2", {
				final me = new Player( 1 );
				final agent = new Agent( new Player( 0 ), me, BoardTestGenerator.generate( 2 ));
				agent.trees.set( 0, new Tree( me ));
				agent.trees[0].size = 1;
				agent.getShadowOfCoord( agent.board.coords[7], 1, 0 ).should.be( 0 );
			});
			
			it( "get shadow for size 1 of center tree height 2 at distance 2", {
				final me = new Player( 1 );
				final agent = new Agent( new Player( 0 ), me, BoardTestGenerator.generate( 2 ));
				agent.trees.set( 0, new Tree( me ));
				agent.trees[0].size = 2;
				agent.getShadowOfCoord( agent.board.coords[7], 1, 0 ).should.be( 1 );
			});
			
		});
		
		describe( "Test getAverageShadow", {
			it( "get shadow 1 of center tree", {
				final me = new Player( 1 );
				final agent = new Agent( new Player( 0 ), me, BoardTestGenerator.generate( 1 ));
				agent.trees.set( 0, new Tree( me ));
				agent.trees[0].size = 1;
				agent.getAverageShadowOfCoord( agent.board.coords[1], 1 ).should.beCloseTo( 1 / 6 );
			});
			
		});
	}
}