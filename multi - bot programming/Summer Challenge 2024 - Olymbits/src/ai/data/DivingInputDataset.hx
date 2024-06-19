package ai.data;

class DivingInputDataset {
	
	public var divingGoal:Array<String> = [];
	public final playerDatasets = [for ( i in 0...Constants.NUM_PLAYERS ) new ai.data.DivingDataset()];

	public function new() {}

	public function set( registerDataset:RegisterDataset ) {
		divingGoal = registerDataset.gpu;
		playerDatasets[0].points = registerDataset.reg0;
		playerDatasets[1].points = registerDataset.reg1;
		playerDatasets[2].points = registerDataset.reg2;
		playerDatasets[0].combos = registerDataset.reg3;
		playerDatasets[1].combos = registerDataset.reg4;
		playerDatasets[2].combos = registerDataset.reg5;
	}
}