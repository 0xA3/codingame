package gameengine.core;

abstract class AbstractPlayer {
	
	public var index:Int;
	public var score:Int;

	var outputs:Array<String>;

	public function getOutputs() {
		return outputs;
	}
	
	public function setOutputs( outputs:Array<String> ) {
		this.outputs = outputs;
	}

	public function resetOutputs() outputs = null;

}