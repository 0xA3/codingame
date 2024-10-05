import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import ProgramInput;
import Std.parseInt;
import ai.Ai1;
import data.Building;
import data.Point;

class Main {

	final ai = new Ai1();
	
	static function main() { new Main(); }

	function new() {
		while( true ) {
			final programInput = getProgramInput();
			ai.setInput( programInput );
			final result = ai.process();

			print( result );
		}
	}

	static inline function getProgramInput() {
		final resources = parseInt( readline() );
		final numTravelRoutes = parseInt( readline() );
		final travelRoutes:Array<TravelRoute> = [for( i in 0...numTravelRoutes ) parseTravelRoute( readline() )];
		final numPods = parseInt( readline() );
		final podPropertiesLines = [];
		final podPropertiesDatasets = [for( i in 0...numPods ) {
			final podProperties = readline();
			podPropertiesLines.push( podProperties );
			parsePodProperties( podProperties );
		}];
		
		final numNewBuildings = parseInt( readline());
		final newBuildingPropertiesLines = [];
		final buildings = [for( i in 0...numNewBuildings ) {
			final newBuildingProperties = readline();
			newBuildingPropertiesLines.push( newBuildingProperties );
			parseBuildingProperties( newBuildingProperties );
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

	static inline function parseTravelRoute( inputLine:String ) {
		final inputs = inputLine.split(' ');
		final buildingId1 = parseInt( inputs[0] );
		final buildingId2 = parseInt( inputs[1] );
		final capacity = parseInt( inputs[2] );

		final travelRoute:TravelRoute = { buildingId1: buildingId1, buildingId2: buildingId2, capacity: capacity }

		return travelRoute;
	}

	static inline function parsePodProperties( inputLine:String ) {
		final inputs = inputLine.split(' ');

		final podId = parseInt( inputs[0] );
		final numStops = parseInt( inputs[1] );
		final stops = [for( i in 0...numStops ) parseInt( inputs[2 + i] )];

		final podPropertiesDataset:PodPropertiesDataset = { podId: podId, stops: stops }

		return podPropertiesDataset;
	}

	static inline function parseBuildingProperties( inputLine:String ) {
		final inputs = inputLine.split(' ');

		final buildingType = parseInt( inputs[0] );
		final buildingId = parseInt( inputs[1] );
		final pos = new Point( parseInt( inputs[2] ), parseInt( inputs[3] ))
		;
		if( buildingType == 0 ) {
			final numAstronauts = parseInt( inputs[4] );
			final astronautTypes = [for( i in 0...numAstronauts ) parseInt( inputs[5 + i] )];
			
			final building = new Building( buildingType, buildingId, pos, astronautTypes );
			return building;
		} else {
			final building = new Building( buildingType, buildingId, pos, [] );
			return building;
		}
	}
}

