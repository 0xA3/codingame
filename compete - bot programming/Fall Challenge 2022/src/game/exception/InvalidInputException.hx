package game.exception;

import haxe.Exception;

class GameException extends Exception {

	public final expected:String;
	public final got:String;

	public function new( expected:String, got:String ) {
		super( 'Invalid Input: Expected $expected but got $got' );
		this.expected = expected;
		this.got = got;
	}
}