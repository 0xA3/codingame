package ai.data;

class SkatingDataset {
	
	public var actions:Array<String> = [];
	public final spacesTravelled:Array<Int> = [];
	public final riskStunTimers:Array<Int> = [];
	public var turnsLeft:Int;

	public function new() {}

	public function set( registerDataset:RegisterDataset ) {
		actions = registerDataset.gpu;
		spacesTravelled[0] = registerDataset.reg0;
		spacesTravelled[1] = registerDataset.reg1;
		spacesTravelled[2] = registerDataset.reg2;
		riskStunTimers[0] = registerDataset.reg3;
		riskStunTimers[1] = registerDataset.reg4;
		riskStunTimers[2] = registerDataset.reg5;
		turnsLeft = registerDataset.reg6;
	}
}