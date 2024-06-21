package ai.contexts;

import CodinGame.printErr;
import ai.data.Constants.D;
import ai.data.Constants.HURDLE;
import ai.data.Constants.L;
import ai.data.Constants.R;
import ai.data.Constants.U;
import ai.data.HurdleDataset;
import sim.HurdleGame;

class GetBestHurdleActions {
	
	public static function get( hurdleDataset:HurdleDataset, racetrack:Array<String> ) {
		final actions = [];
		
		final temp = hurdleDataset.copy();
		while( temp.position < racetrack.length ) {
			final action = getAction( racetrack, temp.position, temp.stunTimer );
			actions.push( action );

			HurdleGame.process( action, temp, temp, racetrack );
		}

		return actions;
	}

	static function getAction( racetrack:Array<String>, position:Int, stunTimer:Int ) {
		if( stunTimer > 0 ) return L;

		final hurdleDistance = getHurdleDistance( racetrack, position );
		if( hurdleDistance == 1 ) return U;
		if( hurdleDistance == 2 ) return L;
		if( hurdleDistance == 3 ) return D;
		
		return R;
	}

	static function getHurdleDistance( racetrack:Array<String>, position:Int ) {
		for( i in position + 1...racetrack.length ) {
			if( racetrack[i] == HURDLE ) {
				return i - position;
			}
		}
		return racetrack.length;
	}
}