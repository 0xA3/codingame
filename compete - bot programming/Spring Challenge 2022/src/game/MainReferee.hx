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
		final repeats = args[0] == null ? 2 : parseInt( args[0] );
		
		final player0 = new Player( 0, CurrentAgents.agentMe.agentId, int( corners[0].x ), int( corners[0].y ));
		final player1 = new Player( 1, CurrentAgents.agentOpp.agentId, int( corners[1].x ), int( corners[1].y ));
		
		final gameManager = new GameManager([ player0, player1 ]);
		
		final referee = new Referee( gameManager, corners, CurrentAgents.agentMe, CurrentAgents.agentOpp );

		for( i in 0...repeats ) {
			referee.init( i );
			final scores = referee.run();
			var winner = "";
			
			if( scores[0] > scores[1] ) {
				scoreTotals[0]++;
				winner = player0.name;
			
			} else if( scores[0] < scores[1] ) {
				scoreTotals[1]++;
				winner = player1.name;
			
			} else {
				ties++;
				winner = "Tie!  ";
			}
			
			Sys.println( 'Game $i  Winner: $winner   ${scoreTotals[0]}:${scoreTotals[1]}:$ties   ${Math.round( scoreTotals[0] / ( i + 1 ) * 100 )}% : ${Math.round( scoreTotals[1] / ( i + 1 ) * 100 )}% : ${Math.round( ties / ( i + 1 ) * 100 )}%' );
		}
		
		Sys.println( '${player0.name} wins: ${scoreTotals[0]}  ${scoreTotals[0] / repeats * 100}%' );
		Sys.println( '${player1.name} wins ${scoreTotals[1]} ${scoreTotals[1] / repeats * 100}%' );
	}
}