package ai.data;

class HurdleDataset {
	
	public var racetrack:Array<String> = [];
	public final positions:Array<Int> = [];
	public final stunTimers:Array<Int> = [];

	public function new() {}

	public function set( registerDataset:RegisterDataset ) {
		racetrack = registerDataset.gpu;
		positions[0] = registerDataset.reg0;
		positions[1] = registerDataset.reg1;
		positions[2] = registerDataset.reg2;
		stunTimers[0] = registerDataset.reg3;
		stunTimers[1] = registerDataset.reg4;
		stunTimers[2] = registerDataset.reg5;
	}
}