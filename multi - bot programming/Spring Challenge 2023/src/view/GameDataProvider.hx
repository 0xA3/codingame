package view;

import game.Cell;
import game.Game;
import game.Player;
import gameengine.core.MultiplayerGameManager;

class GameDataProvider {
	
	final game:Game;
	final gameManager:MultiplayerGameManager;

	public function new( game:Game, gameManager:MultiplayerGameManager ) {
		this.game = game;
		this.gameManager = gameManager;
	}

	public function getGlobalData() {
		final data = new GlobalViewData();
		data.cells = game.getBoardCoords().map( entry -> {
			final coord = entry;
			final cell = game.getBoard().get( coord );

			final cellData = new CellData();
			cellData.q = coord.getX();
			cellData.r = coord.getZ();
			cellData.richness = cell.getRichness();
			cellData.index = cell.getIndex();
			final anthill = cell.getAnthill();
			cellData.owner = anthill == null ? -1 : anthill.getIndex();
			cellData.type = cell.getType() == EGG ? 1 : 2;
			cellData.ants = cell.getAnts();

			return cellData;
		});
		return data;
	}

	function collectCellDataBi( getter:( cell:Cell, player:Player ) -> Int ) {
		return gameManager.getPlayers().map( player -> {
			return collectCellData( cell -> getter( cell, cast player ));
		});
	}

	function collectCellData( getter:( cell:Cell ) -> Int ) {
		return game.getBoardCoords().map( coord -> {
			final cell = game.getBoard().get( coord );
			return getter( cell );
		});
	}

	public function getCurrentFrameData() {
		final data = new FrameViewData();

		data.messages = gameManager.getPlayers().map( player -> ( cast player ).getMessage());
		data.beacons = collectCellDataBi(( cell:Cell, player:Player ) -> cell.getBeaconPower( player ));
		data.scores = gameManager.getPlayers().map( player -> ( cast player ).getPoints());

		data.events = game.getViewerEvents();

		return data;
	}
}