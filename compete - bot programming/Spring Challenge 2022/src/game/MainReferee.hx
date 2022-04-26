package game;

import Std.int;
import Std.parseInt;
import gameengine.core.GameManager;

class MainReferee {
	
	static final corners = [new Vector( 0, 0 ), new Vector( Config.MAP_WIDTH, Config.MAP_HEIGHT )];
	
	public static function main() {
		final args = Sys.args();
		final repeats = args[0] == null ? 1 : parseInt( args[0] );
		
		final player0 = new Player( 0, "Agent0", int( corners[0].x ), int( corners[0].y ));
		final player1 = new Player( 1, "Agent1", int( corners[1].x ), int( corners[1].y ));
		
		final gameManager = new GameManager([ player0, player1 ]);
		
		final referee = new Referee( gameManager, corners );

		for( i in 0...repeats ) {
			referee.init( i );
			referee.run();
		}
	
	}
}