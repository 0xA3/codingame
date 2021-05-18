package game.exception;

class TreeTooFarException extends GameException {
	
	public function new( from:Int, to:Int ) {
		super( 'The tree on cell $from is too far from cell $to to plant a seed there' );
	}
}