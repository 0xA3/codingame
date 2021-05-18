package game.exception;

class TreeIsSeedException  extends GameException {
	
	public function new( id:Int ) {
		super( "The seed on " + id + " cannot produce seeds" );
	}
}