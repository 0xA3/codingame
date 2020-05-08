package test;

import GridFactory;
import Cell;

using buddy.Should;

class TestGridFactory extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test TestGridFactory", {
			
			it( "test 1x1 grid", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = ["#"];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				grid.getCell( 0, 0 ).content.should.equal( Wall );
			});
			
			it( "test 2x1 grid", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = ["# "];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				grid.getCell( 1, 0 ).content.should.equal( Unknown );
			});
			
			it( "test 1x2 grid", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = ["#", " "];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				grid.getCell( 0, 1 ).content.should.equal( Unknown );
			});
			
			it( "test 4x3 grid", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = ["####", "#  #", "####"];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				grid.getCell( 1, 1 ).content.should.equal( Unknown );
			});
			
			
		});

	}
}