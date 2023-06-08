package test;

import ai.algorithm.GetDistances;
import ai.data.CellDataset;

using StringTools;
using buddy.Should;

class TestGetDistances extends buddy.BuddySuite {

	public function new() {
		describe( "Test DistanceMatrixFactory", {
			it( "2 cells", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1] ),
					CellDataset.create( 0, [0] )
				];

				final distances = GetDistances.get( cells );
				printDistances( distances, cells.length );
			});
			it( "3 cells", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1] ),
					CellDataset.create( 0, [0, 2] ),
					CellDataset.create( 0, [1] ),
				];

				final distances = GetDistances.get( cells );
				printDistances( distances, cells.length );
			});
			it( "4 cells quad", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1, 2] ),
					CellDataset.create( 0, [0, 3] ),
					CellDataset.create( 0, [0, 3] ),
					CellDataset.create( 0, [1, 2] ),
				];

				final distances = GetDistances.get( cells );
				printDistances( distances, cells.length );
			});
			it( "7 hex grid", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1, 2, 3, 4, 5, 6] ), // center
					CellDataset.create( 0, [0, 2, 6] ), // 1
					CellDataset.create( 0, [0, 3, 1] ), // 2
					CellDataset.create( 0, [0, 4, 2] ), // 3
					CellDataset.create( 0, [0, 5, 3] ), // 4
					CellDataset.create( 0, [0, 6, 4] ), // 5
					CellDataset.create( 0, [0, 1, 5] ), // 6
				];

				final distances = GetDistances.get( cells );
				printDistances( distances, cells.length );
			});
		});
	}

	function printDistances( distances:Array<Int>, width:Int ) {
		for( y in 0...width ) {
			final outputs = ['$y:'];
			for( x in 0...width ) {
				final index = y * width + x;
				outputs.push( '${distances[index]}' );
			}
			trace( outputs.join(" ") );
		}
	}
}
