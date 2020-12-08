package;

import haxe.Timer;
import game.contexts.BeamSearch;
import test.CreatePlayer;
import game.data.State;
import test.CreateActions;
import test.Inputs;
import CodinGame.print;
import CodinGame.printErr;

using Lambda;

class MainLocal {
	
	public static inline var MAX_RESPONSE_TIME = 50 / 1000;
	public static inline var RESPONSE_TIME = 50 / 1000 * 0.94;
	public static inline var BEAM_SIZE = 1000;
	// public static inline var BEAM_SIZE = 100;

	public static var start:Float;
	public static var end:Float;
	
	static function main() {
		
		final inputs = Inputs.INPUT_ACTIONS_90;
		
		final actions = CreateActions.create( inputs.actions );
		final p1 = CreatePlayer.create( inputs.players, 1, "Crom" );
		final p2 = CreatePlayer.create( inputs.players, 2, "Hulk" );
		// trace( actions.map( a -> a.toString()).join(",") );
		var rootState = new State(
			p1.inv0, p1.inv1, p1.inv2, p1.inv3, p1.score, 0, 0,
			p2.inv0, p2.inv1, p2.inv2, p2.inv3, p2.score, 0, 0,
			actions
		);
		printErr( 'Total potions: ${rootState.getAvailablePotions()}      Player1 ${rootState.p1Output()}' );
		
		var step = 0;
		while( step < 100 ) {
			
			start = Timer.stamp();
			end = start + RESPONSE_TIME;
			
			final winnerState = BeamSearch.search( rootState, BEAM_SIZE, end, step );
			final output = winnerState.outputCommand();
/*			
			final stamp = Timer.stamp();
			if( stamp > start + MAX_RESPONSE_TIME ) {
				print( 'TIMEOUT' );
				// print( 'TIMEOUT ${delta( stamp )}' );
				// print( 'breakEnd ${delta( BeamSearch.breakEnd )}\nrecurseStart ${delta( BeamSearch.recurseStart )}\ntime ${delta( stamp )}' );
				break;
			}
*/			
			print( 'step $step - $output      Player1 ${winnerState.p1Output()}' );
			
			if( winnerState.getAvailablePotions() == 0 ) {
				print( 'All potions brewed\nThe End' );
				break;
			}
			
			// printErr( winnerState.outputActions());

			rootState = winnerState.createRootState();

			step++;

		}
	}

	public static function delta( v:Float ) {
		return ( v - start ) * 1000;
	}

}
