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

	public static function formatErrorMessage( message:String ) return message;

	/**
	 * Adds a tooltip for the current turn.
	 *
	 * @param player
	 *            The player the tooltip information is about.
	 * @param message
	 *            Tooltip message.
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
	 *            summary line to add to the current summary.
	 */
	 public function addToGameSummary( summary:String ) {
		final total = currentGameSummary.length + summary.length;

		if( total < GAME_SUMMARY_PER_TURN_HARD_QUOTA && total + totalGameSummaryBytes < GAME_SUMMARY_TOTAL_HARD_QUOTA ) {
			this.currentGameSummary.push( summary );
			totalGameSummaryBytes += total;
		} else if( !summaryWarning ) {
			trace("Warning: the game summary is full. Please try to send less data.");
			summaryWarning = true;
		}
	}
	
}