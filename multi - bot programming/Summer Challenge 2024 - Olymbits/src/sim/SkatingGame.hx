package sim;

import ai.data.SkatingDataset;
import xa3.MathUtils.max;

class SkatingGame {
	
	public static function process( action:String, inputDataset:SkatingDataset, outputDataset:SkatingDataset, risks:Array<String>, turnsLeft:Int ) {
		if( risks[0] == "G" ) {
			outputDataset.spacesTravelled = 0;
			outputDataset.riskOrStun = 0;
			return;
		}

		if( inputDataset.riskOrStun < 0 ) {
			outputDataset.spacesTravelled = inputDataset.spacesTravelled;
			outputDataset.riskOrStun = inputDataset.riskOrStun + 1;
			return;
		}

		if( action == risks[0] ) {
			outputDataset.spacesTravelled = inputDataset.spacesTravelled + 1;
			outputDataset.riskOrStun = max( inputDataset.riskOrStun - 1, 0 );
			return;
		}
		
		if( action == risks[1] ) {
			outputDataset.spacesTravelled = inputDataset.spacesTravelled + 2;
			return;
		}

		if( action == risks[2] ) {
			outputDataset.spacesTravelled = inputDataset.spacesTravelled + 2;
			outputDataset.riskOrStun = inputDataset.riskOrStun + 1;
		
		} else if( action == risks[3] ) {
			outputDataset.spacesTravelled = inputDataset.spacesTravelled + 3;
			outputDataset.riskOrStun = inputDataset.riskOrStun + 2;
		}

		if( outputDataset.riskOrStun >= 5 ) outputDataset.riskOrStun = -2;
	}
}