package game;

import Std.int;
import Std.parseInt;
import ai.IAi;
import game.Coord;
import game.action.Action;
import game.action.ActionException;
import gameengine.core.GameManager;
import gameengine.core.TimeoutException;
import haxe.Exception;
import haxe.Timer;
import view.EntityData;
import view.ViewModule;
import xa3.MTRandom;

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
			if( leagueLevel == 1 ) {
				Config.MAP_MAX_WIDTH = 15;
			}

			game.init();
			sendGlobalInfo();

			gameManager.frameDuration = 500;
			gameManager.maxTurns = Config.MAX_TURNS;
			gameManager.turnMaxTime = 50;
		
		} catch( e:Exception ) {
			trace( e );
			abort();
		}
	}

	function abort() gameManager.endGame();

	public function run() {
		turn = 0;
		// while( turn < 1 && !gameManager.gameEnd ) {
		while( !gameManager.gameEnd ) {
			gameTurn( turn++ );
		}
		onEnd();
		return gameManager.players.map( player -> player.score );
	}

	public function runWithTimer() {
		turn = 0;
		timer = new Timer( 5 );
		timer.run = nextTurn;
	}

	function nextTurn() {
		if( gameManager.gameEnd ) {
			timer.stop();
			onEnd();
			return;
		}
		gameTurn( turn++ );
	}

	function sendGlobalInfo() {
		for( player in gameManager.getActivePlayers() ) {
			for( line in game.getCurrentFrameInfoFor( player )) player.sendInputLine( line );
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
				commandManager.parseCommands( player, player.getOutputs());
			} catch( e:TimeoutException ) {
				player.deactivate( "Timeout!" );
				gameManager.addToGameSummary( '${player.name} has not provided ${player.getExpectedOutputLines()} lines in time' );
			}
		}
	}


	public static function join( args:Array<Dynamic> ) return args.join(" ");

	public function onEnd() game.onEnd();
}
