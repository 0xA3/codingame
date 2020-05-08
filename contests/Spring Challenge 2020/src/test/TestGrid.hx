package test;

import GridFactory;
import Cell;

using buddy.Should;

class TestGrid extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getVisibleCells", {
			
			it( "test horizontal middle", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = ["####", "#  #", "####"];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final visibleCells = grid.getVisibleCells( 1, 1 );

				visibleCells.length.should.be( 1 );
			});

			it( "test cross down", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final grid = getCrossGrid();
				final visibleCells = grid.getVisibleCells( 1, 0 );
				trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
			it( "test cross right", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final grid = getCrossGrid();
				final visibleCells = grid.getVisibleCells( 0, 1 );
				trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
			it( "test cross left", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final grid = getCrossGrid();
				final visibleCells = grid.getVisibleCells( 2, 1 );
				trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
			it( "test cross up", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final grid = getCrossGrid();
				final visibleCells = grid.getVisibleCells( 1, 2 );
				trace( visibleCells );
				visibleCells.length.should.be( 2 );
			});
			
			
		});

	}

	public function getCrossGrid() {
		final lines = ["# #", "   ", "# #"];
		final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
		return grid;
	}
}