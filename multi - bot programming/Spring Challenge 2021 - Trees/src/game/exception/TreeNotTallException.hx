package game.exception;

class TreeNotTallException extends GameException {
	
	public function new( id:Int ) {
		super( "The tree on cell " + id + " is not large enough" );
	}
}