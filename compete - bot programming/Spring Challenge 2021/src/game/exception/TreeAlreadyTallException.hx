package game.exception;

class TreeAlreadyTallException  extends GameException {
	
	public function new( id:Int ) {
		super( "Tree on cell " + id + " cannot grow more (max size is 3)." );
	}
}