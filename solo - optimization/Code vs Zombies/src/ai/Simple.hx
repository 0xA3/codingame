package ai;

import data.FrameDataset;

class Simple implements Ai {
	
	public function new() {}

	public function reset() {}

	public function process( frame:FrameDataset ) {
		if( frame.zombies.length == 0 ) return "0 0";

		final target = frame.zombies[0];
		return '${target.xNext} ${target.yNext}';
	}
}