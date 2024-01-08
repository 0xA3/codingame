package gameengine.exception;

import haxe.Exception;

class IllegalStateException extends Exception {
	public function new( message:String ) {
		super( message );
	}
}