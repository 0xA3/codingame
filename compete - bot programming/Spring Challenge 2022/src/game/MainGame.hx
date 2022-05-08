package game;

import Std.int;
import Std.parseInt;
import agent.CurrentAgents;
import gameengine.core.GameManager;

class MainGame {
	
	static var seed:Int;
	static var app:player.App;

	static final corners = [new Vector( 0, 0 ), new Vector( Config.MAP_WIDTH, Config.MAP_HEIGHT )];
	static var gameManager:GameManager;
	
	static function main() {
		final args = Sys.args();
		seed = args[0] == null ? 0 : parseInt( args[0] );
		
		hxd.Res.initEmbed();

		final player0 = new Player( 0, "Me", int( corners[0].x ), int( corners[0].y ));
		final player1 = new Player( 1, "Opponent", int( corners[1].x ), int( corners[1].y ));
		gameManager = new GameManager([ player0, player1 ]);

		app = new player.App( gameManager, startSimulation );
	}

	static function startSimulation() {
		final referee = new game.Referee( gameManager, corners, CurrentAgents.agentMe, CurrentAgents.agentOpp );
		referee.init( seed );
		
		referee.frameDataset.handle( d -> app.addFrameViewData( d ));
		referee.run();
		app.updateFirstFrame();
		
		// referee.runWithTimer();
	}
}