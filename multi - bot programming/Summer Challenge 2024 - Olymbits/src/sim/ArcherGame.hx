package sim;

import ai.data.ArcheryDataset;
import ai.data.Constants.D;
import ai.data.Constants.L;
import ai.data.Constants.R;
import ai.data.Constants.U;
import xa3.MathUtils.max;
import xa3.MathUtils.min;

class ArcherGame {
	
	public static function process( action:String, inputDataset:ArcheryDataset, outputDataset:ArcheryDataset, currentWind:Int ) {
		switch action {
			case U:
				outputDataset.position.x = inputDataset.position.x;
				outputDataset.position.y = max( inputDataset.position.y - currentWind, -20 );
			case L:
				outputDataset.position.x = max( inputDataset.position.x - currentWind, -20 );
				outputDataset.position.y = inputDataset.position.y;
			case D:
				outputDataset.position.x = inputDataset.position.x;
				outputDataset.position.y = min( inputDataset.position.y + currentWind, 20 );
			case R:
				outputDataset.position.x = min( inputDataset.position.x + currentWind, 20 );
				outputDataset.position.y = inputDataset.position.y;
			default: throw 'Invalid action: $action';
		}
	}
}