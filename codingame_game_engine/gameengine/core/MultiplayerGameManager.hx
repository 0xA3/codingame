package gameengine.core;

import xa3.MTRandom;
import gameengine.java.Scanner;
import tink.core.Signal;

using Lambda;

class MultiplayerGameManager extends GameManager {
	
	static final RANDOM_SECURE_SHA1PRNG_ALGORITHM = "SHA1PRNG";

	var gameParameters:Dynamic;
	var seed:Float;
	var random:MTRandom;

	public function new( nextPlayerInfoTrigger:SignalTrigger<String>, nextPlayerInputTrigger:SignalTrigger<String> ) {
		super( nextPlayerInfoTrigger, nextPlayerInputTrigger );
	}

	override public function readGameProperties( iCmd:InputCommand, s:Scanner ) {
		// create game properties
		final seed = s.nextInt();
		random = new MTRandom( seed );
	}

	override  function dumpGameProperties() {} // not implemented

	/**
	 * Get initial number of players.
	 *
	 * @return the number of players.
	 */
	 public function getPlayerCount() {
		return players.length;
	}

	/**
	 * <p>
	 * The seed is used to initialize the Random number generator.<br>
	 * If a seed is present in the given input, the input value should override the generated values.<br>
	 *
	 * The seed should NOT be used directly in referee but through the random number generator provided by @method getRandom
	 * </p>
	 *
	 * @return an <code>long</code> containing a given or generated seed.
	 */
	 public function getSeed() {
		return seed;
	}
	
	/**
	 * <p>
	 * The random generator is used to generated parameters such as width and height.<br>
	 * The provided random generator is a SecureRandom using the SHAPRNG algorithm.<br>
	 * </p>
	 *
	 * @return an <code>Random</code> containing a given or generated seed.
	 */
	public function getRandom() {
		return random;
	}

	/**
	 * <p>
	 * The game parameters are used to get additional information from the Game Runner.
	 * <p>
	 * When running the game in the CodinGame IDE, this instance will be populated with data entered by the user in the Options section.
	 * </p>
	 * <p>
	 * When the game is over, any modification made to this instance will be written back to the Options section, including the <code>seed</code> property.
	 * </p>
	 *
	 * @return a <code>Properties</code> containing the given parameters.
	 */
	public function getGameParameters() {
		return gameParameters;
	}

	/**
	 * Get all the players.
	 *
	 * @return the list of players.
	 */
	public function getPlayers() {
		return players;
	}

	/**
	 * Get all the active players.
	 *
	 * @return the list of active players.
	 */
	 public function getActivePlayers() {
		// TODO: could be optimized with a list of active players updated on player.deactivate().
		return players.filter( p -> p.isActive() );
	}

	/**
	 * Get player with index i
	 *
	 * @param i
	 *            Player index
	 * @return player with index i
	 * @throws IndexOutOfBoundsException
	 *             if there is no player at that index
	 */
	public function getPlayer( i:Int ) {
		if( i < 0 || i >= players.length ) throw "IndexOutOfBoundsException";
		return players[i];
	}

	/**
	 * Set game end.
	 */
	override public function endGame() {
		super.endGame();
	}

	override function allPlayersInactive() {
		return getActivePlayers().length == 0;
	}

	override function getGameSummaryOutputCommand() {
		return OutputCommand.SUMMARY;
	}
}