package ai.data;

class SkatingDataset {
	
	public var actions:Array<String> = [];
	public final spacesTravelled:Array<Int> = [];
	public final riskOrStun:Array<Int> = [];
	public var turnsLeft:Int;

	public function new() {}

	public function set( registerDataset:RegisterDataset ) {
		actions = registerDataset.gpu;
		spacesTravelled[0] = registerDataset.reg0;
		spacesTravelled[1] = registerDataset.reg1;
		spacesTravelled[2] = registerDataset.reg2;
		riskOrStun[0] = registerDataset.reg3;
		riskOrStun[1] = registerDataset.reg4;
		riskOrStun[2] = registerDataset.reg5;
		turnsLeft = registerDataset.reg6;
	}
}