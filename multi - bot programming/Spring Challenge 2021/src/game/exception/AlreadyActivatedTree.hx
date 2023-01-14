package game.exception;

class AlreadyActivatedTree extends GameException {
	
	public function new( id:Int ) {
		super( "Tree on cell " + id + " is dormant (has already been used this round)" );
	}
}