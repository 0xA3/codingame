package game;

import Std.parseInt;
import game.action.CompleteAction;
import game.action.GrowAction;
import game.action.SeedAction;
import game.action.WaitAction;

class CommandManager {
	
	public function new() {}

	public function parseCommands( player:Player, outputs:Array<String>, game:Game ) {
		if( outputs == null || outputs.length == 0 ) throw "Error: no outputs available";
		if( outputs.length > 1 ) throw "Error: outputs must be length 1";
		final output = outputs[0];

		if( output == "WAIT" ) {
			player.action = new WaitAction();
		} else {
			final parts = output.split(" ");
			final command = parts[0];
			switch command {
			case "GROW":
				final targetId = parseInt( parts[1] );
				player.action = new GrowAction( targetId );
			case "COMPLETE":
				final targetId = parseInt( parts[1] );
				player.action = new CompleteAction( targetId );
			case "SEED":
				final sourceId = parseInt( parts[1] );
				final targetId = parseInt( parts[2] );
				player.action = new SeedAction( sourceId, targetId );
			default: throw 'Error unknown command $output';
			}

		}
		// trace( 'player ${player.index} ${player.action}' );
	}
}