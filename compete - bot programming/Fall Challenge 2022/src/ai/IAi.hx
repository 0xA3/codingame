package ai;

interface IAi {
	var width:Int;
	var height:Int;
	
	function setInputs( inputLines:Array<String> ):Void;
	function process():String;
}