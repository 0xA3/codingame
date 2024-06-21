package ai.contexts;

import CodinGame.printErr;
import ai.data.Constants.L;
import ai.data.HurdleDataset;
import sim.HurdleGame;

class GetWorstHurdleActions {
	
	public static function get( hurdleDataset:HurdleDataset, racetrack:Array<String> ) {
		final actions = [];

		final temp = hurdleDataset.copy();
		while( temp.position < racetrack.length ) {
			final action = L;
			actions.push( action );

			HurdleGame.process( action, temp, temp, racetrack );
			// printErr( 'worst temp.position ${temp.position}, temp.stunTimer ${temp.stunTimer}' );
		}

		return actions;
	}
}