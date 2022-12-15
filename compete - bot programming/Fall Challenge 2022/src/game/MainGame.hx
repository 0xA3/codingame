package game;

import Std.int;
import Std.parseInt;
import ai.CurrentAgents;
import gameengine.core.GameManager;
import viewer.AssetConstants;

class MainGame {
	
	static var seed:Int;
	static var app:viewer.App;

	static final corners = [new Vector( 0, 0 ), new Vector( Config.MAP_WIDTH, Config.MAP_HEIGHT )];
	static var gameManager:GameManager;
	
	static function main() {
		final args = Sys.args();
		seed = args[0] == null ? 0 : parseInt( args[0] );
		
		hxd.Res.initEmbed();
		AssetConstants.init();

		final player0 = new Player( 0, CurrentAgents.agentMe.agentId, int( corners[0].x ), int( corners[0].y ));
		final player1 = new Player( 1, CurrentAgents.agentOpp.agentId, int( corners[1].x ), int( corners[1].y ));
		gameManager = new GameManager( [ player0, player1 ] );

		app = new viewer.App( gameManager, startGame );
	}

	static function startGame() {
		final referee = new game.Referee( gameManager, corners, CurrentAgents.agentMe, CurrentAgents.agentOpp );
		referee.sendFrameDataset = app.addFrameViewData;
		referee.init( seed );
		
		referee.run();
		app.updateFirstFrame();
		
		// referee.runWithTimer();
	}
}