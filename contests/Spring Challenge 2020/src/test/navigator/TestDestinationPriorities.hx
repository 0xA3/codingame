package test.navigator;

import PelletManager.PelletTarget;
import test.GetFloorLines;
import test.GetPelletIndices;

using buddy.Should;

class TestDestinationPriorities extends buddy.BuddySuite {
	
	public function new() {

		describe( "TestDestinationPriorities", {
			@include
			it( "test pellet priority", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"##########",
					"    ·   o#",
					"##########"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, GetFloorLines.get( lines ));
				
				final startIndex = grid.getCellIndex( 0, 1 );
				final destinationIndices = grid.getPossibleDestinations( grid.getCellX( startIndex ), grid.getCellY( startIndex ));
				final pelletManager = new PelletManager( 0, grid );
				
				final destinations:Map<Int, Float> = [];
				for( i in destinationIndices ) destinations.set( i, 0 );
				
				final superpelletTargets = navigator.createPelletTargets( startIndex, GetPelletIndices.get( lines, "o" ), Superfood, 9 );
				final superpelletPriorities = navigator.getDestinationPriorities( destinations, superpelletTargets );
				trace( [for( index => priority in superpelletPriorities) ( 'index $index ${grid.sxy( index)} superpriority $priority' )] );
				
				final pelletTargets = navigator.createPelletTargets( startIndex, GetPelletIndices.get( lines, "·" ), Food, 1 );
				final pelletPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );
				trace( [for( index => priority in pelletPriorities) ( 'index $index ${grid.sxy( index)} priority $priority' )] );

			});

			it( "test pellet rows", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"######",
					"·# ··#",
					"···#o#",
					"######"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, GetFloorLines.get( lines ));
				
				final startIndex = grid.getCellIndex( 2, 1 );
				final destinationIndices = grid.getPossibleDestinations( grid.getCellX( startIndex ), grid.getCellY( startIndex ));
				final pelletManager = new PelletManager( 0, grid );
				
				final superpelletTargets = navigator.createPelletTargets( startIndex, GetPelletIndices.get( lines, "o" ), Superfood, 9 );
				final pelletTargets = navigator.createPelletTargets( startIndex, GetPelletIndices.get( lines, "·" ), Food, 1 );
				
				final destinations:Map<Int, Float> = [];
				for( i in destinationIndices ) destinations.set( i, 0 );
				
				final superpelletPriorities = navigator.getDestinationPriorities( destinations, superpelletTargets );
				final pelletPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				trace( [for( index => priority in superpelletPriorities) ( 'index $index ${grid.sxy( index)} priority $priority' )] );
				trace( [for( index => priority in pelletPriorities) ( 'index $index ${grid.sxy( index)} priority $priority' )] );

			});

		});
	}

	
	
	
}
