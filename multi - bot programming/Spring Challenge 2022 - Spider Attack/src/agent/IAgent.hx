package agent;

interface IAgent {
	function init( inputLines:Array<String> ):Void;
	function setInputs( inputLines:Array<String> ):Void;
	function process():String;
}