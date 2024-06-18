package ai.data;

class DivingDataset {
	
	public var divingGoal:Array<String> = [];
	public final points:Array<Int> = [];
	public final combos:Array<Int> = [];

	public function new() {}

	public function set( registerDataset:RegisterDataset ) {
		divingGoal = registerDataset.gpu;
		points[0] = registerDataset.reg0;
		points[1] = registerDataset.reg1;
		points[2] = registerDataset.reg2;
		combos[0] = registerDataset.reg3;
		combos[1] = registerDataset.reg4;
		combos[2] = registerDataset.reg5;
	}
}