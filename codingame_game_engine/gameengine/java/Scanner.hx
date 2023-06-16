package gameengine.java;

import Std.parseInt;

class Scanner {
	
	var currentLine = 0;
	final lines:Array<String>;

	public function new( stream:String ) {
		lines = stream.split( "\n" );
	}

	public function close() {
		
	}

	public function nextLine() {
		return lines[currentLine];
		currentLine++;
	}

	public function nextInt() {
		return parseInt( lines[currentLine] );
	}
}