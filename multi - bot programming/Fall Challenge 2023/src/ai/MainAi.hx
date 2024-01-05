package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.CurrentAis;
import ai.data.Creature;
import ai.data.CreatureDataset;
import ai.data.Drone;
import ai.data.DroneScan;
import ai.data.RadarBlip;

class MainAi {
	static final dronesNum = 2;

	static final inputLines:Array<String> = [];

	static function main() {
		var visibleCreatureDatasets:Array<CreatureDataset> = [];
		var radarBlips:Array<RadarBlip> = [];

		final ai = CurrentAis.aiMe;
		final creatureCount = parseInt( readline() );
		final creatures = [for( _ in 0...creatureCount ) {
			final inputs = readline().split(' ');
			final id = parseInt( inputs[0] );
			final creature:Creature = { id: id, color:  parseInt( inputs[1] ), type: parseInt( inputs[2] ) }
			creature;
		}];

		final myDrones = [for( _ in 0...dronesNum ) new Drone()];
		final foeDrones = [for( _ in 0...dronesNum ) new Drone()];
		
		ai.setGlobalInputs( myDrones, creatures, visibleCreatureDatasets, radarBlips );
		
		// game loop
		while( true ) {
			final myScore = parseInt( readline() );
			final foeScore = parseInt( readline() );
			final myScanCount = parseInt( readline() );
			final myScannedCreatureIds = [for( _ in 0...myScanCount ) parseInt( readline() )];

			final foeScanCount = parseInt( readline() );
			final foeIds = [for( _ in 0...foeScanCount ) parseInt( readline() )];

			final myDroneCount = parseInt( readline() );
			for( i in 0...myDroneCount ) {
				var inputs = readline().split(' ');
				final currentDrone = myDrones[i];
				currentDrone.id = parseInt( inputs[0] );
				currentDrone.pos.x = parseInt( inputs[1] );
				currentDrone.pos.y = parseInt( inputs[2] );
				currentDrone.emergency = parseInt( inputs[3] );
				currentDrone.battery = parseInt( inputs[4] );
			}

			final foeDroneCount = parseInt( readline() );
			for( i in 0...foeDroneCount ) {
				var inputs = readline().split(' ');
				final currentDrone = foeDrones[i];
				currentDrone.id = parseInt( inputs[0] );
				currentDrone.pos.x = parseInt( inputs[1] );
				currentDrone.pos.y = parseInt( inputs[2] );
				currentDrone.emergency = parseInt( inputs[3] );
				currentDrone.battery = parseInt( inputs[4] );
			}

			final droneScanCount = parseInt( readline() );
			final droneScans = [for( _ in 0...droneScanCount ) {
				var inputs = readline().split(' ');
				final droneScan:DroneScan = {
					droneId: parseInt( inputs[0] ),
					creatureId: parseInt( inputs[1] )
				}
				droneScan;
			}];

			final visibleCreatureCount = parseInt( readline() );
			visibleCreatureDatasets.splice( 0, visibleCreatureDatasets.length );
			for( i in 0...visibleCreatureCount ) {
				var inputs = readline().split(' ');
				final creatureDataset:CreatureDataset = {
					id: parseInt( inputs[0] ),
					pos: { x: parseInt( inputs[1] ), y: parseInt( inputs[2] )},
					vel: { x: parseInt( inputs[3] ), y: parseInt( inputs[4] )},
				}
				visibleCreatureDatasets.push( creatureDataset );
			};
			
			final radarBlipCount = parseInt( readline() );
			radarBlips.splice( 0, radarBlips.length );
			for( _ in 0...radarBlipCount ) {
				var inputs = readline().split(' ');
				final radarBlip:RadarBlip = {
					droneId: parseInt( inputs[0] ),
					creatureId: parseInt( inputs[1] ),
					radar: inputs[2]
				}
				radarBlips.push( radarBlip );
			};
			
			ai.setInputs(
				myScore,
				foeScore,
				myScannedCreatureIds,
				foeIds,
				foeDrones,
				droneScans
			);

			final outputs = ai.process();
			print( outputs );
		}
	}
}