package game.exception;

class NotEnoughSunException extends GameException {
	
	public function new( cost:Int, sun:Int ) {
		super( 'Not enough sun. You need $cost but have $sun' );
	}
}