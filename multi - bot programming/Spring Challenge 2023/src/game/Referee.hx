package game;

import gameengine.core.AbstractPlayer.TimeoutException;
import gameengine.core.AbstractReferee;
import gameengine.core.MultiplayerGameManager;
import view.ViewModule;

class Referee extends AbstractReferee {

	final gameManager:MultiplayerGameManager;
	final commandManager:CommandManager;
	final game:Game;
	final viewModule:ViewModule;

	public function new(
		gameManager:MultiplayerGameManager,
		commandManager:CommandManager,
		game:Game,
		viewModule:ViewModule
	) {
		this.gameManager = gameManager;
		this.commandManager = commandManager;
		this.game = game;
		this.viewModule = viewModule;
	}

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
			for( line in game.getGlobalInfoFor( cast player )) {
				player.sendInputLine( line );
			}
		}
	}

	override function gameTurn( turn:Int ) {
		//trace( 'gameTurn $turn' );
		try {
			game.resetGameTurnData();
			for( player in gameManager.getActivePlayers()) {
				for( line in game.getCurrentFrameInfoFor( cast player )) {
					player.sendInputLine( line );
				}
				player.execute();
			}
			// Get output from players
			handlePlayerCommands();
		}
	}

	function handlePlayerCommands() {
		
		for( player in gameManager.getActivePlayers()) {
			try {
				commandManager.parseCommands( cast player, player.getOutputs());
			} catch( e:TimeoutException ) {
				( cast player ).deactivate( "Timeout!" );
				gameManager.addToGameSummary( '${player.getNicknameToken()} has not provided ${player.getExpectedOutputLines()} lines in time' );
			}
		}
	}

	override function onEnd() {
		game.onEnd();
	}

}