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

	function sendFrameData() {
		final data = gameDataProvider.getCurrentFrameData();
		gameManager.setViewData( "graphics", data );
	}

	function sendGlobalData() {
		final data = gameDataProvider.getGlobalData();
		gameManager.setViewGlobalData( "graphics", data );
	}

	public function onAfterGameTurn() {
		sendFrameData();
	}

	public function onAfterOnEnd() {}
}