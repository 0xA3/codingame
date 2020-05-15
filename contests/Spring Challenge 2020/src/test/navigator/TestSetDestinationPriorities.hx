package test.navigator;

import Navigator.PelletTarget;

using buddy.Should;

class TestSetDestinationPriorities extends buddy.BuddySuite {
	
	public function new() {

		describe( "TestSetDestinationPriorities", {

			it( "test getFloorLines", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"a"
				];
				final floorLines = getFloorLines( lines );
				floorLines.length.should.be( 1 );
				floorLines[0].should.be(" ");
			});
			
			it( "test getPelletIndices", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"·"
				];
				final pelletIndices = getPelletIndices( lines, "·" );
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
				
				final navigator = new Navigator( 0, grid );
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
				
				final navigator = new Navigator( 0, grid );
				final destinationPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				destinationPriorities[0].should.be( 0 );
				destinationPriorities[1].should.be( 1.5 );
			});
			
			it( "test pellet row", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					" ··#"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, getFloorLines( lines ));
				
				final destinations = [ 0 => 0.0, 1 => 0.0 ];
				final navigator = new Navigator( 0, grid );
				
				final pelletTargets = navigator.createPelletTargets( startIndex, getPelletIndices( lines, "·" ), Food, 1 );
				
				final destinationPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				destinationPriorities[0].should.be( 0 );
				destinationPriorities[1].should.be( 1.5 );
			});
			
			it( "test pellet rows", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = [
					"·· ··#"
				];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, getFloorLines( lines ));
				
				final destinations = [ 1 => 0.0, 2 => 0.0, 3 => 0.0 ];
				final navigator = new Navigator( 0, grid );
				
				final pelletTargets = navigator.createPelletTargets( 2, getPelletIndices( lines, "·" ), Food, 1 );
				
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
				final grid = GridFactory.createGrid( lines[0].length, lines.length, getFloorLines( lines ));
				
				final destinations = [ 1 => 0.0, 2 => 0.0, 3 => 0.0 ];
				final navigator = new Navigator( 0, grid );
				
				final pelletTargets = navigator.createPelletTargets( 2, getPelletIndices( lines, "·" ), Food, 1 );
				
				final destinationPriorities = navigator.getDestinationPriorities( destinations, pelletTargets );

				destinationPriorities[1].should.be( 1.5 );
				destinationPriorities[2].should.be( 0 );
				destinationPriorities[3].should.be( 1.5 );
			});
			

		});
	}

	
	
	
	public function getFloorLines( lines:Array<String> ) {
		final floorLines = lines.map( line -> line.split("").map( s -> s == "#" ? "#" : " " ).join("") );
		return floorLines;
	}

	public function getPelletIndices( lines:Array<String>, pelletChar:String ) {
		final width = lines.length > 0 ? lines[0].length : throw "Error: empty array";
		final a = lines.map( line -> line.split(""));
		
		final indices:Array<Int> = [];
		for( y in 0...a.length ) {
			final line = a[y];
			if( line.length != width ) throw 'Error: line $y length should be $width but is ${line.length}';
			for( x in 0...line.length ) {
				if( line[x] == "·" ) indices.push( y * width + x );
			}
		}
		return indices;
	}
}
