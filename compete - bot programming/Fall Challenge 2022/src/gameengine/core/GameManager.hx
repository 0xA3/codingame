package gameengine.core;

import ai.IAi;
import game.Player;
import game.Referee;
import gameengine.exception.IllegalArgumentException;
import gameengine.exception.IllegalStateException;
import gameengine.exception.RuntimeException;
import haxe.Timer;
import view.FrameViewDataset;
import view.GlobalViewDataset;
import xa3.MTRandom;

using Lambda;
using xa3.ArrayUtils;

class GameManager {
	
	static final VIEW_DATA_TOTAL_SOFT_QUOTA = 512 * 1024;
	static final VIEW_DATA_TOTAL_HARD_QUOTA = 1024 * 1024;
	static final GAME_SUMMARY_TOTAL_HARD_QUOTA = 512 * 1024;
	static final GAME_SUMMARY_PER_TURN_HARD_QUOTA = 800;
	static final GAME_DURATION_HARD_QUOTA = 30000;
	static final GAME_DURATION_SOFT_QUOTA = 25000;
	static final MAX_TURN_TIME = GAME_DURATION_SOFT_QUOTA;
	static final MIN_TURN_TIME = 50;

	public final players:Array<Player>;
	final ais:Map<AbstractPlayer, IAi>;
	public final random:MTRandom;
	
	public var maxTurns = 200;
	public var turnMaxTime = 50;
	var firstTurnMaxTime = 1000;
	var turn = 0;
	var frame = 0;
	public var isGameEnd = false;
	var referee:Referee;
	var isNewTurn:Bool;
	
	var currentTooltips:Array<Tooltip> = [];
	var prevTooltips:Array<Tooltip> = [];

	var currentGameSummary:Array<String> = [];
	var prevGameSummary:Array<String> = [];

	var currentViewDataset = FrameViewDataset.NO_FRAME_VIEW_DATASET;
	var prevViewDataset = FrameViewDataset.NO_FRAME_VIEW_DATASET;
	
	final globalViewDatasets:Array<GlobalViewDataset> = [];

	final registeredModules:Array<Module> = [];

	public var frameDuration = 1000;

	final metadata:Map<String, String> = [];

	var initDone = false;
	public var outputsRead(default, null) = false;
	var totalViewDataBytesSent = 0;
	var totalGameSummaryBytes = 0;
	var totalTurnTime = 0;

	var viewWarning:Bool;
	var summaryWarning:Bool;

	var timer = new Timer( 1 );
	
	public function new( players:Array<Player>, ais:Map<AbstractPlayer, IAi>, random:MTRandom ) {
		this.players = players;
		this.ais = ais;
		this.random = random;
	}
	
	public function start( referee:Referee, withTimer = false ) {
		for( player in players ) {
			player.setGameManager( this );
			player.init();
		}
		this.referee = referee;
		
		// try {
			// Init ---------------------------------------------------------------
			referee.init();
			registeredModules.iter( module -> module.onGameInit() );
			currentTooltips.clear();
			currentGameSummary.clear();
			isGameEnd = false;
	
			outputsRead = false;
			totalViewDataBytesSent = 0;
			totalGameSummaryBytes = 0;
			totalTurnTime = 0;
	
			initDone = true;
			
			turn = 1;
			if( withTimer ) {
				loopWithTimer();
				return [];
			} else {
				// Game Loop ----------------------------------------------------------
				// while( turn < 2 && !isGameEnd ) {
				while( turn <= maxTurns && !isGameEnd && getActivePlayers().length != 0 ) {
					processTurn();
				}
				end();
				return players.map( player -> player.score );
			}
		// } catch( e ) {
		// 	throw e;
		// }
	}

	function loopWithTimer() {
		timer.stop();
		if( turn <= maxTurns && !isGameEnd && getActivePlayers().length != 0 ) {
			processTurn();
			timer = new Timer( 5 );
			timer.run = loopWithTimer;
		} else {
			end();
		}
	}
	
	function processTurn() {
		// trace( 'turn $turn' );
		swapInfoAndViewData();
		isNewTurn = true;
		outputsRead = false;
		referee.gameTurn( turn );
		registeredModules.iter( module -> module.onAfterGameTurn());

		// Create a frame if no player has been executed
		if( players.length > 0 && players.filter( p -> p.hasBeenExecuted ).length == 0 ) execute( players[0] );
		
		// reset players' outputs
		for( player in players ) {
			player.resetOutputs();
			player.hasBeenExecuted = false;
		}
		turn++;
	}
	
	function end() {
		referee.onEnd();
		registeredModules.iter( module -> module.onAfterOnEnd());
		
		// Send last frame ----------------------------------------------------
		swapInfoAndViewData();
		isNewTurn = true;
	}

	/**
	 * Executes a player for a maximum of turnMaxTime milliseconds and store the output. Used by player.execute().
	 *
	 * @param player
	 *        Player to execute.
	 * @param nbrOutputLines
	 *        The amount of expected output lines from the player.
	 */
	public function execute( player:AbstractPlayer, nbrOutputLines = 0 ) {
		try {
			if( !initDone ) throw new RuntimeException( "Impossible to execute a player during init phase." );

			player.timeout = false;
			
			// final iCmd = InputCommand.parse( s.nextLine() );
			final ai = ais[player];
			ai.setInputs( player.getInputs() );
			final command = ai.process();
			// trace( 'player ${player.index} command $command' );
			if( command != "" ) nbrOutputLines = 1;
			
			dumpView();
			dumpInfos();
			dumpNextPlayerInput( player.getInputs());
			if( nbrOutputLines > 0 ) addTurnTime();

			dumpNextPlayerInfos( player.index, nbrOutputLines, player.hasNeverBeenExecuted ? firstTurnMaxTime : turnMaxTime );
			
			// READ PLAYER OUTPUTS
			player.outputs = [command];

			player.resetInputs();
			isNewTurn = false;
		} catch( e ) {
			throw e;
		}
	}

	/**
	 * Swap game summary and view.
	 *
	 * As these values are sent in the first call to gameManger.execute(player), this function allows to change the current view at the end of each
	 * gameTurn instead of the middle of the gameTurn.
	 */
	function swapInfoAndViewData() {
		prevViewDataset = currentViewDataset;
		currentViewDataset = FrameViewDataset.NO_FRAME_VIEW_DATASET;

		prevGameSummary = currentGameSummary;
		currentGameSummary.clear();

		prevTooltips = currentTooltips;
		currentTooltips.clear();
	}
	
	function dumpGameProperties() { }

	function dumpMetadata() { }

	function dumpScores() { }

	function dumpFail() { }

	function dumpView() { }

	function dumpInfos() { }

	function dumpNextPlayerInfos( nextPlayer:Int, expectedOutputLineCount:Int, timeout:Int ) { }

	function dumpNextPlayerInput( input:Array<String> ) { }

	function getMetadata() { return ""; }

    //
    // Public methods used by Referee:
    //

    /**
     * Puts a new metadata that will be included in the game's <code>GameResult</code>.
     *
     * Can be used for:
     *
     * Setting the value of an optimization criteria for OPTI games, used by the CodinGame IDE
     * Dumping game statistics for local analysis after a batch run of GameRunner.simulate()
     *
     * @param key
     *            the property to send
     * @param value
     *            the property's value
     */
	 function putMetadata( key:String, value:String ) metadata.set( key, value );

    /**
     * Specifies the frameDuration in milliseconds. Default: 1000ms
     *
     * @param frameDuration
     *            The frame duration in milliseconds.
     * @throws IllegalArgumentException
     *             if frameDuration &le; 0
     */
    public function setFrameDuration( frameDuration:Int ) {
        if( frameDuration <= 0 ) {
            throw new IllegalArgumentException("Invalid frame duration: only positive frame duration is supported");
        } else if( this.frameDuration != frameDuration ) {
            this.frameDuration = frameDuration;
            currentViewDataset.duration = frameDuration;
        }
    }


	public static function formatErrorMessage( message:String ) return message;

	/**
	 * Adds a tooltip for the current turn.
	 *
	 * @param player
	 *        The player the tooltip information is about.
	 * @param message
	 *        Tooltip message.
	 */
	public function addTooltip( player:Player, message:String ) {
		currentTooltips.push( new Tooltip( player.index, message ));
	}

	/**
	 * Set game end.
	 */
	public function endGame() {
		isGameEnd = true;
	}
	
	/**
	 * Add a new line to the game summary for the current turn.
	 *
	 * @param summary
	 * summary line to add to the current summary.
	 */
	public function addToGameSummary( summary:String ) {
		
		#if sys
		if( summary != "" ) Sys.println( '$summary' );
		#else
		if( summary != "" ) trace( summary );
		#end
		
		final total = currentGameSummary.length + summary.length;

		if( total < GAME_SUMMARY_PER_TURN_HARD_QUOTA && total + totalGameSummaryBytes < GAME_SUMMARY_TOTAL_HARD_QUOTA ) {
			currentGameSummary.push( summary );
			totalGameSummaryBytes += total;
		} else if( !summaryWarning ) {
			trace( "Warning: the game summary is full. Please try to send less data." );
			summaryWarning = true;
		}
	}

	function addTurnTime() {
        totalTurnTime += turnMaxTime;
        if( totalTurnTime > GAME_DURATION_HARD_QUOTA ) {
            throw new RuntimeException( 'Total game duration too long (>${GAME_DURATION_HARD_QUOTA}ms)' );
        } else if( totalTurnTime > GAME_DURATION_SOFT_QUOTA ) {
			final warning = 'Warning: too many turns and/or too much time allocated to players per turn (${totalTurnTime}ms/${GAME_DURATION_HARD_QUOTA}ms)';
			#if sys
			Sys.println( warning );
			#else
			trace( warning );
			#end
		}
    }

   /**
	 * Register a module to the gameManager. After this, the gameManager will call the module callbacks automatically.
	 *
	 * @param module the module to register
	 */
	public function registerModule( module:Module ) {
		registeredModules.push(module);
	}

	public function getLeagueLevel() {
		// return 1; // Wood 2
		// return 2; // Wood 1
		return 3; // Above Wood
	}

	public function getPlayerCount() return players.length;

	public function getActivePlayers() return players.filter( p -> p.isActive );

	/**
	 * Set data for use by the viewer, for the current frame.
	 */
	public function setViewData( dataset:FrameViewDataset ) {
		currentViewDataset = dataset;
		sendFrameViewData( turn, dataset );
	}

	/**
	 * Set data for use by the viewer and not related to a specific frame. This must be use in the init only.
	 */
	public function setViewGlobalData( dataset:GlobalViewDataset ) {
		if ( initDone ) throw new IllegalStateException( "Impossible to send global data to view outside of init phase" );
		globalViewDatasets.push( dataset );
		sendViewGlobalData( dataset );
	}
	
	public dynamic function sendFrameViewData( turn:Int, dataset:FrameViewDataset ) { }
	public dynamic function sendViewGlobalData( dataset:GlobalViewDataset ) { }
}