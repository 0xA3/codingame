package test;

import GridFactory;
import Cell;

using buddy.Should;

class TestGrid extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getVisibleCellIndices", {

			it( "test horizontal middle", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = ["####", "#  #", "####"];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final visibleCells = grid.getVisibleCellIndices( 1, 1 );

				visibleCells.length.should.be( 1 );
			});

			it( "test visible cells down", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final grid = get3CellsGrid();
				final visibleCells = grid.getVisibleCellIndices( 1, 0 );
				// trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
			it( "test visible cells right", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final grid = get3CellsGrid();
				final visibleCells = grid.getVisibleCellIndices( 0, 1 );
				// trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
			it( "test visible cells left", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final grid = get3CellsGrid();
				final visibleCells = grid.getVisibleCellIndices( 2, 1 );
				// trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
			it( "test visible cells up", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final grid = get3CellsGrid();
				final visibleCells = grid.getVisibleCellIndices( 1, 2 );
				// trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
			it( "test visible cells around left", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = ["####", "  # ", "####"];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final visibleCells = grid.getVisibleCellIndices( 1, 1 );
				// trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
		});

	}

	public function get3CellsGrid() {
		final lines = ["# #", "   ", "# #"];
		final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
		return grid;
	}

}