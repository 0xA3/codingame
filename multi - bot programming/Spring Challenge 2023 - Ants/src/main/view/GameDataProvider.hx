package main.view;

import gameengine.core.MultiplayerGameManager;
import main.game.Cell;
import main.game.Game;
import main.game.Player;

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

			final anthill = cell.getAnthill();
			final cellData:CellData = {
				q: coord.getX(),
				r: coord.getZ(),
				richness: cell.getRichness(),
				index: cell.getIndex(),
				owner: anthill == null ? -1 : anthill.getIndex(),
				type: cell.getType() == EGG ? 1 : 2,
				ants: cell.getAnts()
			}

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
		final data:GraphicsDataset = {
			messages: gameManager.getPlayers().map( player -> ( cast player ).getMessage()),
			beacons: collectCellDataBi(( cell:Cell, player:Player ) -> cell.getBeaconPower( player )),
			scores: gameManager.getPlayers().map( player -> ( cast player ).getPoints()),
			events: game.getViewerEvents()
		}

		return data;
	}
}