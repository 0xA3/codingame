package game;

import Std.parseInt;
import ai.CurrentAis;
import ai.IAi;
import event.Animation;
import gameengine.core.MultiplayerGameManager;
import gameengine.module.endscreen.EndScreenModule;
import tink.core.Signal;
import view.GameDataProvider;
import view.ViewModule;

using Lambda;

class MainGame {
	
	static var seed:String;
	static var app:viewer.App;

	static var gameManager:MultiplayerGameManager;
	static var ais:Array<IAi>;
	static var players:Array<Player>;
	
	static var viewGlobalDataTrigger:SignalTrigger<String>;
	static var frameViewDataTrigger:SignalTrigger<String>;
	static var nextPlayerInfoTrigger:SignalTrigger<String>;
	static var nextPlayerInputTrigger:SignalTrigger<String>;

	static function main() {
		#if sys
		final args = Sys.args();
		seed = args[0] == null ? "0" : args[0];
		#else
		seed = "6";
		// seed = Std.random( 10000 );
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

		final aiMe = CurrentAis.aiMe;
		final aiOpp = CurrentAis.aiOpp;
		ais = [aiMe, aiOpp];

		final playerMe = new Player( 0, aiMe.aiId );
		final playerOpp = new Player( 1, aiOpp.aiId );
		players = [playerMe, playerOpp];
		
		viewGlobalDataTrigger = Signal.trigger();
		frameViewDataTrigger = Signal.trigger();
		nextPlayerInfoTrigger = Signal.trigger();
		nextPlayerInputTrigger = Signal.trigger();

		gameManager = new MultiplayerGameManager( nextPlayerInfoTrigger, nextPlayerInputTrigger );
		players.iter( p -> p.setGameManager( gameManager ));

		app = new viewer.App( playerMe.getNicknameToken(), playerOpp.getNicknameToken(), startGame );
	}

	static function startGame() {
		final endScreenModule = new EndScreenModule( gameManager );
		
		final commandManager = new CommandManager();
		commandManager.inject( gameManager );
		
		final animation = new Animation();
		final gameSummaryManager = new GameSummaryManager();
		final game = new Game( gameManager, endScreenModule, animation, gameSummaryManager );

		final gameDataProvider = new GameDataProvider( game, gameManager );

		final viewModule = new ViewModule( gameManager, gameDataProvider );
		final referee = new Referee( gameManager, commandManager, game, viewModule );

		gameManager.inject( referee, cast players );

		final inputStream = new haxe.ds.List<String>();
		final printStream = new haxe.ds.List<String>();
		
		final aiConnector = new AiConnector( ais, inputStream );
		
		// connect signals to ais via AiConnector
		final viewGlobalDataSignal = viewGlobalDataTrigger.asSignal();
		final frameViewDataSignal = frameViewDataTrigger.asSignal();
		final nextPlayerInfoSignal = nextPlayerInfoTrigger.asSignal();
		final nextPlayerInputSignal = nextPlayerInputTrigger.asSignal();
		
		viewGlobalDataSignal.handle( app.receiveViewGlobalData );
		frameViewDataSignal.handle( app.receiveFrameViewData );
		nextPlayerInfoSignal.handle( aiConnector.handleNextPlayerInfo );
		nextPlayerInputSignal.handle( aiConnector.handleNextPlayerInput );

		MainReferee.initInputStream( inputStream, seed );
		
		gameManager.start( inputStream, printStream );
	}
}