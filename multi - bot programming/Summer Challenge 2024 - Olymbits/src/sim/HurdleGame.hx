package sim;

import CodinGame.printErr;
import ai.data.Constants.D;
import ai.data.Constants.HURDLE;
import ai.data.Constants.L;
import ai.data.Constants.R;
import ai.data.Constants.U;
import ai.data.HurdleDataset;
import xa3.MathUtils.min;

class HurdleGame {
	
	public static function process( action:String, inputDataset:HurdleDataset, outputDataset:HurdleDataset, racetrack:Array<String> ) {
		if( inputDataset.position >= racetrack.length ) {
			outputDataset.position = racetrack.length;
			outputDataset.stunTimer = 0;
			return;
		}
		
		if( racetrack[0] == "G" ) {
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
				outputDataset.position = min( inputDataset.position + 2, racetrack.length );
			case L:
				outputDataset.position = min( inputDataset.position + 1, racetrack.length );
			case D:
				final endPos = min( inputDataset.position + 2, racetrack.length );
				for( pos in inputDataset.position + 1...endPos + 1 ) {
					outputDataset.position = pos;
					if( racetrack[pos] == HURDLE ) break;
				}
			case R:
				final endPos = min( inputDataset.position + 3, racetrack.length );
				for( pos in inputDataset.position + 1...endPos + 1 ) {
					outputDataset.position = pos;
					if( racetrack[pos] == HURDLE ) break;
				}
			default: throw 'Invalid action: $action';
		}
		if( racetrack[outputDataset.position] == HURDLE ) outputDataset.stunTimer = 3;
		// printErr( '$action input ${inputDataset.position}, output ${outputDataset.position}' );

	}
}