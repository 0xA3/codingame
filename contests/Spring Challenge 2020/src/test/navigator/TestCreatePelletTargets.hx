package test.navigator;

import Navigator.PelletTarget;

using buddy.Should;

class TestCreatePelletTargets extends buddy.BuddySuite {
	
	public function new() {

		describe( "TestCreatePelletTargets", {

			final startIndex = 0;

			it( "test pellet with distance 1", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"  #"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final navigator = new Navigator( 0, grid );
				final pelletIndices = [1];

				final pelletTargets = navigator.createPelletTargets( 0, pelletIndices, Food, 1 );
				pelletTargets[0].priority.should.be( 1 );
			});
			
			it( "test pellet with distance 2", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"   #"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final navigator = new Navigator( 0, grid );
				final pelletIndices = [2];

				final pelletTargets = navigator.createPelletTargets( 0, pelletIndices, Food, 1 );
				pelletTargets[0].priority.should.be( 0.5 );
			});

			it( "test pellet with distance 10", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"           #"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final navigator = new Navigator( 0, grid );
				final pelletIndices = [10];

				final pelletTargets = navigator.createPelletTargets( 0, pelletIndices, Food, 1 );
				pelletTargets[0].priority.should.be( 0.1 );
			});

			it( "test super-pellet with distance 10", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"           #"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final navigator = new Navigator( 0, grid );
				final pelletIndices = [10];

				final pelletTargets = navigator.createPelletTargets( 0, pelletIndices, Food, 9 );
				pelletTargets[0].priority.should.be( 0.9 );
			});

		});
	}
}
