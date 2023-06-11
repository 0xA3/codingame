package gameengine.core;

import game.Player;

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
    public var maxTurns = 200;
    var turnMaxTime = 50;
    var firstTurnMaxTime = 1000;
    var turn:Null<Int> = null;
    var frame = 0;
    public var gameEnd = false;
    
    var newTurn:Bool;
	
	final currentTooltips:Array<Tooltip> = [];
	final currentGameSummary:Array<String> = [];

	public var frameDuration = 1000;

	var initDone = false;
	var outputsRead = false;
	var totalViewDataBytesSent = 0;
	var totalGameSummaryBytes = 0;
	var totalTurnTime = 0;

	var viewWarning:Bool;
	var summaryWarning:Bool;
	
	public function new( players:Array<Player> ) {
		this.players = players;
	}

	public function init() {
		currentTooltips.splice( 0, currentTooltips.length );
		currentGameSummary.splice( 0, currentGameSummary.length );
		gameEnd = false;

		initDone = false;
		outputsRead = false;
		totalViewDataBytesSent = 0;
		totalGameSummaryBytes = 0;
		totalTurnTime = 0;
		for( player in players ) player.init();
	}

	public static function formatErrorMessage( message:String ) return message;

	/**
	 * Adds a tooltip for the current turn.
	 *
	 * @param player
	 * The player the tooltip information is about.
	 * @param message
	 * Tooltip message.
	 */
	 public function addTooltip( player:Player, message:String ) {
		currentTooltips.push( new Tooltip( player.index, message ));
	}

	/**
	 * Set game end.
	 */
	public function endGame() {
		gameEnd = true;
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

	public function getLeagueLevel() {
		// return 1; // Wood 2
		// return 2; // Wood 1
		return 3; // Above Wood
	}

	public function getPlayerCount() return players.length;

	public function getActivePlayers() return players.filter( p -> p.isActive );

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
            throw "Invalid frame duration: only positive frame duration is supported";
        } else if( this.frameDuration != frameDuration ) {
            this.frameDuration = frameDuration;
            // currentViewData.addProperty("duration", frameDuration);
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
     * Set the maximum amount of turns. Default: 400.
     *
     * @param maxTurns
     *            the number of turns for a game.
     * @throws IllegalArgumentException
     *             if maxTurns &le; 0
     */
	public function setMaxTurns( maxTurns :Int )  {
        if (maxTurns <= 0) {
            throw "Invalid maximum number of turns";
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
            throw "Invalid turn max time : stay above 50ms";
        } else if( turnMaxTime > MAX_TURN_TIME ) {
            throw "Invalid turn max time : stay under 25s";
        }
        this.turnMaxTime = turnMaxTime;
    }

}