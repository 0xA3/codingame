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
		final players = gameManager.players.map( player -> new PlayerDto( player ));
		final dataset = new FrameViewDataset( players, game.viewerEvents );

		return dataset;
	}
}