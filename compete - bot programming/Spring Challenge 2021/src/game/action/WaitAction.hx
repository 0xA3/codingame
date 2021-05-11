package game.action;

class WaitAction extends Action {
	override public function isWait() return true;

	override function toString():String {
		return 'WAIT';
	}

}