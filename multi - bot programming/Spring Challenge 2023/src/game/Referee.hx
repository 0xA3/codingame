package game;

import gameengine.core.AbstractReferee;
import gameengine.core.GameManager;
import view.ViewModule;

@:structInit class Referee extends AbstractReferee {

	final gameManager:GameManager;
	final commandManager:CommandManager;
	final game:Game;
	final viewModule:ViewModule;

	override public function init() {
		try {	
			final leagueLevel = gameManager.getLeagueLevel();

			if( leagueLevel == 1 ) {
				Config.FORCE_SINGLE_HILL = true;
				Config.ENABLE_EGGS = false;
				Config.LOSING_ANTS_CANT_CARRY = false;
				Config.MAP_RING_COUNT_MAX = 4;
			} else if( leagueLevel == 2 ) {
				Config.FORCE_SINGLE_HILL = true;
				Config.LOSING_ANTS_CANT_CARRY = false;
				Config.MAP_RING_COUNT_MAX = 5;
			}
			// level 3 = interactions, big map, multiple hills
			if ( leagueLevel >= 4 ) {
				Config.SCORES_IN_IO = true;
			}
			
			//Config.takeFrom( gameManager.getGameParameters() ); // not implemented

			game.init();
			sendGlobalInfo();

			gameManager.setFrameDuration( 500 );
			gameManager.setMaxTurns( Config.MAX_TURNS );
			gameManager.setTurnMaxTime( 100 );
		} catch( e ) {
			// e.printStackTrace();
			Sys.println("Referee failed to initialize");
			abort();
		}
	}

	function abort() {
		gameManager.endGame();
	}

	function sendGlobalInfo() {
		// Give input to players
		for( player in gameManager.getActivePlayers()) {
			for( line in game.getGlobalInfoFor( player )) {
				player.sendInputLine( line );
			}
		}
	}
}