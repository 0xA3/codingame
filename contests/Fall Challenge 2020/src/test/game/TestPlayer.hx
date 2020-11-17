package test.game;

import game.data.Player;

using buddy.Should;

class TestPlayer extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Player", {

			it( "Test clone", {
				final player = new Player();
				final playerClone = player.clone();
				playerClone.should.not.be( player );
			});


		});

	}

}
