package gameengine.exception;

import haxe.Exception;

class IllegalArgumentException extends Exception {
	public function new( message:String ) {
		super( message );
	}
}