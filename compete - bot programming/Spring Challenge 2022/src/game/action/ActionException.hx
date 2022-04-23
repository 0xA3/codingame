package game.action;

import haxe.Exception;

class ActionException extends Exception {
	public function new( message:String ) {
		super( message );
	}
}