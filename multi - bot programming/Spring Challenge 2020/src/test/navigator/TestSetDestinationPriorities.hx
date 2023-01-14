package test.navigator;

import PelletManager.PelletTarget;
import test.GetFloorLines;
import test.GetPelletIndices;

using buddy.Should;

class TestSetDestinationPriorities extends buddy.BuddySuite {
	
	public function new() {

		describe( "TestSetDestinationPriorities", {

			it( "test GetFloorLines.get", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"a"
				];
				final floorLines = GetFloorLines.get( lines );
				floorLines.length.should.be( 1 );
				floorLines[0].should.be(" ");
			});
			
			it( "test GetPelletIndices.get", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"·"
				];
				final pelletIndices = GetPelletIndices.get( lines, "·" );
				pelletIndices.length.should.be( 1 );
				pelletIndices[0].should.be( 0 );
			});

			final startIndex = 0;
			
			it( "test pellet with distance 1", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"  #"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				
				final destinations = [ 0 => 0.0, 1 => 0.0 ];
				
				final pelletTargets:Array<PelletTarget> = [
					{ index: 1, path: grid.getPath( 0, 1 ), type: Food, priority: 1 }
				];
				
				final pelletManager = new PelletManager( 0, grid );
				final destinationPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				destinationPriorities[0].should.be( 0 );
				destinationPriorities[1].should.be( 1 );

			});

			it( "test pellet with distances 1, 2", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"   #"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				
				final destinations = [ 0 => 0.0, 1 => 0.0 ];
				
				final pelletTargets:Array<PelletTarget> = [
					{ index: 1, path: grid.getPath( 0, 1 ), type: Food, priority: 1 },
					{ index: 2, path: grid.getPath( 0, 2 ), type: Food, priority: 0.5 }
				];
				
				final pelletManager = new PelletManager( 0, grid );
				final destinationPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				destinationPriorities[0].should.be( 0 );
				destinationPriorities[1].should.be( 1.5 );
			});
			
			it( "test pellet row", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					" ··#"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, GetFloorLines.get( lines ));
				
				final destinations = [ 0 => 0.0, 1 => 0.0 ];
				final pelletManager = new PelletManager( 0, grid );
				
				final pelletTargets = navigator.createPelletTargets( startIndex, GetPelletIndices.get( lines, "·" ), Food, 1 );
				
				final destinationPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				destinationPriorities[0].should.be( 0 );
				destinationPriorities[1].should.be( 1.5 );
			});
			
			it( "test pellet rows", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"·· ··#"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, GetFloorLines.get( lines ));
				
				final destinations = [ 1 => 0.0, 2 => 0.0, 3 => 0.0 ];
				final pelletManager = new PelletManager( 0, grid );
				
				final pelletTargets = navigator.createPelletTargets( 2, GetPelletIndices.get( lines, "·" ), Food, 1 );
				
				final destinationPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				destinationPriorities[1].should.be( 1.5 );
				destinationPriorities[2].should.be( 0 );
				destinationPriorities[3].should.be( 1.5 );
			});
			
			it( "test pellet rows", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"·· ··#"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, GetFloorLines.get( lines ));
				
				final destinations = [ 1 => 0.0, 2 => 0.0, 3 => 0.0 ];
				final pelletManager = new PelletManager( 0, grid );
				
				final pelletTargets = navigator.createPelletTargets( 2, GetPelletIndices.get( lines, "·" ), Food, 1 );
				
				final destinationPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				destinationPriorities[1].should.be( 1.5 );
				destinationPriorities[2].should.be( 0 );
				destinationPriorities[3].should.be( 1.5 );
			});

		});
	}

	
	
	
}
