package ai.data;

class HurdleInputDataset {
	
	public var racetrack:Array<String> = [];
	public var playerDatasets:Array<HurdleDataset> = [for( i in 0...Constants.NUM_PLAYERS ) new HurdleDataset()];

	public function new() {}

	public function set( registerDataset:RegisterDataset ) {
		racetrack = registerDataset.gpu;
		playerDatasets[0].position = registerDataset.reg0;
		playerDatasets[1].position = registerDataset.reg1;
		playerDatasets[2].position = registerDataset.reg2;
		playerDatasets[0].stunTimer = registerDataset.reg3;
		playerDatasets[1].stunTimer = registerDataset.reg4;
		playerDatasets[2].stunTimer = registerDataset.reg5;
	}
}