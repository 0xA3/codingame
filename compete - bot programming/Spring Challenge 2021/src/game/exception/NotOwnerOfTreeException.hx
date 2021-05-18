package game.exception;

class NotOwnerOfTreeException extends GameException {
	
	public function new( id:Int, player:Player ) {
		super( "The tree on cell " + id + " is owned by opponent" );
	}
}