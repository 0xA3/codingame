package gameengine.core;

abstract class AbstractMultiplayerPlayer extends AbstractPlayer {
	
	public var isActive = true;

	public function deactivate( reason:String ) {
		isActive = false;
		trace( 'Deactivate Player ${index}: $reason' );
	}
}