package game;

import Std.int;
import Std.parseInt;
import ai.CurrentAis;
import event.Animation;
import game.pathfinding.PathFinder;
import gameengine.core.GameManager;
import view.ViewModule;
import xa3.MTRandom;

class MainReferee {
	
	static final scoreTotals = [0, 0];
	static var ties = 0;

	public static function main() {
		final args = Sys.args();
		final repeats = args[0] == null ? 1 : parseInt( args[0] );
		
		final random = new MTRandom( 0 );

		final aiMe = CurrentAis.aiMe;
		final aiOpp = CurrentAis.aiOpp;

		final playerMe = new Player( 0, aiMe.aiId );
		final playerOpp = new Player( 1, aiOpp.aiId );
		
		final gameManager = new GameManager( [ playerMe, playerOpp ], random );
		final endScreenModule = new EndScreenModule();
		final commandManager = new CommandManager();
		final pathFinder = new PathFinder();
		final animation = new Animation();
		final gameSummaryManager = new GameSummaryManager();
		final viewModule = new ViewModule();
		final game = new Game( gameManager, endScreenModule, pathFinder, animation, gameSummaryManager );

		final referee = new Referee( gameManager, commandManager, game, viewModule );

		for( i in 0...repeats ) {
			referee.init();
			final scores = referee.run();
			var winner = "";
			
			if( scores[0] > scores[1] ) {
				scoreTotals[0]++;
				winner = playerMe.name;
			
			} else if( scores[0] < scores[1] ) {
				scoreTotals[1]++;
				winner = playerOpp.name;
			
			} else {
				ties++;
				winner = "Tie!  ";
			}
			
			Sys.println( 'Game $i  Winner: $winner   ${scoreTotals[0]}:${scoreTotals[1]}:$ties   ${Math.round( scoreTotals[0] / ( i + 1 ) * 100 )}% : ${Math.round( scoreTotals[1] / ( i + 1 ) * 100 )}% : ${Math.round( ties / ( i + 1 ) * 100 )}%' );
		}
		
		Sys.println( '${playerMe.name} wins: ${scoreTotals[0]}  ${scoreTotals[0] / repeats * 100}%' );
		Sys.println( '${playerOpp.name} wins: ${scoreTotals[1]} ${scoreTotals[1] / repeats * 100}%' );
		Sys.println( 'Ties $ties ${ties / repeats * 100}%' );
	}
}