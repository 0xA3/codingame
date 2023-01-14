package test.game;

import agent.Agent;
import game.GameEntity;
import game.Hero;
import game.Player;
import game.Referee;
import game.Vector;
import gameengine.core.GameManager;

using buddy.Should;

@:access(game.Referee)
class TestHandleCommands extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test HandleCommands", {
			
			var player:Player;
			var hero:Hero;
			var referee:Referee;
			beforeEach({
				player = new Player( 0, "", 0, 0 );
				hero = new Hero( 0, 0, new Vector( 0, 0 ), player, 0 );
				player.addHero( hero );
				referee = new Referee( new GameManager( [player, player] ), [], new Agent(), new Agent() );
			});

			it( "wait", {
				referee.handleCommands( player, ["WAIT"] );
				hero.message.should.be( "" );
			});
			
			it( "message", {
				referee.handleCommands( player, ["WAIT nothing to do..."] );
				hero.message.should.be( "nothing to do..." );
			});
			
			it( "move", {
				referee.handleCommands( player, ["MOVE 80 45 time to move"] );
				hero.intent.destination.x.should.be( 80 );
				hero.intent.destination.y.should.be( 45 );
				hero.message.should.be( "time to move" );
			});
			
			it( "wind", {
				referee.handleCommands( player, ["SPELL WIND 80 40 casting a wind spell!"] );
				hero.intent.destination.x.should.be( 80 );
				hero.intent.destination.y.should.be( 40 );
				hero.message.should.be( "casting a wind spell!" );
			});
			
			it( "shield", {
				referee.handleCommands( player, ["SPELL SHIELD 1 casting a shield spell!"] );
				hero.intent.target.should.be( 1 );
				hero.message.should.be( "casting a shield spell!" );
			});
			
			it( "control", {
				referee.handleCommands( player, ["SPELL CONTROL 1 80 40 casting a control spell!"] );
				hero.intent.target.should.be( 1 );
				hero.intent.destination.x.should.be( 80 );
				hero.intent.destination.y.should.be( 40 );
				hero.message.should.be( "casting a control spell!" );
			});
			
		});
	}
}