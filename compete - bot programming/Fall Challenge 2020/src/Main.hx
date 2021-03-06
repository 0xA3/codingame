package;

import game.data.State;
import game.contexts.BeamSearch;
import haxe.Timer;
import game.contexts.ParseAction;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	public static inline var END_POTIONS = 6;
	public static inline var RESPONSE_TIME = 50 / 1000 * 0.94;
	public static inline var BEAM_SIZE = 1000;
	
	public static var start:Float;
	public static var end:Float;

	public static var rootState:State;

	static function main() {
		
		var step = 0;
		while( true ) {
			final actionCount = parseInt( readline() ); // the number of spells and recipes in play
			start = Timer.stamp();
			end = start + RESPONSE_TIME;
			final actions = [for( i in 0...actionCount ) {
				final line = readline();
				// printErr( line );
				ParseAction.parse( line.split(' '));
			}];
			
			final inputsP1 = readline().split( ' ' );
			final inputsP2 = readline().split( ' ' );
			
			rootState = new State(
				parseInt( inputsP1[0] ), parseInt( inputsP1[1] ), parseInt( inputsP1[2] ), parseInt( inputsP1[3] ), parseInt( inputsP1[4] ), 0, 0,
				parseInt( inputsP2[0] ), parseInt( inputsP2[1] ), parseInt( inputsP2[2] ), parseInt( inputsP2[3] ), parseInt( inputsP2[4] ), 0, 0,
				actions
			);

			final winnerState = BeamSearch.search( rootState, BEAM_SIZE, end, step );
			step++;

			print( winnerState.outputCommand() );
			// printErr( BeamSearch.getStats());
		}

	}

}
