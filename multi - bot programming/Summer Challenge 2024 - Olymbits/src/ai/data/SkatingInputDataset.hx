package ai.data;

class SkatingInputDataset {
	
	public var risks:Array<String> = [];
	public final playerDatasets = [for( i in 0...Constants.NUM_PLAYERS ) new ai.data.SkatingDataset()];
	public var turnsLeft:Int;

	public function new() {}

	public function set( registerDataset:RegisterDataset ) {
		risks = registerDataset.gpu;
		playerDatasets[0].spacesTravelled = registerDataset.reg0;
		playerDatasets[1].spacesTravelled = registerDataset.reg1;
		playerDatasets[2].spacesTravelled = registerDataset.reg2;
		playerDatasets[0].riskOrStun = registerDataset.reg3;
		playerDatasets[1].riskOrStun = registerDataset.reg4;
		playerDatasets[2].riskOrStun = registerDataset.reg5;
		turnsLeft = registerDataset.reg6;
	}
}