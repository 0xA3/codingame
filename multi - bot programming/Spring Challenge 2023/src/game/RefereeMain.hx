package game;

import Std.parseInt;
import ai.CurrentAis;
import ai.IAi;
import event.Animation;
import gameengine.core.AbstractPlayer;
import gameengine.core.MultiplayerGameManager;
import gameengine.core.OutputData;
import gameengine.module.endscreen.EndScreenModule;
import tink.core.Signal;
import view.GameDataProvider;
import view.ViewModule;

using Lambda;

class RefereeMain {
	
	static final scoreTotals = [0, 0];
	static var ties = 0;

	public static function main() {
		final args = Sys.args();
		final repeats = args[0] == null ? 1 : parseInt( args[0] );
		final seed = args[1] == null ? "0" : args[1];
		
		final aiMe = CurrentAis.aiMe;
		final aiOpp = CurrentAis.aiOpp;
		final ais = [aiMe, aiOpp];

		final playerMe = new Player( 0, aiMe.aiId );
		final playerOpp = new Player( 1, aiOpp.aiId );
		final players = [playerMe, playerOpp];

		final viewGlobalDataTrigger = Signal.trigger();
		final frameViewDataTrigger = Signal.trigger();
		final nextPlayerInfoTrigger = Signal.trigger();
		final nextPlayerInputTrigger = Signal.trigger();

		final gameManager = new MultiplayerGameManager( viewGlobalDataTrigger, frameViewDataTrigger, nextPlayerInfoTrigger, nextPlayerInputTrigger );
		players.iter( p -> p.setGameManager( gameManager ));

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
		final nextPlayerInfoSignal = nextPlayerInfoTrigger.asSignal();
		final nextPlayerInputSignal = nextPlayerInputTrigger.asSignal();
		nextPlayerInfoSignal.handle( aiConnector.handleNextPlayerInfo );
		nextPlayerInputSignal.handle( aiConnector.handleNextPlayerInput );

		for( i in 0...repeats ) {
			initInputStream( inputStream, seed );
	
			gameManager.start( inputStream, printStream );
			var winner = "";
			
			if( players[0].getScore() > players[1].getScore() ) {
				scoreTotals[0]++;
				winner = playerMe.getNicknameToken();
			
			} else if( players[0].getScore() < players[1].getScore() ) {
				scoreTotals[1]++;
				winner = playerOpp.getNicknameToken();
			
			} else {
				ties++;
				winner = "Tie!";
			}
			
			Sys.println( 'Game $i  Winner: $winner   ${scoreTotals[0]}:${scoreTotals[1]}:$ties   ${Math.round( scoreTotals[0] / ( i + 1 ) * 100 )}% : ${Math.round( scoreTotals[1] / ( i + 1 ) * 100 )}% : ${Math.round( ties / ( i + 1 ) * 100 )}%' );
		}
		
		Sys.println( '${playerMe.getNicknameToken()} wins: ${scoreTotals[0]}  ${scoreTotals[0] / repeats * 100}%' );
		Sys.println( '${playerOpp.getNicknameToken()} wins: ${scoreTotals[1]} ${scoreTotals[1] / repeats * 100}%' );
		Sys.println( 'Ties $ties ${ties / repeats * 100}%' );

		Sys.exit( 0 );
	}

	public static function initInputStream( inputStream:haxe.ds.List<String>, seed:String ) {
		inputStream.clear();
		inputStream.add( "INIT" );
		inputStream.add( "2" );
		inputStream.add( "" );
		inputStream.add( seed );
		inputStream.add( "GET_GAME_INFO" );
		inputStream.add( "SET_PLAYER_OUTPUT 1" );
	}
}