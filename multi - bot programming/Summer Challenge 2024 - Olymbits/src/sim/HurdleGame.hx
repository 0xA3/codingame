package sim;

import ai.data.Constants.D;
import ai.data.Constants.HURDLE;
import ai.data.Constants.L;
import ai.data.Constants.R;
import ai.data.Constants.U;
import ai.data.HurdleDataset;
import xa3.MathUtils.min;

class HurdleGame {
	
	public static function process( action:String, inputDataset:HurdleDataset, outputDataset:HurdleDataset, raceTrack:Array<String> ) {
		if( raceTrack[0] == "G" ) {
			outputDataset.position = 0;
			outputDataset.stunTimer = 0;
			return;
		}
		
		if( inputDataset.stunTimer > 0 ) {
			outputDataset.position = inputDataset.position;
			outputDataset.stunTimer = inputDataset.stunTimer - 1;
			return;
		}

		switch action {
			case U:
				outputDataset.position = min( inputDataset.position + 2, raceTrack.length );
			case L:
				outputDataset.position = min( inputDataset.position + 1, raceTrack.length );
			case D:
				final endPos = min( inputDataset.position + 3, raceTrack.length );
				for( pos in inputDataset.position + 1...endPos ) {
					outputDataset.position = pos;
					if( raceTrack[pos] == HURDLE ) break;
				}
			case R:
				final endPos = min( inputDataset.position + 4, raceTrack.length );
				for( pos in inputDataset.position + 1...endPos ) {
					outputDataset.position = pos;
					if( raceTrack[pos] == HURDLE ) break;
				}
			default: throw 'Invalid action: $action';
		}
		if( raceTrack[outputDataset.position] == HURDLE ) outputDataset.stunTimer = 3;
	}
}