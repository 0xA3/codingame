package gameengine.core;

abstract class AbstractPlayer {
	
	public var index:Int;
	public var score:Int;

	var inputs:Array<String> = [];
	var outputs:Array<String> = [];
	var timeout:Bool;
	var hasBeenExecuted:Bool;
	var hasNeverBeenExecuted = true;

	public function init() {
		inputs = [];
		outputs = [];
	}

	/**
	 * Adds a new line to the input to send to the player on execute.
	 *
	 * @param line
	 * The input to send.
	 */
	 public function sendInputLine( line:String ) {
		if( hasBeenExecuted ) throw "Impossible to send new inputs after calling execute";
		
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
		this.hasBeenExecuted = true;
		this.hasNeverBeenExecuted = false;
	}

	public function getInputs() {
		final copy = inputs.copy();
		inputs.splice( 0, inputs.length );
		return copy;
	}

	public function getOutputs() return outputs;
	
	public function setOutputs( outputs:Array<String> ) this.outputs = outputs;

	public function resetInputs() inputs = [];
	public function resetOutputs() outputs = [];

}