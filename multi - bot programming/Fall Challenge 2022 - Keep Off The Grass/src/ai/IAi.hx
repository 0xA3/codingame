package ai;

interface IAi {
	var width(default, null):Int;
	var height(default, null):Int;
	
	function setInputs( inputLines:Array<String> ):Void;
	function process():String;
}