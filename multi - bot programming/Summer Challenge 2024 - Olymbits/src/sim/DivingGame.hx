package sim;

import ai.data.DivingDataset;

class DivingGame {
	
	public static function process( action:String, inputDataset:DivingDataset, outputDataset:DivingDataset, divingGoal:String ) {
		if( divingGoal == "G" ) {
			outputDataset.points = 0;
			outputDataset.combos = 0;
			return;
		}

		if( action == divingGoal ) {
			outputDataset.points = inputDataset.points + 1;
			outputDataset.combos = inputDataset.combos + 1;
		} else {
			outputDataset.points = inputDataset.points;
			outputDataset.combos = 0;
		}
	}
}