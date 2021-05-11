package game;

import agent.Agent;
import agent.WaitAgent;
import gameengine.core.GameManager;

class Referee {
	static var gameManager:GameManager;
	static var gameSummaryManager:GameSummaryManager;
	static var commandManager:CommandManager;
	static var game:Game;
	static var agent1:Agent;
	static var agent2:Agent;
	static var agents:Array<Agent> = [];

	static function main() {
		init();
		trace( "\n\n" );
		run();
	}

	static function init() {
		// manager
		final managerPlayer0 = new Player( 1 );
		final managerPlayer1 = new Player( 2 );
		gameManager = new GameManager([ managerPlayer0, managerPlayer1 ]);
		gameSummaryManager = new GameSummaryManager();
		commandManager = new CommandManager();
		
		// game
		game = new Game( gameManager, gameSummaryManager );
		game.init( 0 );
		
		// agents
		final agentPlayer1 = new Player( 1 );
		final agentPlayer2 = new Player( 2 );
		final boardPlayer1 = game.board.copy();
		final boardPlayer2 = game.board.copy();
		
		agent1 = new Agent( agentPlayer1, agentPlayer2, boardPlayer1 );
		agent2 = new WaitAgent( agentPlayer2, agentPlayer1, boardPlayer2 );
		
		agents.push( agent1 );
		agents.push( agent2 );
		
	}


	static function run() {
		var actionTurn = 0;
		// while( actionTurn < 3 && !gameManager.gameEnd ) {
		while( !gameManager.gameEnd ) {
			if( game.currentFrameType == FrameType.ACTIONS ) actionTurn++;
			gameTurn();
		}
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
					// trace( 'player ${player.index}: $output' );
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
		
	}

}