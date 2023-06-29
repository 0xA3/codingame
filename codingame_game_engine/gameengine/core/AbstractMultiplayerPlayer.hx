package gameengine.core;

abstract class AbstractMultiplayerPlayer extends AbstractPlayer {
	
	public var active = true;

   /**
	 * Returns an integer that will be converted into the player's real color by the viewer.
	 *
	 * @return the player's color token.
	 */
	 public function getColorToken() {
		return -( index + 1 );
	}

	/**
	 * Returns true is the player is still active in the game (can be executed).
	 *
	 * @return true is the player is active.
	 */
	override public function isActive() {
		return active;
	}

	/**
	 * Get player index from 0 (included) to number of players (excluded).
	 *
	 * @return the player index.
	 */
	override public function getIndex() {
		return super.getIndex();
	}

	/**
	 * Get current score.
	 *
	 * @return current player score
	 */
	 override public function getScore() {
		return super.getScore();
	}

	/**
	 * Set current score. This is used to rank the players at the end of the game.
	 *
	 * @param score current player score
	 */
	 override public function setScore( score:Int ) {
		super.setScore(score);
	}

	/**
	 * Deactivate a player. The player can't play after this and is no longer in the list of active players.
	 */
	/**
	 * Deactivate a player and adds a tooltip with the reason. The player can't play after this and is no longer in the list of active players.
	 *
	 * @param reason
	 *            Message to display in the tooltip.
	 */
	public function deactivate( ?reason:String ) {
		this.active = false;
		trace( 'deactivate player $index because of $reason' );
		if( reason != null ) {
			gameManager.addTooltip( new Tooltip( index, reason ));
		}
	}
}