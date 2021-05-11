package game;

import agent.Agent;
import gameengine.core.GameManager;

class Referee {
	static var gameManager:GameManager;
	static var gameSummaryManager:GameSummaryManager;
	static var commandManager:CommandManager;
	static var game:Game;
	static var agentOpp:Agent;
	static var agentMe:Agent;
	static var agents:Array<Agent> = [];

	static function main() {
		init();
		trace( "\n\n" );
		run();
	}

	static function init() {
		final oppName ="Oldie";
		final myName = "Cr0m";
		// manager
		final managerPlayer0 = new Player( 0, oppName );
		final managerPlayer1 = new Player( 1, myName );
		gameManager = new GameManager([ managerPlayer0, managerPlayer1 ]);
		gameSummaryManager = new GameSummaryManager();
		commandManager = new CommandManager();
		
		// game
		game = new Game( gameManager, gameSummaryManager );
		game.init( 0 );
		
		// agents
		final agentPlayer1 = new Player( 0, oppName );
		final agentPlayer2 = new Player( 1, myName );
		final boardPlayer1 = game.board.copy();
		final boardPlayer2 = game.board.copy();
		
		agentOpp = new agent.Agent1( agentPlayer1, agentPlayer2, boardPlayer1 );
		agentMe = new agent.Agent2( agentPlayer2, agentPlayer1, boardPlayer2 );
		
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
					trace( 'player ${player.index}: $output' );
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
		for( player in gameManager.players ) {
			trace( '${player.name} score: ${player.score}' );
		}
	}

}