package game;

import Std.int;
import Std.parseInt;
import ai.CurrentAis;
import ai.IAi;
import event.Animation;
import game.pathfinding.PathFinder;
import gameengine.core.AbstractPlayer;
import gameengine.core.GameManager;
import view.GameDataProvider;
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
		// seed = 0;
		seed = Std.random( 10000 );
		#end
		hxd.Res.initEmbed();

		#if js
		final canvas = cast( js.Browser.document.getElementById( "webgl" ), js.html.CanvasElement );
		js.Browser.window.addEventListener( "resize", e -> {
			canvas.width = js.Browser.window.innerWidth;
			canvas.height = js.Browser.window.innerHeight;
			canvas.style.width = '${canvas.width}px';
			canvas.style.height = '${canvas.height}px';
		});
		#end

		final player0 = new Player( 0, CurrentAis.aiMe.aiId );
		final player1 = new Player( 1, CurrentAis.aiOpp.aiId );
		final ais:Map<AbstractPlayer, IAi> = [player0 => CurrentAis.aiMe, player1 => CurrentAis.aiOpp];
		
		gameManager = new GameManager( [player0, player1], ais, new MTRandom( seed ));

		app = new viewer.App( gameManager, startGame );
	}

	static function startGame() {
		final endScreenModule = new EndScreenModule();
		final commandManager = new CommandManager();
		final pathFinder = new PathFinder();
		final animation = new Animation();
		final gameSummaryManager = new GameSummaryManager();
		final game = new Game( gameManager, endScreenModule, pathFinder, animation, gameSummaryManager );

		final gameDataProvider = new GameDataProvider( game, gameManager );
		final viewModule = new ViewModule( gameManager, gameDataProvider );
		final referee = new Referee( gameManager, commandManager, game, viewModule );
		
		gameManager.sendViewGlobalData = app.receiveViewGlobalData;
		gameManager.sendFrameViewData = app.receiveFrameViewData;

		gameManager.start( referee, true );
	}
}