package game.exception;

class TreeNotFoundException extends GameException {
	
	public function new( id:Int ) {
		super( "There is no tree on cell " + id );
	}
}