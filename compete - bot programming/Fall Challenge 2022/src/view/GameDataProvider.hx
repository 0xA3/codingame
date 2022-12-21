package view;

import game.Game;
import gameengine.core.GameManager;

class GameDataProvider {
	
	final game:Game;
	final gameManager:GameManager;

	public function new( game:Game, gameManager:GameManager ) {
		this.game = game;
		this.gameManager = gameManager;
	}

	public function getGlobalDataset() {
		final units = [for( player in gameManager.players )
			[for( coord => unit in player.units ) new UnitDto( coord, unit.getStrength() )]
		];

		final cells = [for( coord => cell in game.grid.cells ) new CellDto( coord, cell )];

		final dataset = new GlobalViewDataset(
			game.grid.width,
			game.grid.height,
			units,
			cells );
		
		return dataset;
	}

	public function getCurrentFrameDataset() {
		final cellDatasets = game.getCurrentCellDatasets();
		var players = [];
		for( i in 0...gameManager.players.length ) {
			players[i] = new PlayerDto( gameManager.players[i], cellDatasets.playerCellsSums[i]);
		}
		final dataset = new FrameViewDataset( players, game.viewerEvents, cellDatasets.cellDatasets );

		return dataset;
	}
}