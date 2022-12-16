package game;

import Std.int;
import Std.parseInt;
import ai.CurrentAis;
import event.Animation;
import game.pathfinding.PathFinder;
import gameengine.core.GameManager;
import view.ViewModule;
import viewer.AssetConstants;
import xa3.MTRandom;

class MainGame {
	
	static var seed:Int;
	static var app:viewer.App;

	static var gameManager:GameManager;
	
	static function main() {
		final args = Sys.args();
		seed = args[0] == null ? 0 : parseInt( args[0] );
		
		hxd.Res.initEmbed();
		AssetConstants.init();

		final player0 = new Player( 0, CurrentAis.aiMe.aiId );
		final player1 = new Player( 1, CurrentAis.aiOpp.aiId );
		gameManager = new GameManager( [ player0, player1 ], new MTRandom( 0 ));

		app = new viewer.App( gameManager, startGame );
	}

	static function startGame() {
		final endScreenModule = new EndScreenModule();
		final commandManager = new CommandManager();
		final pathFinder = new PathFinder();
		final animation = new Animation();
		final gameSummaryManager = new GameSummaryManager();
		final viewModule = new ViewModule();
		final game = new Game( gameManager, endScreenModule, pathFinder, animation, gameSummaryManager );

		final referee = new Referee( gameManager, commandManager, game, viewModule );
		referee.init();
		
		referee.run();
		app.updateFirstFrame();
		
		// referee.runWithTimer();
	}
}