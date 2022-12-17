package game;

import Std.int;
import Std.parseInt;
import ai.CurrentAis;
import event.Animation;
import game.pathfinding.PathFinder;
import gameengine.core.GameManager;
import view.ViewModule;
import xa3.MTRandom;

class MainGame {
	
	static var seed:Int;
	static var app:viewer.App;

	static var gameManager:GameManager;
	
	static function main() {
		#if sys
		final args = Sys.args();
		seed = args[0] == null ? 0 : parseInt( args[0] );
		#else
		seed = 0;
		#end
		hxd.Res.initEmbed();

		final player0 = new Player( 0, CurrentAis.aiMe.aiId );
		final player1 = new Player( 1, CurrentAis.aiOpp.aiId );
		gameManager = new GameManager( [ player0, player1 ], new MTRandom( seed ));

		app = new viewer.App( gameManager, startGame );
	}

	static function startGame() {
		#if js
		final canvas = cast( js.Browser.document.getElementById( "webgl" ), js.html.CanvasElement );
		js.Browser.window.addEventListener( "resize", e -> {
			canvas.width = js.Browser.window.innerWidth;
			canvas.height = js.Browser.window.innerHeight;
			canvas.style.width = '${canvas.width}px';
			canvas.style.height = '${canvas.height}px';
		});
		#end

		final endScreenModule = new EndScreenModule();
		final commandManager = new CommandManager();
		final pathFinder = new PathFinder();
		final animation = new Animation();
		final gameSummaryManager = new GameSummaryManager();
		final viewModule = new ViewModule();
		final game = new Game( gameManager, endScreenModule, pathFinder, animation, gameSummaryManager, app.addFrameViewData );

		final referee = new Referee( gameManager, commandManager, game, viewModule );
		referee.init();
		
		// referee.run();
		app.updateFirstFrame();
		
		// referee.runWithTimer();
	}
}