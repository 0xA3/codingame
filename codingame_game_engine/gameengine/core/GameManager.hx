package gameengine.core;

import gameengine.core.InputCommand;
import gameengine.exception.IllegalArgumentException;
import gameengine.exception.IllegalStateException;
import gameengine.exception.RuntimeException;
import gameengine.java.Log;
import gameengine.java.Scanner;
import haxe.Json;
import haxe.ds.Vector;
import haxe.Timer;
import main.game.Player;
import main.view.FrameViewData;
import main.view.GlobalViewData;
import tink.core.Signal;

using Lambda;
/**
 * The <code>GameManager</code> takes care of running each turn of the game and computing each visual frame of the replay. It provides many utility
 * methods that handle instances of your implementation of AbstractPlayer.
 *
 * @param <T>
 *            Your implementation of AbstractPlayer
 */
abstract class GameManager {
	
	static final log = new Log();

	static final VIEW_DATA_TOTAL_SOFT_QUOTA = 512 * 1024;
	static final VIEW_DATA_TOTAL_HARD_QUOTA = 1024 * 1024;
	static final GAME_SUMMARY_TOTAL_HARD_QUOTA = 512 * 1024;
	static final GAME_SUMMARY_PER_TURN_HARD_QUOTA = 800;
	static final GAME_DURATION_HARD_QUOTA = 30000;
	static final GAME_DURATION_SOFT_QUOTA = 25000;
	static final MAX_TURN_TIME = GAME_DURATION_SOFT_QUOTA;
	static final MIN_TURN_TIME = 50;

	var players:Array<AbstractPlayer>;
	var maxTurns = 200;
	var turnMaxTime = 50;
	var firstTurnMaxTime = 1000;
	var turn = 0;
	var frame = 0;
	var gameEnd = false;
	var s:Scanner;
	var out:haxe.ds.List<String>;
	var referee:AbstractReferee;
	var newTurn:Bool;
	
	var currentTooltips:Array<Tooltip> = [];
	var prevTooltips:Array<Tooltip>;

	var currentGameSummary:Array<String> = [];
	var prevGameSummary:Array<String>;

	var currentViewData:FrameViewData;
	var prevViewData:FrameViewData;

	var frameDuration = 1000;

	var globalViewData:GlobalViewData;

	var registeredModules:Array<Module> = [];

	var metadata:Map<String, String> = [];

	var initDone = false;
	var outputsRead = false;
	var totalViewDataBytesSent = 0;
	var totalGameSummaryBytes = 0;
	var totalTurnTime = 0;

	var viewWarning:Bool;
	var summaryWarning:Bool;
	
	final globalViewDataTrigger:SignalTrigger<GlobalViewData>;
	final frameViewDataTrigger:SignalTrigger<FrameViewData>;
	final nextPlayerInfoTrigger:SignalTrigger<String>;
	final nextPlayerInputTrigger:SignalTrigger<String>;

	var timer = new Timer( 1 );

	public function new(
		globalViewDataTrigger:SignalTrigger<GlobalViewData>,
		frameViewDataTrigger:SignalTrigger<FrameViewData>,
		nextPlayerInfoTrigger:SignalTrigger<String>,
		nextPlayerInputTrigger:SignalTrigger<String>
	) {
		this.globalViewDataTrigger = globalViewDataTrigger;
		this.frameViewDataTrigger = frameViewDataTrigger;
		this.nextPlayerInfoTrigger = nextPlayerInfoTrigger;
		this.nextPlayerInputTrigger = nextPlayerInputTrigger;
	}

	public function inject( referee:AbstractReferee, players:Array<AbstractPlayer> ) {
		this.referee = referee;
		this.players = players;
	}
	
	public function init() {
		frame = 0;
		gameEnd = false;

		currentTooltips.splice( 0, currentTooltips.length );
		currentGameSummary.splice( 0, currentGameSummary.length );

		initDone = false;
		outputsRead = false;
		totalViewDataBytesSent = 0;
		totalGameSummaryBytes = 0;
		totalTurnTime = 0;
		// for( player in players ) player.init();
	}

	/**
	 * GameManager main loop.
	 *
	 * @param is
	 *            input stream used to read commands from Game
	 * @param out
	 *            print stream used to issue commands to Game
	 */
	public function start( inputStream:haxe.ds.List<String>, out:haxe.ds.List<String>, withTimer = false ) {
		s = new Scanner( inputStream );
		// try {
			this.out = out;
		
			// Init ---------------------------------------------------------------
			log.info( "Init" );
			final iCmd = InputCommand.parse( s.nextLine());
			final playerCount = s.nextInt();
			s.nextLine();

			// for( i in 0...playerCount ) {
			// 	final player = players[i];
			// 	player.setIndex( i ); // index is already set in constructor
			// }

			readGameProperties( iCmd, s );

			prevViewData = new FrameViewData();
			currentViewData = new FrameViewData();

			referee.init();
			registeredModules.iter( module -> module.onGameInit());
			initDone = true;

			// Game Loop ----------------------------------------------------------
			turn = 1;
			if( withTimer ) {
				loopWithTimer();
			} else {
				while( turn <= getMaxTurns() && !isGameEnd() && !allPlayersInactive() ) {
					processTurn();
				}
				end();
			}

		// } catch( e ) {
		// 	dumpFail( e );
		// 	s.close();
		// 	throw e;
		// }
	}

	function loopWithTimer() {
		timer.stop();
		// if( turn <= getMaxTurns() && !isGameEnd() && !allPlayersInactive() ) {
		if( turn <= 2 && !isGameEnd() && !allPlayersInactive() ) {
			processTurn();
			timer = new Timer( 10 );
			timer.run = loopWithTimer;
		} else {
			end();
		}
	}
	
	function processTurn() {
		swapInfoAndViewData();
		log.info( 'Turn ' + turn );
		newTurn = true;
		outputsRead = false; // Set as true after first getOutputs() to forbid sendInputs

		referee.gameTurn( turn );
		registeredModules.iter( module -> module.onAfterGameTurn());
		// Create a frame if no player has been executed
		if( players.length != 0 && players.filter( p -> p.hasBeenExecuted() ).length == 0 ) {
			executePlayer( players[0], 0 );
		}

		// reset players' outputs
		for( player in players ) {
			player.resetOutputs();
			player.setHasBeenExecuted( false );
		}

		turn++;
	}

	function end() {
		log.info( "End" );

		referee.onEnd();
		registeredModules.iter( module -> module.onAfterOnEnd());

		// Send last frame ----------------------------------------------------
		swapInfoAndViewData();
		newTurn = true;

		dumpView();
		dumpInfos();

		dumpGameProperties();
		dumpMetadata();
		dumpScores();
		
		s.close();
	}

	function allPlayersInactive() return false;

	public function readGameProperties( iCmd:InputCommand, s:Scanner ) {}

	/**
	 * Executes a player for a maximum of turnMaxTime milliseconds and store the output. Used by player.execute().
	 *
	 * @param player
	 *            Player to execute.
	 * @param nbrOutputLines
	 *            The amount of expected output lines from the player.
	 */
	function executePlayer( player:AbstractPlayer, nbrOutputLines:Int ) {
		// trace( 'executePlayer ${player.getIndex()}' );
		final playerIndex = player.getIndex();
		// try {
			if( !this.initDone ) {
				throw new RuntimeException( "Impossible to execute a player during init phase." );
			}

			player.setTimeout( false );

			var iCmd = InputCommand.parse( s.nextLine());

			if ( iCmd.cmd != InputCommand.Command.GET_GAME_INFO ) {
			    throw new RuntimeException( "Invalid command: " + iCmd.cmd );
			}

			if( playerIndex == 0 ) dumpView();
			if( playerIndex == 0 ) dumpInfos();
			dumpNextPlayerInput( player.getInputs() );
			if( nbrOutputLines > 0 ) {
				addTurnTime();
			}
			dumpNextPlayerInfos( player.getIndex(), nbrOutputLines, player.hasNeverBeenExecuted() ? firstTurnMaxTime : turnMaxTime );
			
			// READ PLAYER OUTPUTS
			iCmd = InputCommand.parse( s.nextLine() );
			if( iCmd.cmd == gameengine.core.Command.SET_PLAYER_OUTPUT ) {
				if( iCmd.lineCount == 0 ) throw new RuntimeException( "InputCommand line count is 0" );
				final outputs = new Vector<String>( iCmd.lineCount );
				for( i in 0...iCmd.lineCount ) outputs[i] = s.nextLine();
				player.setOutputs( outputs.toArray() );
			} else if( iCmd.cmd == InputCommand.Command.SET_PLAYER_TIMEOUT ) {
				player.setTimeout( true );
			} else {
				throw new RuntimeException( "Invalid command: " + iCmd.cmd );
			}
		// } catch ( e ) {
            //Don't let the user catch game fail exceptions
            // dumpFail( e );
            // throw e;
        // }
	}
		/**
	 * Executes a player for a maximum of turnMaxTime milliseconds and store the output. Used by player.execute().
	 *
	 * @param player
	 *            Player to execute.
	 */
	public function execute( player:AbstractPlayer ) {
		executePlayer( player, player.getExpectedOutputLines() );
	}

	/**
	 * Swap game summary and view.
	 *
	 * As these values are sent in the first call to gameManger.execute(player), this function allows to change the current view at the end of each
	 * gameTurn instead of the middle of the gameTurn.
	 */
	function swapInfoAndViewData() {
		prevViewData = currentViewData;
		currentViewData = new FrameViewData();

		prevGameSummary = currentGameSummary;
		currentGameSummary = [];

		prevTooltips = currentTooltips;
		currentTooltips = [];
	}

	function dumpGameProperties() {}

	function dumpMetadata() {
		// trace( "dumpMetadata" );
		final data = new OutputData( OutputCommand.METADATA );
		data.add( getMetadata() );
		// out.add( data.toString() );
	}

	function dumpScores() {
		// trace( "dumpScores" );
		final data = new OutputData( OutputCommand.SCORES );
		final playerScores = [];
		for( player in players ) {
			playerScores.push( '${player.getIndex()} ${player.getScore()}' );
		}
		data.addAll( playerScores );
		// out.add( data.toString() );
	}

	function dumpFail( e ) {
		final data = new OutputData( OutputCommand.FAIL );
		data.add( e.toString());
		// out.add( data.toString() );
	}

	function dumpView() {
		// trace( "dumpView" );
		final data = new OutputData( OutputCommand.VIEW );
		if( newTurn ) {
			// data.add( 'KEY_FRAME $frame' );
			prevViewData.type = "KEY_FRAME";
			if( turn == 1 ) {
				// final initFrame = {
				// 	global: globalViewData,
				// 	frame: prevViewData
				// }
				// data.add( Json.stringify( initFrame ));
				globalViewDataTrigger.trigger( globalViewData );

			} else {
				data.add( Json.stringify( prevViewData ));
			}
		} else {
			// data.add( 'INTERMEDIATE_FRAME $frame' );
			prevViewData.type = "INTERMEDIATE_FRAME";
		}
		// final viewData = data.toString();
		// totalViewDataBytesSent = data.toString().length;

		// if( totalViewDataBytesSent > VIEW_DATA_TOTAL_HARD_QUOTA ) {
		// 	throw new RuntimeException( "The amount of data sent to the viewer is too big!" );
		// } else if( totalViewDataBytesSent > VIEW_DATA_TOTAL_SOFT_QUOTA && !viewWarning ) {
		// 	log.warn( "Warning: the amount of data sent to the viewer is too big.\nPlease try to optimize your code to send less data (try replacing some commitEntityStates by a commitWorldState)." );
		// 	viewWarning = true;
		// }

		prevViewData.frame = turn;

		// trace( 'viewData: $viewData' );
		// log.info( viewData );
		// out.add( viewData );
		frameViewDataTrigger.trigger( prevViewData );

		frame++;
	}

	function dumpInfos() {
		// trace( "dumpInfos" );
		final data = new OutputData( OutputCommand.INFOS );
		// Sys.println( data.toString() );

		if( newTurn && prevGameSummary != null ) {
			final summary = new OutputData( getGameSummaryOutputCommand());
			summary.addAll( prevGameSummary );
			// out.add( summary.toString() );
			// trace( 'dumpInfos Summary: $summary' );
		}

		if( newTurn && prevTooltips != null && prevTooltips.length > 0 ) {
			final data = new OutputData( OutputCommand.TOOLTIP );
			for( t in prevTooltips ) {
				data.add( t.message );
				data.add( '${t.player}' );
			}
			// out.add( data.toString() );
			// trace( 'dumpInfos Tooltips: $data' );
		}
	}

	function getGameSummaryOutputCommand() {
		return OutputCommand.FAIL; // placeholder for return value of sub class
	}

	function dumpNextPlayerInfos( nextPlayer:Int, expectedOutputLineCount:Int, timeout:Int ) {
		// trace( "dumpNextPlayerInfos" );
		final data = new OutputData( OutputCommand.NEXT_PLAYER_INFO );
		data.add( '$nextPlayer' );
		data.add( '$expectedOutputLineCount' );
		data.add( '$timeout' );

		// out.add( data.toString() );
		nextPlayerInfoTrigger.trigger( data.toString() );
	}

	function dumpNextPlayerInput( input:Array<String> ) {
		// trace( "dumpNextPlayerInput" );
		final data = new OutputData( OutputCommand.NEXT_PLAYER_INPUT );
		data.addAll( input );
		// out.add( data.toString() );
		if( log.isInfoEnabled()) {
			// log.info( data.toString() );
		}
		nextPlayerInputTrigger.trigger( data.toString() );
	}

	function getMetadata() {
		return metadata.toString();
	}

	public function setOutputsRead( outputsRead:Bool ) {
		this.outputsRead = outputsRead;
	}

	public function getOutputsRead() {
		return outputsRead;
	}

 	//
	//public methods used by Referee:
	//

	/**
	 * Puts a new metadata that will be included in the game's <code>GameResult</code>.
	 * <p>
	 * Can be used for:
	 * </p>
	 * <ul>
	 * <li>Setting the value of an optimization criteria for OPTI games, used by the CodinGame IDE</li>
	 * <li>Dumping game statistics for local analysis after a batch run of GameRunner.simulate()</li>
	 * </ul>
	 *
	 * @param key
	 *            the property to send
	 * @param value
	 *            the property's value
	 */
	public function putMetadata( key:String, value:String ) {
		metadata.set( key, value );
	}

   /**
	 * Specifies the frameDuration in milliseconds. Default: 1000ms
	 *
	 * @param frameDuration
	 *            The frame duration in milliseconds.
	 * @throws IllegalArgumentException
	 *             if frameDuration &le; 0
	 */
	public function setFrameDuration( frameDuration:Int ) {
		if (frameDuration <= 0) {
			 throw new IllegalArgumentException( "Invalid frame duration: only positive frame duration is supported" );
		} else if( this.frameDuration != frameDuration ) {
			this.frameDuration = frameDuration;
			currentViewData.duration = frameDuration;
		}
	}

	/**
	 * Returns the duration in milliseconds for the frame currently being computed.
	 *
	 * @return the frame duration in milliseconds.
	 */
	public function getFrameDuration() {
		return frameDuration;
	}

	/**
	 * Set game end.
	 */
	public function endGame() {
		gameEnd = true;
	}
	
	/**
	 * Check if the game has been terminated by the referee.
	 *
	 * @return true if the game is over.
	 */
	public function isGameEnd() {
		return this.gameEnd;
	}

	/**
	 * Set the maximum amount of turns. Default: 400.
	 *
	 * @param maxTurns
	 *            the number of turns for a game.
	 * @throws IllegalArgumentException
	 *             if maxTurns &le; 0
	 */
	public function setMaxTurns( maxTurns :Int )  {
		if (maxTurns <= 0) {
			throw new IllegalArgumentException( "Invalid maximum number of turns" );
		}
		this.maxTurns = maxTurns;
	}

	/**
	 * Get the maximum amount of turns.
	 *
	 * @return the maximum number of turns.
	 */
	public function getMaxTurns() {
		return maxTurns;
	}

   /**
	 * Set the timeout delay for every player. This value can be updated during a game and will be used by execute(). Default is 50ms.
	 *
	 * @param turnMaxTime
	 *            Duration in milliseconds.
	 * @throws IllegalArgumentException
	 *             if turnMaxTime &lt; 50 or &gt; 25000
	 */
	public function setTurnMaxTime( turnMaxTime:Int ) {
		if( turnMaxTime < MIN_TURN_TIME ) {
			throw new IllegalArgumentException( "Invalid turn max time : stay above 50ms" );
		} else if( turnMaxTime > MAX_TURN_TIME ) {
			throw new IllegalArgumentException( "Invalid turn max time : stay under 25s" );
		}
		this.turnMaxTime = turnMaxTime;
	}

	/**
	 * Set the timeout delay of the first turn for every player. Default is 1000ms.
	 *
	 * @param firstTurnMaxTime
	 *            Duration in milliseconds.
	 * @throws IllegalArgumentException
	 *             if firstTurnMaxTime &lt; 50 or &gt; 25000
	 */
	public function setFirstTurnMaxTime( firstTurnMaxTime:Int ) {
		if( firstTurnMaxTime < MIN_TURN_TIME ) {
			throw new IllegalArgumentException( "Invalid turn max time : stay above 50ms" );
		} else if (firstTurnMaxTime > MAX_TURN_TIME) {
			throw new IllegalArgumentException( "Invalid turn max time : stay under 25s" );
		}
		this.firstTurnMaxTime = firstTurnMaxTime;
	}

	/**
	 * Get the timeout delay for every player.
	 *
	 * @return the current timeout duration in milliseconds.
	*/
	public function getTurnMaxTime() {
		return turnMaxTime;
	}
	
	/**
	 * Get the timeout delay of the first turn for every player.
	 *
	 * @return the first turn timeout duration in milliseconds.
	*/
	public function getFirstTurnMaxTime() {
		return firstTurnMaxTime;
	}

	/**
	 * Set data for use by the viewer, for the current frame.
	 *
	 * @param data
	 *            any object that can be serialized in JSON using gson.
	 */
	public function setViewData( moduleName = "default", data:FrameViewData ) {
		setModuleViewData( moduleName, data );
	}

	/**
	 * Set data for use by the viewer, for the current frame, for a specific module.
	 *
	 * @param moduleName
	 *            the name of the module
	 * @param data
	 *            any object that can be serialized in JSON using gson.
	 */
	public function setModuleViewData( moduleName:String, data:FrameViewData ) {
		currentViewData = data;
	}

	/**
	 * Set data for use by the viewer and not related to a specific frame. This must be use in the init only.
	 *
	 * @param moduleName
	 *            the name of the module
	 * @param data
	 *            any object that can be serialized in JSON using gson.
	 */
	public function setViewGlobalData( moduleName:String, data:GlobalViewData ) {
		if( initDone ) {
			throw new IllegalStateException( "Impossible to send global data to view outside of init phase" );
		}
		globalViewData = data;
	}
	
	/**
	 * Adds a tooltip for the current turn.
	 *
	 * @param tooltip
	 *            A tooltip that will be shown in the player.
	 */
	public function addTooltip( tooltip:Tooltip ) {
		currentTooltips.push( tooltip );
	}
	
	/**
	 * Adds a tooltip for the current turn.
	 *
	 * @param player
	 * The player the tooltip information is about.
	 * @param message
	 * Tooltip message.
	 */
	public function addPlayerTooltip( player:Player, message:String ) {
		currentTooltips.push( new Tooltip( player.getIndex(), message ));
	}

	/**
	 * Add a new line to the game summary for the current turn.
	 *
	 * @param summary
	 * summary line to add to the current summary.
	 */
	public function addToGameSummary( summary:String ) {
		
		#if game Sys.println( summary ); #end
		
		final total = currentGameSummary.length + summary.length;

		if( total < GAME_SUMMARY_PER_TURN_HARD_QUOTA && total + totalGameSummaryBytes < GAME_SUMMARY_TOTAL_HARD_QUOTA ) {
			currentGameSummary.push( summary );
			totalGameSummaryBytes += total;
		} else if( !summaryWarning ) {
			trace("Warning: the game summary is full. Please try to send less data.");
			summaryWarning = true;
		}
	}

	function addTurnTime() {
		totalTurnTime += turnMaxTime;
		if( totalTurnTime > GAME_DURATION_HARD_QUOTA ) {
			throw new RuntimeException( 'Total game duration too long (>${GAME_DURATION_HARD_QUOTA}ms)' );
		} else if (totalTurnTime > GAME_DURATION_SOFT_QUOTA) {
			log.warn( 'Warning: too many turns and/or too much time allocated to players per turn (${totalTurnTime}ms/${GAME_DURATION_HARD_QUOTA}ms)' );
		}
	}

	    /**
     * Register a module to the gameManager. After this, the gameManager will call the module callbacks automatically.
     *
     * @param module
     *            the module to register
     */
	public function registerModule( module:Module ) {
        registeredModules.push( module );
    }


   /**
     * Get current league level. The value can be set by using -Dleague.level=X where X is the league level.
     *
     * @return a strictly positive integer. 1 is the lowest level and default value.
     */
	public function getLeagueLevel() {
		// return 1; // Wood 2
		// return 2; // Wood 1
		return 3; // Above Wood
	}

    /**
     * Helper function to display a colored message. Usually used at the end of the game.
     *
     * @param message
     *            The message to display.
     * @return The formatted string.
     */
	public static function formatSuccessMessage( message:String ) {
        return return message;
    }

	/**
	 * Helper function to display a colored message. Usually used at the end of the game.
	 *
	 * @param message
	 *            The message to display.
	 * @return The formatted string.
	 */
	public static function formatErrorMessage( message:String ) return message;
}