package ai.data;

import CodinGame.printErr;
import Std.parseInt;

class ArcheryInputDataset {
	
	public var winds:Array<Int> = [];
	public var playerDatasets:Array<ArcheryDataset> = [for( i in 0...Constants.NUM_PLAYERS ) new ArcheryDataset()];

	public function new() { }

	public function set( registerDataset:RegisterDataset ) {
		winds = registerDataset.gpu.map( s -> parseInt( s ));
		playerDatasets[0].position.x = registerDataset.reg0;
		playerDatasets[0].position.y = registerDataset.reg1;
		playerDatasets[1].position.x = registerDataset.reg2;
		playerDatasets[1].position.y = registerDataset.reg3;
		playerDatasets[2].position.x = registerDataset.reg4;
		playerDatasets[2].position.y = registerDataset.reg5;
	}
}