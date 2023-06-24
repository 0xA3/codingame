package gameengine.java;

import Std.parseInt;

class Scanner {
	
	var currentLine = 0;
	final stream:haxe.ds.List<String>;

	public function new( stream:haxe.ds.List<String> ) {
		this.stream = stream;
	}

	public function close() {
		stream.clear();
	}

	public function nextLine() {
		if( stream.isEmpty()) {
			throw "Error: stream is empty";
		}
		return stream.pop();
	}

	public function nextInt() {
		if( stream.isEmpty()) {
			throw "Error: stream is empty";
		}
		return parseInt( stream.pop() );
	}
}