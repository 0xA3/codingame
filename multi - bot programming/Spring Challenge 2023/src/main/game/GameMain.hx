package main.game;

import ai.CurrentAis;
import ai.IAi;
import gameengine.core.MultiplayerGameManager;
import gameengine.module.endscreen.EndScreenModule;
import h3d.Vector;
import main.event.Animation;
import main.view.FrameViewData;
import main.view.GameDataProvider;
import main.view.GlobalViewData;
import main.view.ViewModule;
import resources.view.Types.PlayerInfo;
import tink.core.Signal;

using Lambda;

class GameMain {
	
	static var seed:String;
	static var app:resources.view.App;

	static var gameManager:MultiplayerGameManager;
	static var ais:Array<IAi>;
	static var players:Array<Player>;
	
	static var globalViewDataTrigger:SignalTrigger<GlobalViewData>;
	static var frameViewDataTrigger:SignalTrigger<FrameViewData>;
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
		
		globalViewDataTrigger = Signal.trigger();
		frameViewDataTrigger = Signal.trigger();
		nextPlayerInfoTrigger = Signal.trigger();
		nextPlayerInputTrigger = Signal.trigger();

		gameManager = new MultiplayerGameManager( globalViewDataTrigger, frameViewDataTrigger, nextPlayerInfoTrigger, nextPlayerInputTrigger );
		players.iter( p -> p.setGameManager( gameManager ));

		app = new resources.view.App( startGame );
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

		final playerInfos:Array<PlayerInfo> = [
			{
				name: players[0].getNicknameToken(),
				avatar: hxd.Res.avatar.robot_01.toTile(),
				color: 0x0359a9,
				index: 0,
				isMe: true,
				number: 0,
				type: ""
			},
			{
				name: players[1].getNicknameToken(),
				avatar: hxd.Res.avatar.robot_02.toTile(),
				color: 0xd10404,
				index: 1,
				isMe: false,
				number: 1,
				type: ""
			}
		];
		
		final inputStream = new haxe.ds.List<String>();
		final printStream = new haxe.ds.List<String>();

		// connect signals
		final viewGlobalDataSignal = globalViewDataTrigger.asSignal();
		final frameViewDataSignal = frameViewDataTrigger.asSignal();
		final nextPlayerInfoSignal = nextPlayerInfoTrigger.asSignal();
		final nextPlayerInputSignal = nextPlayerInputTrigger.asSignal();
		
		viewGlobalDataSignal.handle(( data ) -> app.receiveViewGlobalData( playerInfos, data ));
		frameViewDataSignal.handle( app.receiveFrameViewData );
		
		final aiConnector = new AiConnector( ais, inputStream );
		nextPlayerInfoSignal.handle( aiConnector.handleNextPlayerInfo );
		nextPlayerInputSignal.handle( aiConnector.handleNextPlayerInput );

		RefereeMain.initInputStream( inputStream, seed );
		gameManager.start( inputStream, printStream, true );
	}
}