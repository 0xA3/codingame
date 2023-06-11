package game;

import Std.int;
import Std.parseInt;
import ai.CurrentAis;
import ai.IAi;
import gameengine.core.AbstractPlayer;
import gameengine.core.GameManager;
import xa3.MTRandom;

using Lambda;

class MainReferee {
	
	static final scoreTotals = [0, 0];
	static var ties = 0;

	public static function main() {
		final args = Sys.args();
		final repeats = args[0] == null ? 1 : parseInt( args[0] );
		
		final random = new MTRandom( 0 );

		final aiMe = CurrentAis.aiMe;
		final aiOpp = CurrentAis.aiOpp;

/*		final playerMe = new Player( 0, aiMe.aiId );
		final playerOpp = new Player( 1, aiOpp.aiId );
		final players = [playerMe, playerOpp];
		final playerAis:Map<AbstractPlayer, IAi> = [playerMe => aiMe, playerOpp => aiOpp];

		final gameManager = new GameManager( players, playerAis, random );
		players.iter( p -> p.setGameManager( gameManager ));
		
		final endScreenModule = new EndScreenModule();
		final commandManager = new CommandManager();
		final pathFinder = new PathFinder();
		final animation = new Animation();
		final gameSummaryManager = new GameSummaryManager();
		final game = new Game( gameManager, endScreenModule, pathFinder, animation, gameSummaryManager );

		final gameDataProvider = new GameDataProvider( game, gameManager );

		final viewModule = new ViewModule( gameManager, gameDataProvider );
		final referee = new Referee( gameManager, commandManager, game, viewModule );

		for( i in 0...repeats ) {
			final scores = gameManager.start( referee );
			var winner = "";
			
			if( scores[0] > scores[1] ) {
				scoreTotals[0]++;
				winner = playerMe.name;
			
			} else if( scores[0] < scores[1] ) {
				scoreTotals[1]++;
				winner = playerOpp.name;
			
			} else {
				ties++;
				winner = "Tie!";
			}
			
			Sys.println( 'Game $i  Winner: $winner   ${scoreTotals[0]}:${scoreTotals[1]}:$ties   ${Math.round( scoreTotals[0] / ( i + 1 ) * 100 )}% : ${Math.round( scoreTotals[1] / ( i + 1 ) * 100 )}% : ${Math.round( ties / ( i + 1 ) * 100 )}%' );
		}
		
		Sys.println( '${playerMe.name} wins: ${scoreTotals[0]}  ${scoreTotals[0] / repeats * 100}%' );
		Sys.println( '${playerOpp.name} wins: ${scoreTotals[1]} ${scoreTotals[1] / repeats * 100}%' );
		Sys.println( 'Ties $ties ${ties / repeats * 100}%' );
*/
		Sys.exit( 0 );
	}
}