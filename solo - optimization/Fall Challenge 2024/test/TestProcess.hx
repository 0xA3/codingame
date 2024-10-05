package test;

import CodinGame.printErr;
import ProgramInput;
import Std.parseInt;
import ai.Ai1;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	////////////////////////////////////////////////////////////////////////////
	// readline helper
	////////////////////////////////////////////////////////////////////////////
	static var lineCounter = 0;
	static var inputLines:Array<String>;
	static function initReadline( input:String ) {
		lineCounter = 0;
		inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
	}
	static function readline() return inputLines[lineCounter++];
	////////////////////////////////////////////////////////////////////////////

	public function new() {

		describe( "Test process", {
			it( "Example 1", {
				final ai = new Ai1();
				ai.setInput( example1 );
				ai.process().should.be( "TUBE 0 1;TUBE 0 2" );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );

		final resources = parseInt( readline() );
		final numTravelRoutes = parseInt( readline() );
		final travelRoutes:Array<TravelRoute> = [for( i in 0...numTravelRoutes ) Main.parseTravelRoute( readline() )];
		final numPods = parseInt( readline() );
		final podPropertiesLines = [];
		final podPropertiesDatasets = [for( i in 0...numPods ) {
			final podProperties = readline();
			podPropertiesLines.push( podProperties );
			Main.parsePodProperties( podProperties );
		}];
		
		final numNewBuildings = parseInt( readline());
		final newBuildingPropertiesLines = [];
		final buildings = [for( i in 0...numNewBuildings ) {
			final newBuildingProperties = readline();
			newBuildingPropertiesLines.push( newBuildingProperties );
			Main.parseBuildingProperties( newBuildingProperties );
		}];
	
		final programInput:ProgramInput = {
			resources: resources,
			travelRoutes: travelRoutes,
			podPropertiesDatasets: podPropertiesDatasets,
			buildings: buildings
		};
		
		printErr( 'resources: $resources' );
		printErr( 'numTravelRoutes: $numTravelRoutes' );
		printErr( 'travelRoutes: $travelRoutes' );
		printErr( 'numPods: $numPods' );
		printErr( 'podProperties:\n${podPropertiesLines.join( "\n" )}' );
		printErr( 'numNewBuildings: $numNewBuildings' );
		printErr( 'newBuildingProperties:\n${newBuildingPropertiesLines.join( "\n" )}' );
			
		return programInput;
	}

	final example1 = parseInput(
		"2000
		0
		0
		3
		0 0 80 60 30 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
		1 1 40 30
		2 2 120 30"
	);
}
