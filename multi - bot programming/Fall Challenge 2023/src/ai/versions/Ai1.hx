package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import ai.data.Creature;
import ai.data.CreatureDataset;
import ai.data.Drone;
import ai.data.DroneScan;
import ai.data.RadarBlip;

using Lambda;

// go to closest creature

class Ai1 implements IAi {
	public var aiId = "Ai1";
	
	var creaturesMap:Map<Int, Creature>;
	var creatures:Array<Creature>;
	var myDrones:Array<Drone>;
	
	public function new() { }
	
	public function setGlobalInputs( creaturesMap:Map<Int, Creature>, creatures:Array<Creature> ) {
		this.creaturesMap = creaturesMap;
		this.creatures = creatures;
	}
	
	public function setInputs(
		myScore:Int,
		foeScore:Int,
		myScannedCreatureIds:Array<Int>,
		foeIds:Array<Int>,
		myDrones:Array<Drone>,
		foeDrones:Array<Drone>,
		droneScans:Array<DroneScan>,
		visibleCreatureDatasets:Array<CreatureDataset>,
		radarBlips:Array<RadarBlip>
	) {
		this.myDrones = myDrones;
		
		for( id in myScannedCreatureIds ) creaturesMap[id].isScannedByMe = true;

		for( creatureDataset in visibleCreatureDatasets ) {
			final creature = creaturesMap[creatureDataset.id];
			// printErr( 'creatureId ${creatureDataset.id}  creature $creature' );
			creature.pos.x = creatureDataset.x;
			creature.pos.y = creatureDataset.y;
			creature.vel.x = creatureDataset.vx;
			creature.vel.y = creatureDataset.vy;
		}
	}

	public function init() { }

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		final actions = [];
		for( myDrone in myDrones ) {
			final unscannedCreatures = creatures.filter( creature -> !creature.isScannedByMe );
			if( unscannedCreatures.length > 0 ) {
				unscannedCreatures.sort(( a, b ) -> {
					final distA = myDrone.pos.distanceSq( a.pos );
					final distB = myDrone.pos.distanceSq( b.pos );
					if( distA < distB ) return -1;
					if( distA > distB ) return 1;
					return 0;
				});
				final closestCreature = unscannedCreatures[0];
				actions.push( 'MOVE ${closestCreature.pos.x} ${closestCreature.pos.y} 1' );
	
			} else {
				actions.push( 'WAIT 0' );
			}
		}

		return actions.join( ";" );
	}
}
