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
	var myDronesMap:Map<Int, Drone> = [];
	final visibleCreatures:Array<Creature> = [];

	var turn = 0;

	public function new() { }
	
	public function setGlobalInputs( creaturesMap:Map<Int, Creature>, creatures:Array<Creature> ) {
		this.creaturesMap = creaturesMap;
		this.creatures = creatures;
		// printErr( 'creatures $creatures' );
		turn = 0;
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
		for( inputDrone in myDrones ) {
			if( !myDronesMap.exists( inputDrone.id )) {
				myDronesMap.set( inputDrone.id, inputDrone );
			} else {
				final myDrone = myDronesMap[inputDrone.id];
				myDrone.pos.x = inputDrone.pos.x;
				myDrone.pos.y = inputDrone.pos.y;
				myDrone.emergency = inputDrone.emergency;
				myDrone.battery = inputDrone.emergency;
			}
		}
		
		// if( turn == 0 ) printErr( 'myScore $myScore\nfoeScore: $foeScore\nmyScannedCreatureIds $myScannedCreatureIds\nfoeIds $foeIds\nmyDrones $myDrones\nfoeDrones $foeDrones\ndroneScans $droneScans\nvisibleCreatureDatasets $visibleCreatureDatasets\nradarBlips $radarBlips' );

		// printErr( 'myScannedCreatureIds $myScannedCreatureIds' );
		for( id in myScannedCreatureIds ) creaturesMap[id].isScannedByMe = true;

		visibleCreatures.splice( 0, visibleCreatures.length );
		for( creatureDataset in visibleCreatureDatasets ) {
			final creature = creaturesMap[creatureDataset.id];
			// printErr( 'creatureId ${creatureDataset.id}  creature $creature' );
			creature.pos.x = creatureDataset.x;
			creature.pos.y = creatureDataset.y;
			creature.vel.x = creatureDataset.vx;
			creature.vel.y = creatureDataset.vy;

			visibleCreatures.push( creature );
		}
	}

	public function init() { }

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		final actions = [];
		for( myDrone in myDronesMap ) {
			// printErr( 'drone ${myDrone.id} state ${myDrone.state}' );
			switch myDrone.state {
				case Search: actions.push( doSearch( myDrone ));
				case Save: actions.push( doSave( myDrone ));
			}
		}

		turn++;

		return actions.join( ";" );
	}

	function doSearch( myDrone:Drone ) {
		final lightDist = myDrone.light == 0 ? 800 : 2000;
		// printErr( 'visibleCreatures ' + visibleCreatures.map( c -> c.id ));
		final unscannedCreatures = visibleCreatures.filter( creature -> !creature.isScannedByMe );
		
		final nextLight = turn % 3 == 0 ? 1 : 0;
		if( unscannedCreatures.length > 0 ) {
			unscannedCreatures.sort(( a, b ) -> {
				final distA = myDrone.pos.distanceSq( a.pos );
				final distB = myDrone.pos.distanceSq( b.pos );
				if( distA < distB ) return -1;
				if( distA > distB ) return 1;
				return 0;
			});
			final closestCreature = unscannedCreatures[0];
			final dist = myDrone.pos.distance( closestCreature.pos );
			// printErr( 'closest creature ${closestCreature.id} dist $dist  light ${myDrone.light}' );
			if( dist < lightDist ) {
				myDrone.state = Save;
				// printErr( 'scanned closestCreature ${closestCreature.id}' );
			}
			myDrone.light = nextLight;
			return 'MOVE ${closestCreature.pos.x} ${closestCreature.pos.y} $nextLight';
		} else {
			myDrone.light = nextLight;
			return 'WAIT $nextLight';
		}
	}



	function doSave( myDrone:Drone) {
		if( myDrone.pos.y < 500 + 600 ) myDrone.state = Search;
		return 'MOVE ${myDrone.pos.x} 0 0';
	}
}
