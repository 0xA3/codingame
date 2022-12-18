package game;

import ai.IAi;
import gameengine.core.GameManager;
import gameengine.core.TimeoutException;
import haxe.Exception;
import haxe.Timer;
import view.ViewModule;

using Lambda;
using StringTools;
using xa3.MapUtils;

class Referee {
	
	final gameManager:GameManager;
	final commandManager:CommandManager;
	final game:Game;
	final viewModule:ViewModule;

	var timer = new Timer( 1 );
	var turn = 0;
	
	public function new( gameManager:GameManager, commandManager:CommandManager, game:Game, viewModule:ViewModule ) {
		this.gameManager = gameManager;
		this.commandManager = commandManager;
		this.game = game;
		this.viewModule = viewModule;
	}

	public function init() {
		try {
			final leagueLevel = gameManager.getLeagueLevel();
			if( leagueLevel == 1 ) Config.MAP_MAX_WIDTH = 15;

			game.init();
			sendGlobalInfo();

			gameManager.frameDuration = 500;
			gameManager.maxTurns = Config.MAX_TURNS;
			gameManager.turnMaxTime = 50;
		
		} catch( e:Exception ) {
			trace( e );
			trace( "Referee failed to initialize" );
			abort();
		}
	}

	function abort() gameManager.endGame();

	function sendGlobalInfo() {
		trace( 'sendGlobalInfo' );
		for( player in gameManager.getActivePlayers() ) {
			for( line in game.getGlobalInfoFor( player )) player.sendInputLine( line );
		}
	}

	public function gameTurn( turn:Int ) {
		game.resetGameTurnData();

		if( game.isKeyFrame()) {
			// Give input to players
			for( player in gameManager.getActivePlayers()) {
				for( line in game.getCurrentFrameInfoFor( player )) {
					player.sendInputLine( line );
				}
				player.execute();
			}
			// Get output from players
			handlePlayerCommands();
		}

		game.performGameUpdate( turn );

		if( gameManager.getActivePlayers().length < 2 ) abort();
	}

	function handlePlayerCommands() {
		for( player in gameManager.getActivePlayers() ) {
			try {
				commandManager.parseCommands( player, player.outputs );
			} catch( e:TimeoutException ) {
				player.deactivate( "Timeout!" );
				gameManager.addToGameSummary( '${player.name} has not provided ${player.getExpectedOutputLines()} lines in time' );
			}
		}
	}

	public static function join( args:Array<Dynamic> ) return args.join(" ");

	public function onEnd() game.onEnd();
}
