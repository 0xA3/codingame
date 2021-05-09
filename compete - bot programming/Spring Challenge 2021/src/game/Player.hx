package game;

import Math.max;
import Std.int;
import game.action.Action;
import gameengine.core.AbstractMultiplayerPlayer;

class Player extends AbstractMultiplayerPlayer {
	
	public var message:Null<String>;
	public var action:Action;
	public var sun:Int;
	public var isWaiting = false;
	public var bonusScore = 0;

	public function new( index:Int ) {
		this.index = index;
		sun = Config.STARTING_SUN;
		action = Action.NO_ACTION;
	}

	public function getExpectedOutputLines() return 1;
	public function addScore( score:Int ) this.score += score;
	
	public function reset() {
		message = null;
		action = Action.NO_ACTION;
	}

	public function addSun( sun:Int ) this.sun += sun;
	public function removeSun( amount:Int ) this.sun = int( max( 0, sun - amount ));
	public function getVonusScore() return bonusScore > 0 ? '${score - bonusScore} points and $bonusScore trees' : "";

}