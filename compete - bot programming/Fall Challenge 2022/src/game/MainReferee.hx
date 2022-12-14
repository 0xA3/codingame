package game;

import Std.int;
import Std.parseInt;
import agent.CurrentAgents;
import gameengine.core.GameManager;

class MainReferee {
	
	static final corners = [new Vector( 0, 0 ), new Vector( Config.MAP_WIDTH, Config.MAP_HEIGHT )];
	
	static final scoreTotals = [0, 0];
	static var ties = 0;

	public static function main() {
		final args = Sys.args();
		final repeats = args[0] == null ? 1 : parseInt( args[0] );
		
		final agentMe = CurrentAgents.agentMe;
		final agentOpp = CurrentAgents.agentOpp;

		final playerMe = new Player( 0, agentMe.agentId, int( corners[0].x ), int( corners[0].y ));
		final playerOpp = new Player( 1, agentOpp.agentId, int( corners[1].x ), int( corners[1].y ));
		
		final gameManager = new GameManager( [ playerMe, playerOpp ] );
		
		final referee = new Referee( gameManager, corners, agentMe, agentOpp );

		for( i in 0...repeats ) {
			referee.init( i );
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