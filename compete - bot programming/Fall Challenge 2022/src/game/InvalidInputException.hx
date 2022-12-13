package game;

import haxe.Exception;

class InvalidInputException extends Exception {
	
	public final playerId:String;
	public final expected:String;
	public final got:String;

	public function new( playerId:String, expected:String, got:String ) {
        super( "Invalid Input: Expected " + expected + " but got '" + got + "'" );
        this.playerId = playerId;
		this.expected = expected;
        this.got = got;
	}
}