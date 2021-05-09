package game.exception;

class CellNotEmptyException extends GameException {
	
	public function new( id:Int ) {
		super( "There is already a tree on cell " + id );
	}
}