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

	static final inputLines:Array<String> = [];

	static function main() {
		
		final ai = CurrentAis.aiMe;
		final creatureCount = parseInt( readline() );
		final creatures = [for( _ in 0...creatureCount ) {
			final inputs = readline().split(' ');
			final creature:Creature = { id: parseInt( inputs[0] ), color:  parseInt( inputs[1] ), type: parseInt( inputs[2] ) }
			creature;
		}];
				
		ai.setGlobalInputs( creatures );
		
		// game loop
		while( true ) {
			final myScore = parseInt( readline() );
			final foeScore = parseInt( readline() );
			final myScanCount = parseInt( readline() );
			final myScannedCreatureIds = [for( _ in 0...myScanCount ) parseInt( readline() )];

			final foeScanCount = parseInt( readline() );
			final foeIds = [for( _ in 0...foeScanCount ) parseInt( readline() )];

			final myDroneCount = parseInt( readline() );
			final myDrones = [for( _ in 0...myDroneCount ) {
				var inputs = readline().split(' ');
				final drone:Drone = {
					id: parseInt( inputs[0] ),
					pos: { x: parseInt( inputs[1] ), y: parseInt( inputs[2] )},
					emergency: parseInt( inputs[3] ),
					battery: parseInt( inputs[4] )
				}
				drone;
			}];
			
			final foeDroneCount = parseInt( readline() );
			final foeDrones = [for( _ in 0...foeDroneCount ) {
				var inputs = readline().split(' ');
				final drone:Drone = {
					id: parseInt( inputs[0] ),
					pos: { x: parseInt( inputs[1] ), y: parseInt( inputs[2] )},
					emergency: parseInt( inputs[3] ),
					battery: parseInt( inputs[4] )
				}
				drone;
			}];

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
			final visibleCreatureDatasets = [for( i in 0...visibleCreatureCount ) {
				var inputs = readline().split(' ');
				final creatureDataset:CreatureDataset = {
					id: parseInt( inputs[0] ),
					x: parseInt( inputs[1] ),
					y: parseInt( inputs[2] ),
					vx: parseInt( inputs[3] ),
					vy: parseInt( inputs[4] )
				}
				creatureDataset;
			}];
			
			final radarBlipCount = parseInt( readline() );
			final radarBlips = [for( _ in 0...radarBlipCount ) {
				var inputs = readline().split(' ');
				final radarBlip:RadarBlip = {
					droneId: parseInt( inputs[0] ),
					creatureId: parseInt( inputs[1] ),
					radar: inputs[2]
				}
				radarBlip;
			}];
			
			ai.setInputs(
				myScore,
				foeScore,
				myScannedCreatureIds,
				foeIds,
				myDrones,
				foeDrones,
				droneScans,
				visibleCreatureDatasets,
				radarBlips
			);

			final outputs = ai.process();
			print( outputs );
		}
	}
}