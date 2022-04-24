package gameengine.core;

abstract class AbstractPlayer {
	
	public var index:Int;
	public var score:Int;

	var inputs:Array<String> = [];
	var outputs:Array<String> = [];
	var timeout:Bool;
	var hasBeenExecuted:Bool;
	var hasNeverBeenExecuted = true;

	/**
	 * Adds a new line to the input to send to the player on execute.
	 *
	 * @param line
	 * The input to send.
	 */
	 public function sendInputLine( line:String ) {
		if( hasBeenExecuted ) {
			throw "Impossible to send new inputs after calling execute";
		}
		// if (this.gameManagerProvider.get().getOuputsRead()) {
		//     throw new RuntimeException("Sending input data to a player after reading any output is forbidden.");
		// }
		inputs.push(line);
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
		return inputs;
	}

	public function getOutputs() {
		return outputs;
	}
	
	public function setOutputs( outputs:Array<String> ) {
		this.outputs = outputs;
	}

	public function resetOutputs() outputs = null;

}