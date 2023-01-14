package test;

import GridFactory;
import Cell;

using buddy.Should;

class TestGetPossibleDestinations extends buddy.BuddySuite {
	
	public function new() {

		describe( "Test TestGetPossibleDestinations", {

			it( "test single center", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"###",
					"# #",
					"###"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final indices = grid.getPossibleDestinations( 1, 1 );

				indices.length.should.be( 1 );
				indices[0].should.be( 4 );
			});

			it( "test +", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"# #",
					"   ",
					"# #"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final indices = grid.getPossibleDestinations( 1, 1 );
				
				// trace( [for( i in 0...indices.length ) '[${grid.getCellX( indices[i] )} ${grid.getCellY( indices[i] )}]'] );

				indices.length.should.be( 5 );
			});

			it( "test empty 3x3 rectangle", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"   ",
					"   ",
					"   "
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final indices = grid.getPossibleDestinations( 1, 1 );
				// trace( [for( i in 0...indices.length ) '[${grid.getCellX( indices[i] )} ${grid.getCellY( indices[i] )}]'] );

				indices.length.should.be( 5 );
			});

			it( "test 3x3 wrap x left", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"###",
					"   ",
					"###"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final indices = grid.getPossibleDestinations( 0, 1 );
				// trace( [for( i in 0...indices.length ) '[${grid.getCellX( indices[i] )} ${grid.getCellY( indices[i] )}]'] );

				indices.length.should.be( 3 );
				indices[0].should.be( 5 );
			});

			it( "test 3x3 wrap x right", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"###",
					"   ",
					"###"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final indices = grid.getPossibleDestinations( 2, 1 );
				// trace( [for( i in 0...indices.length ) '[${grid.getCellX( indices[i] )} ${grid.getCellY( indices[i] )}]'] );

				indices.length.should.be( 3 );
				indices[0].should.be( 4 );
			});

			it( "test empty 5x5 rectangle", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"     ",
					"     ",
					"     ",
					"     ",
					"     "
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final indices = grid.getPossibleDestinations( 2, 2 );
				// trace( [for( i in 0...indices.length ) '[${grid.getCellX( indices[i] )} ${grid.getCellY( indices[i] )}]'] );
				
				indices.length.should.be( 5 );
			});

			it( "test empty 5x5 rectangle with speed", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"     ",
					"     ",
					"     ",
					"     ",
					"     "
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final indices = grid.getPossibleDestinations( 2, 2, true );
				// trace( [for( i in 0...indices.length ) '[${grid.getCellX( indices[i] )} ${grid.getCellY( indices[i] )}]'] );

				indices.length.should.be( 13 );
			});
			
			it( "test 5x5 wall rectangle with speed", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"   # ",
					"   # ",
					"   # ",
					"   # ",
					"   # "
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final indices = grid.getPossibleDestinations( 2, 2, true );
				// trace( [for( i in 0...indices.length ) '[${grid.getCellX( indices[i] )} ${grid.getCellY( indices[i] )}]'] );

				indices.length.should.be( 9 );
			});

		});

	}

}