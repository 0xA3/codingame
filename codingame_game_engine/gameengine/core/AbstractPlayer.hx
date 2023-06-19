package gameengine.core;

import gameengine.exception.RuntimeException;

/**
 * An Exception thrown by <code>getOutputs()</code> when the player's AI did not respond in time after an <code>execute()</code>.
 * <p>
 * You can change the timeout value with <code>GameManager</code>'s <code>setTurnMaxTime</code> method.
 * </p>
 *
 */
class TimeoutException extends haxe.Exception {
	public function new () {
		super( "" );
	}
}

/**
 * The representation of the/a player's AI during the game's execution.
 *
 */
abstract class AbstractPlayer {
	
	var gameManager:GameManager;

	var index:Int;
	var inputs:Array<String> = [];
	var outputs:Array<String> = [];
	var timeout:Bool;
	var score:Int;
	var _hasBeenExecuted:Bool;
	var _hasNeverBeenExecuted = true;

	public function setGameManager( gameManager:GameManager ) {
		this.gameManager = gameManager;
	}

    /**
     * Returns a string that will be converted into the real nickname by the viewer.
     *
     * @return the player's nickname token.
     */
	 public function getNicknameToken() {
        return "$" + this.index;
    }

    /**
     * Returns a string that will be converted into the real avatar by the viewer, if it exists.
     *
     * @return the player's avatar token.
     */
    public function getAvatarToken() {
        return "$" + this.index;
    }

    /**
     * Get player index from 0 (included) to number of players (excluded).
     *
     * @return the player index.
     */
	public function getIndex() {
        return this.index;
    }

    /**
     * Get current score.
     *
     * @return current player score
     */
	public function getScore() {
        return this.score;
    }

    /**
     * Set current score. This is used to rank the players at the end of the game.
     *
     * @param score
     *            The player's final score.
     */
	function setScore( score:Int ) {
        this.score = score;
    }

	/**
	 * Adds a new line to the input to send to the player on execute.
	 *
	 * @param line
	 * The input to send.
	 */
	 public function sendInputLine( line:String ) {
		if( _hasBeenExecuted ) {
			throw new RuntimeException( "Impossible to send new inputs after calling execute" );
		}
		
		// if (this.gameManagerProvider.get().getOutputsRead()) {
		//     throw new RuntimeException("Sending input data to a player after reading any output is forbidden.");
		// }
		// trace( '$index sendInputLine $line' );
		inputs.push( line );
	}
	
	/**
	 * Executes the player for a maximum of turnMaxTime milliseconds and store the output.
	 */
	public function execute() {
		//gameManagerProvider.get().execute(this);
		_hasBeenExecuted = true;
		_hasNeverBeenExecuted = false;
	}

	/**
     * Gets the output obtained after an execution.
     *
     * @return a list of output lines
     * @throws TimeoutException
     *             if the player's AI crashes or stops responding
     */
 	public function getOutputs() {
		// gameManagerProvider.get().setOutputsRead( true );
        if( !_hasBeenExecuted ) {
            throw new RuntimeException( "Can't get outputs without executing it! ");
        }
        if( this.timeout ) {
            throw new TimeoutException();
        }
		return outputs;
	}
	
    /**
     * Returns the number of lines that the player must return.
     *
     * If the player do not write that amount of lines before the timeout delay, no outputs at all will be available for this player. The game engine
     * will not read more than the expected output lines. Extra lines will be available for next turn.
     *
     * @return the expected amount of lines the player must output
     */
	public function getExpectedOutputLines() {
		throw 'Error: getExpectedOutputLines() in AbstractPlayer must be overriden in Player class';
		return 0;
	}

	 //
	 // The following methods are only used by the GameManager:
	 //
	public function setIndex( index:Int ) {
        this.index = index;
    }

	public function getInputs() {
		final copy = inputs.copy();
		inputs.splice( 0, inputs.length );
		return copy;
	}

    function resetInputs() {
        this.inputs = [];
    }

    public function resetOutputs() {
        this.outputs = null;
    }

    public function setOutputs( outputs:Array<String> ) {
        this.outputs = outputs;
    }

    public function setTimeout( timeout:Bool ) {
        this.timeout = timeout;
    }

    function hasTimedOut() {
        return timeout;
    }

	public function hasBeenExecuted() {
        return _hasBeenExecuted;
    }

    public function setHasBeenExecuted( hasBeenExecuted:Bool ) {
        this._hasBeenExecuted = hasBeenExecuted;
    }

	public function hasNeverBeenExecuted() {
        return _hasNeverBeenExecuted;
    }

	public function isActive() return true;
}