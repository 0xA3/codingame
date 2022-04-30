package game;

import Std.int;
import Std.parseInt;
import agent.CurrentAgents;
import gameengine.core.GameManager;

class MainReferee {
	
	static final corners = [new Vector( 0, 0 ), new Vector( Config.MAP_WIDTH, Config.MAP_HEIGHT )];
	
	static final scoreTotals = [0, 0];

	public static function main() {
		final args = Sys.args();
		final repeats = args[0] == null ? 2 : parseInt( args[0] );
		
		final player0 = new Player( 0, "Agent0", int( corners[0].x ), int( corners[0].y ));
		final player1 = new Player( 1, "Agent1", int( corners[1].x ), int( corners[1].y ));
		
		final gameManager = new GameManager([ player0, player1 ]);
		
		final referee = new Referee( gameManager, corners, CurrentAgents.agentMe, CurrentAgents.agentOpp );

		for( i in 0...repeats ) {
			referee.init( i );
			final scores = referee.run();
			for( i in 0...scores.length ) scoreTotals[i] += scores[i];
		}
		
		Sys.println( '${player0.name} wins ${scoreTotals[0]}' );
		Sys.println( '${player1.name} wins ${scoreTotals[1]}' );
	}
}