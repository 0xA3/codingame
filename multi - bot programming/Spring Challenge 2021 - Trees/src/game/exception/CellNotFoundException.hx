package game.exception;

class CellNotFoundException extends GameException {
	
	public function new( id:Int ) {
		super( "Cell " + id + " not found" );
	}
}