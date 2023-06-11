package game;

import gameengine.core.AbstractReferee;

@:structInit class Referee extends AbstractReferee {

	final gameManager:GameManager;
	final commandManager:CommandManager;
	final game:Game;
	final viewModule:ViewModule;

	public function init() {
	}
}