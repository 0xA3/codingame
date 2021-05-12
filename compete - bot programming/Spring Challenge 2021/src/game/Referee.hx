package game;

import Std.parseInt;
import agent.Agent;
import gameengine.core.GameManager;
import hl.Profile;

using Lambda;

class Referee {
	static var gameManager:GameManager;
	static var gameSummaryManager:GameSummaryManager;
	static var commandManager:CommandManager;
	static var game:Game;
	static var agentOpp:Agent;
	static var agentMe:Agent;
	static var agents:Array<Agent> = [];

	static var scores:Array<Array<Int>> = [];

	static function main() {
		
		final args = Sys.args();
		final repeats = args[0] == null ? 1 : parseInt( args[0] );
		for( _ in 0...repeats ) {
			init();
			run();
		}
		outputScoreAverages();
	}

	static function init() {
		final oppName ="Agent2";
		final myName = "Agent3";
		// manager
		final managerPlayer0 = new Player( 0, oppName );
		final managerPlayer1 = new Player( 1, myName );
		gameManager = new GameManager([ managerPlayer0, managerPlayer1 ]);
		gameSummaryManager = new GameSummaryManager();
		commandManager = new CommandManager();
		
		// game
		game = new Game( gameManager, gameSummaryManager );
		game.init( 1 + scores.length );
		
		// agents
		final agentPlayer1 = new Player( 0, oppName );
		final agentPlayer2 = new Player( 1, myName );
		final boardPlayer1 = game.board.copy();
		final boardPlayer2 = game.board.copy();
		
		agentOpp = new agent.Agent2( agentPlayer1, agentPlayer2, boardPlayer1 );
		agentMe = new agent.Agent3( agentPlayer2, agentPlayer1, boardPlayer2 );
		
		agents.push( agentOpp );
		agents.push( agentMe );
		
	}


	static function run() {
		var actionTurn = 0;
		// while( actionTurn < 3 && !gameManager.gameEnd ) {
		while( !gameManager.gameEnd ) {
			if( game.currentFrameType == FrameType.ACTIONS ) actionTurn++;
			gameTurn();
		}
		onEnd();
	}

	static function abort() {
		trace( 'Unexpected game end' );
		gameManager.endGame();
	}

	static inline function gameTurn() {
		game.resetGameTurnData();

		if( game.currentFrameType == FrameType.ACTIONS ) {
			// Give input to players
			for( i in 0...gameManager.players.length ) {
				final player = gameManager.players[i];
				if( !player.isWaiting ) {
					// final lines = game.getCurrentFrameInfoFor( player );
					final d = game.getCurrentFrameDatasetFor( player );
					final output = agents[i].process( d.day, d.nutrients, d.myInputs, d.otherInputs, d.treesInputs, d.possibleActions );
					// if( player.index == 1 ) trace( 'day ${d.day} sun ${player.sun} player ${player.index}: $output' );
					player.setOutputs( [output] );
				}
			}
			// Get output from players
			handlePlayerCommands();
		}

		game.performGameUpdate();
	}

	static function handlePlayerCommands() {
		for( player in gameManager.players ) {
			if( !player.isWaiting ) {
				try {
					commandManager.parseCommands( player, player.getOutputs(), game );
				} catch( e:Dynamic ) {
					throw 'Error wrong command ${player.getOutputs()}: $e';
				}
			}
		}
	}

	static function onEnd() {
		final pScores = [];
		for( player in gameManager.players ) {
			pScores.push( player.score );
			// trace( '${player.name} score: ${player.score}' );
		}
		scores.push( pScores );
	}

	static function outputScoreAverages() {
		trace( '-- Averages-- ' );
		for( i in 0...gameManager.players.length ) {
			final sum = scores.fold(( pScores, sum ) -> sum + pScores[i], 0 );
			trace( '${gameManager.players[i].name} ${sum / scores.length}' );
		}
	}

}