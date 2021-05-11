package agent;

class WaitAgent extends Agent {

	override function process(day:Int, nutrients:Int, myInputs:Array<String>, oppInputs:Array<String>, treesInputs:Array<Array<String>>, possibleActions:Array<String>):String {
		return 'WAIT';
	}
}