package game;

import game.data.FrameDataset;

class MainGame {
	
	static final halfPI = Math.PI / 2;
	
	static final startPositions:FrameDataset = {
		players: [
			{
				health: 3,
				mana: 0,
				heros: [
					{ id: 0, x: 1131, y: 1131, rotation: -halfPI },
					{ id: 1, x: 1414, y: 849, rotation: -halfPI },
					{ id: 2, x: 849, y: 1414, rotation: -halfPI }
				]
			},
			{
				health: 3,
				mana: 0,
				heros: [
					{ id: 3, x: 16499, y: 7869, rotation: halfPI },
					{ id: 4, x: 16216, y: 8151, rotation: halfPI },
					{ id: 5, x: 16781, y: 7586, rotation: halfPI }
				]
			}
		],
		monsters: []
	}

	static var app:game.App;
	static var referee:game.Referee;

	static function main() {
		hxd.Res.initEmbed();
		app = new game.App( startPositions );
		game.Referee.main();
	}

}