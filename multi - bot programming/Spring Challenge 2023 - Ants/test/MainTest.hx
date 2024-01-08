package test;

import ai.algorithm.GetPaths;
import ai.data.CellDataset;

class MainTest {
	
	static function main() {
		final cells:Array<CellDataset> = [
			CellDataset.create( 0, [1, 2], 1 ),
			CellDataset.create( 0, [0, 3], 2 ),
			CellDataset.create( 0, [0, 3], 3 ),
			CellDataset.create( 0, [1, 2], 4 ),
		];

		final paths = GetPaths.get( cells );
	}
}