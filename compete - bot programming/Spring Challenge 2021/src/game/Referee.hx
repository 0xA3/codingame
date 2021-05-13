package game;

import Std.parseInt;
import agent.Agent;
import gameengine.core.GameManager;

using Lambda;
using StringTools;

class Referee {
	static final gridCoords = [
		{ x: 14, y: 11 }, //  0
		{ x: 18, y: 11 }, //  1
		{ x: 16, y:  8 }, //  2
		{ x: 12, y:  8 }, //  3
		{ x: 10, y: 11 }, //  4
		{ x: 12, y: 14 }, //  5
		{ x: 16, y: 14 }, //  6
		{ x: 22, y: 11 }, //  7
		{ x: 20, y:  8 }, //  8
		{ x: 18, y:  5 }, //  9
		{ x: 14, y:  5 }, // 10
		{ x: 10, y:  5 }, // 11
		{ x:  8, y:  8 }, // 12
		{ x:  6, y: 11 }, // 13
		{ x:  8, y: 14 }, // 14
		{ x: 10, y: 17 }, // 15
		{ x: 14, y: 17 }, // 16
		{ x: 18, y: 17 }, // 17
		{ x: 20, y: 14 }, // 18
		{ x: 26, y: 11 }, // 19
		{ x: 24, y:  8 }, // 20
		{ x: 22, y:  5 }, // 21
		{ x: 20, y:  2 }, // 22
		{ x: 16, y:  2 }, // 23
		{ x: 12, y:  2 }, // 24
		{ x:  8, y:  2 }, // 25
		{ x:  6, y:  5 }, // 26
		{ x:  4, y:  8 }, // 27
		{ x:  2, y: 11 }, // 28
		{ x:  4, y: 14 }, // 29
		{ x:  6, y: 17 }, // 30
		{ x:  8, y: 20 }, // 31
		{ x: 12, y: 20 }, // 32
		{ x: 16, y: 20 }, // 33
		{ x: 20, y: 20 }, // 34
		{ x: 22, y: 17 }, // 35
		{ x: 24, y: 14 }  // 36
	];
	
	static var gameManager:GameManager;
	static var gameSummaryManager:GameSummaryManager;
	static var commandManager:CommandManager;
	static var grid:Array<String>;
	static var agentOpp:Agent;
	static var agentMe:Agent;
	static var agents:Array<Agent> = [];
	static var game:Game;

	static var repeats:Int;
	static var scores:Array<Array<Int>> = [];

	static function main() {
		
		final args = Sys.args();
		repeats = args[0] == null ? 1 : parseInt( args[0] );
		for( _ in 0...repeats ) {
			init();
			run();
		}
		outputScoreAverages();
	}

	static function init() {
		final gridFile = CompileTime.readFile( "src/grid.txt" );
		grid = gridFile.replace( "\r", "" ).split( "\n" );

		final oppName ="Agent3";
		final myName = "Agent4";
		// manager
		final managerPlayer0 = new Player( 0, oppName );
		final managerPlayer1 = new Player( 1, myName );
		gameManager = new GameManager([ managerPlayer0, managerPlayer1 ]);
		gameSummaryManager = new GameSummaryManager();
		commandManager = new CommandManager();
		
		// game
		game = new Game( gameManager, gameSummaryManager );
		game.init( 1 + scores.length, grid );
		
		// agents
		final agentPlayer1 = new Player( 0, oppName );
		final agentPlayer2 = new Player( 1, myName );
		final boardPlayer1 = game.board.copy();
		final boardPlayer2 = game.board.copy();
		
		agentOpp = new agent.Agent3( agentPlayer1, agentPlayer2, boardPlayer1 );
		agentMe = new agent.Agent4( agentPlayer2, agentPlayer1, boardPlayer2 );
		
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
			
			if( repeats == 1 ) {
				outputGrid();
				final char = Sys.getChar( false );
				if( char == 27 || char == 3 ) Sys.exit( 0 );
			}
	
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

	static function outputGrid() {
		final gc = grid.copy();
		for( index => tree in game.trees ) {
			final symbol = switch [tree.owner.index, tree.size] {
				case [0, 0]: ".";
				case [0, 1]: ";";
				case [0, 2]: "t";
				case [0, 3]: "T";
				case [1, 0]: "0";
				case [1, 1]: "1";
				case [1, 2]: "2";
				case [1, 3]: "3";
				default: " ";
			}
			final point = gridCoords[index];
			gc[point.y] = insertChar( gc[point.y], point.x, symbol );
		}

		Sys.println( "\n" + gc.join( "\n" ));
	}

	static inline function insertChar( line:String, x:Int, s:String ) {
		return line.substr( 0, x ) + s + line.substr( x + 1 );
	}

}
