package game;

import Std.int;
import gameengine.core.GameManager;

class MainGame {
	
	static var app:player.App;

	static final corners = [new Vector( 0, 0 ), new Vector( Configuration.MAP_WIDTH, Configuration.MAP_HEIGHT )];
	static var gameManager:GameManager;
	
	static function main() {
		hxd.Res.initEmbed();

		final player0 = new Player( 0, "Me", int( corners[0].x ), int( corners[0].y ));
		final player1 = new Player( 1, "Opponent", int( corners[1].x ), int( corners[1].y ));
		gameManager = new GameManager([ player0, player1 ]);

		app = new player.App( gameManager );
		
		app.initComplete.handle(() -> startSimulation());
	}

	static function startSimulation() {
		final referee = new game.Referee( gameManager, corners );
		referee.init( 0 );
		
		referee.frameDataset.handle( d -> app.addFrameViewData( d ));

		referee.runWithTimer();
	}
}