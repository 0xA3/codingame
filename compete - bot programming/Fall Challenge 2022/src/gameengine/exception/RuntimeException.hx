package gameengine.exception;

import haxe.Exception;

class RuntimeException extends Exception {
	public function new( message:String ) {
		super( message );
	}
}