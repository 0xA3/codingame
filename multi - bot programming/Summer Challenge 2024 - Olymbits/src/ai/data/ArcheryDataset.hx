package ai.data;

import CodinGame.printErr;
import Std.parseInt;

class ArcheryDataset {
	
	public var winds:Array<Int> = [];
	public final positions:Array<Pos> = [];

	public function new() {
		for( _ in 0...ai.data.Constants.NUM_PLAYERS ) positions.push( new Pos() );
	}

	public function set( registerDataset:RegisterDataset ) {
		winds = registerDataset.gpu.map( s -> parseInt( s ));
		positions[0].x = registerDataset.reg0;
		positions[0].y = registerDataset.reg1;
		positions[1].x = registerDataset.reg2;
		positions[1].y = registerDataset.reg3;
		positions[2].x = registerDataset.reg4;
		positions[2].y = registerDataset.reg5;
	}
}