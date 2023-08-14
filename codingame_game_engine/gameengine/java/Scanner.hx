package gameengine.java;

import Std.parseInt;

class Scanner {
	
	final stream:haxe.ds.List<String>;

	public function new( stream:haxe.ds.List<String> ) {
		this.stream = stream;
	}

	public function close() {
		stream.clear();
	}

	public function nextLine() {
		trace( 'inputStream $stream' );
		if( stream.isEmpty()) {
			throw "Error: stream is empty";
		}
		trace( 'nextLine "${stream.first()}"' );
		return stream.pop();
	}

	public function nextInt() {
		// trace( 'inputStream $stream' );
		if( stream.isEmpty()) {
			throw "Error: stream is empty";
		}
		// trace( 'nextInt ${stream.first()}' );
		return parseInt( stream.pop() );
	}

	public function toString() return stream.toString();
}