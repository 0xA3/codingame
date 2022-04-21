package game.exception;

import haxe.Exception;

class GameException extends Exception {
	
	public function new( string:String ) {
		super( string );
	}
}