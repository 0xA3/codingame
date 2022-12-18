package view;

import gameengine.core.GameManager;
import gameengine.core.Module;

class ViewModule implements Module {
	
	final gameManager:GameManager;
	final gameDataProvider:GameDataProvider;

	public function new( gameManager:GameManager, gameDataProvider:GameDataProvider ) {
		this.gameManager = gameManager;
		this.gameDataProvider = gameDataProvider;

		gameManager.registerModule( this );
	}

	public function onGameInit() {
		sendGlobalData();
		sendFrameData();
	}

	public function sendGlobalData() gameManager.setViewGlobalData( gameDataProvider.getGlobalDataset() );
	public function sendFrameData() gameManager.setViewData( gameDataProvider.getCurrentFrameDataset() );
	public function onAfterGameTurn() sendFrameData();
	public function onAfterOnEnd() { }
}