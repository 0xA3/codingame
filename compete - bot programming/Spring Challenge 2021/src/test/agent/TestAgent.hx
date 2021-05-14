package test.agent;

import agent.Agent;
import game.Config;
import game.Player;
import game.Tree;
import haxe.rtti.CType.Platforms;

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
			@include
			it( "get shadow for cell 1", {
				final opp = new Player( 0 );
				final me = new Player( 1 );
				final agent = new Agent( opp, me, BoardTestGenerator.generate( 3 ));
				agent.trees.set( 24, new Tree( me ));
				agent.trees[24].size = 2;
				agent.trees.set( 19, new Tree( me ));
				agent.trees[19].size = 2;
				agent.trees.set( 28, new Tree( opp ));
				agent.trees[28].size = 2;
				agent.trees.set( 33, new Tree( opp ));
				agent.trees[33].size = 2;
				agent.getAverageShadowOfCoord( agent.board.coords[1], 0 ).should.be( 0 );
			});
			
		});
	}
}