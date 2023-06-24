package view;

import gameengine.core.GameManager;

class ViewModule {
	
	final gameManager:GameManager;
	final gameDataProvider:GameDataProvider;

	public function new( gameManager:GameManager, gameDataProvider:GameDataProvider ) {
		this.gameManager = gameManager;
		this.gameDataProvider = gameDataProvider;
	}
}