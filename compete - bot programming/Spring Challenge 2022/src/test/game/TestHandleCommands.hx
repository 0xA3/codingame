package test.game;

import game.Hero;
import game.Player;
import game.Vector;

using buddy.Should;

@:access(game.Referee)
class TestHandleCommands extends buddy.BuddySuite {
	
	public function new() {
		
		@include describe( "Test HandleCommands", {
			
			var player:Player;
			var hero:Hero;

			beforeEach({
				player = new Player( 0 );
				hero = new Hero( 0, new Vector( 0, 0 ), player, 0 );
				player.addHero( hero );
			});

			it( "message", {
				game.Referee.handleCommands( player, ["WAIT nothing to do..."] );
				hero.message.should.be( "nothing to do..." );
			});
			
			it( "move", {
				game.Referee.handleCommands( player, ["MOVE 80 45 time to move"] );
				hero.intent.destination.x.should.be( 80 );
				hero.intent.destination.y.should.be( 45 );
				hero.message.should.be( "time to move" );
			});
			
			it( "wind", {
				game.Referee.handleCommands( player, ["SPELL WIND 80 40 casting a wind spell!"] );
				hero.intent.destination.x.should.be( 80 );
				hero.intent.destination.y.should.be( 40 );
				hero.message.should.be( "casting a wind spell!" );
			});
			
			it( "shield", {
				game.Referee.handleCommands( player, ["SPELL SHIELD 1 casting a shield spell!"] );
				hero.intent.target.should.be( 1 );
				hero.message.should.be( "casting a shield spell!" );
			});
			
			it( "control", {
				game.Referee.handleCommands( player, ["SPELL CONTROL 1 80 40 casting a control spell!"] );
				hero.intent.target.should.be( 1 );
				hero.intent.destination.x.should.be( 80 );
				hero.intent.destination.y.should.be( 40 );
				hero.message.should.be( "casting a control spell!" );
			});
			
		});
	}
}