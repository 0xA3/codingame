package test;

import ai.algorithm.GetPaths;
import ai.data.CellDataset;

using StringTools;
using buddy.Should;

class TestGetPaths extends buddy.BuddySuite {

	public function new() {
		describe( "Test GetPaths", {
			it( "2 cells", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1] ),
					CellDataset.create( 0, [0] )
				];

				final paths = GetPaths.get( cells );
				paths[1].join("-").should.be( "0-1" );
				// printPaths( paths );
			});
			it( "3 cells in row", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1] ),
					CellDataset.create( 0, [0, 2] ),
					CellDataset.create( 0, [1] ),
				];

				final paths = GetPaths.get( cells );
				paths[2].join("-").should.be( "0-1-2" );
				// printPaths( paths );
			});
			it( "4 cells quad path 0 to 3: 0-1-3", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1, 2] ),
					CellDataset.create( 0, [0, 3], 1 ),
					CellDataset.create( 0, [0, 3] ),
					CellDataset.create( 0, [1, 2] ),
				];

				final paths = GetPaths.get( cells );
				paths[3].join("-").should.be( "0-1-3" );
				// printPaths( paths );
			});
			it( "4 cells quad path 0 to 3: 0-2-3", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1, 2] ),
					CellDataset.create( 0, [0, 3] ),
					CellDataset.create( 0, [0, 3], 1 ),
					CellDataset.create( 0, [1, 2] ),
				];

				final paths = GetPaths.get( cells );
				paths[3].join("-").should.be( "0-2-3" );
				// printPaths( paths );
			});
			it( "longer distance but with more resources", {
				final cells:Array<CellDataset> = [
					CellDataset.create( 0, [1, 4] ), // 0
					CellDataset.create( 0, [0, 2], 1 ), // 1
					CellDataset.create( 0, [1, 3] ), // 2
					CellDataset.create( 0, [2, 3] ), // 3
					CellDataset.create( 0, [0, 3] ), // 4
				];

				final paths = GetPaths.get( cells );
				paths[3].join("-").should.be( "0-4-3" );
				// printPaths( paths );
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

				final paths = GetPaths.get( cells );
				paths[10].join("-").should.be( "1-0-3" );
				// printPaths( paths );
			});
		});
	}

	function printPaths( paths:Array<Array<Int>> ) {
		for( i in 0...paths.length ) {
			final path = paths[i];
			if( path != null ) {
				trace( '${path[0]}-${path[path.length - 1]} length ${path.length - 1} $path' );
			}
		}
	}
}
