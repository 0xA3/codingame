package game.exception;

class InvalidInputException extends haxe.Exception {

	final expected:String;
	final got:String;

	public function new( expected:String, got:String ) {
		super( 'Invalid Input: Expected $expected but got "$got"' );
		this.expected = expected;
		this.got = got;
	}

	public function getExpected() return expected;
	function getGot() return got;
}