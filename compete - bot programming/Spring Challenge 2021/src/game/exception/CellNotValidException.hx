package game.exception;

class CellNotValidException extends GameException {
	
	public function new( id:Int ) {
		super( "You can't plant a seed on cell " + id );
	}
}