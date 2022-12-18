package gameengine.core;

import gameengine.exception.RuntimeException;

using xa3.ArrayUtils;

abstract class AbstractPlayer {
	
	var gameManager:GameManager;

	public var index:Int;
	public var score:Int;

	public final inputs:Array<String> = [];
	public var outputs(default, set):Array<String> = [];
	public var timeout:Bool;
	public var hasBeenExecuted:Bool;
	public var hasNeverBeenExecuted = true;

	public function setGameManager( gameManager:GameManager ) {
		this.gameManager = gameManager;
	}

	public function init() {
		resetInputs();
		resetOutputs();
	}

	/**
	 * Adds a new line to the input to send to the player on execute.
	 *
	 * @param line
	 * The input to send.
	 */
	 public function sendInputLine( line:String ) {
		if( hasBeenExecuted ) throw "Impossible to send new inputs after calling execute";
		
		if( gameManager.outputsRead ) {
		    throw new RuntimeException( "Sending input data to a player after reading any output is forbidden." );
		}
		inputs.push( line );
		// if( index == 0 ) trace( '$index sendInputLine $line\n$inputs' );
	}
	
	/**
	 * Executes the player for a maximum of turnMaxTime milliseconds and store the output.
	 */
	public function execute() {
		gameManager.execute( this );
		this.hasBeenExecuted = true;
		this.hasNeverBeenExecuted = false;
	}

	public function getInputs() {
		// if( index == 0 ) trace( 'getInputs and clear' );
		final copy = inputs.copy();
		inputs.clear();
		return copy;
	}

	function set_outputs( o:Array<String> ) {
		outputs.clear();
		for( i in 0...o.length ) outputs[i] = o[i];
		return this.outputs;
	}

	public function resetInputs() inputs.clear();
	public function resetOutputs() outputs.clear();

}