package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import ai.data.Constants.BL;
import ai.data.Constants.BR;
import ai.data.Constants.LIGHT_SCAN_RADIUS;
import ai.data.Constants.MAX_POS;
import ai.data.Constants.TL;
import ai.data.Constants.TR;
import ai.data.Creature;
import ai.data.CreatureDataset;
import ai.data.Drone;
import ai.data.DroneScan;
import ai.data.RadarBlip;
import xa3.Math.max;
import xa3.Math.min;

using Lambda;

// go to closest creature

class Ai1 implements IAi {
	
	public var aiId = "Ai1";
	
	final scannedCreatures:Map<Int, Bool> = [];
	final escapedCreatures:Map<Int, Bool> = [];
	
	var myDrones:Array<Drone>;
	var myDronesMap:Map<Int, Drone> = [];
	var creatures:Array<Creature>;
	var creaturesMap:Map<Int, Creature> = [];
	
	var visibleCreatureDatasets:Map<Int, CreatureDataset>;
	var radarBlips:Array<RadarBlip>;
	
	var turn = 0;
	
	public function new() { }
	
	public function setGlobalInputs( creatures:Array<Creature> ) {
		this.creatures = creatures;
		for( creature in creatures ) creaturesMap.set( creature.id, creature );
		creatures.sort(( a, b ) -> {
			if( a.type < b.type ) return -1;
			if( a.type > b.type ) return 1;
			return 0;
		});

		// final creatureOutputs = [for( creature in creatures ) creature.toString()].join( "\n" );
		// printErr( 'creatures $creatureOutputs' );
		for( creature in creatures ) {
			scannedCreatures.set( creature.id, false );
			escapedCreatures.set( creature.id, false );
		}
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
		visibleCreatureDatasets:Map<Int, CreatureDataset>,
		radarBlips:Array<RadarBlip>
	) {
		this.myDrones = myDrones;
		if( turn == 0 ) {
			for( myDrone in myDrones ) myDronesMap.set( myDrone.id, myDrone );
		}
		this.visibleCreatureDatasets = visibleCreatureDatasets;
		this.radarBlips = radarBlips;

		for( id in escapedCreatures.keys()) escapedCreatures.set( id, true );
		for( radarBlip in radarBlips ) escapedCreatures.set( radarBlip.creatureId, false );
		for( myDrone in myDrones ) {
			setScannedCreatures( myDrone );
			myDrone.updateLightCooldown();
		}
	}
	
	function setScannedCreatures( myDrone:Drone ) {
		final lightDist = myDrone.light == 0 ? 800 : 2000;
		for( creature in visibleCreatureDatasets ) {
			final dist = myDrone.pos.distance( creature.pos );
			if( dist < lightDist ) {
				scannedCreatures.set( creature.id, true );
				// printErr( 'drone ${myDrone.id} scanned creature ${creature.id}' );
			}
		}
	}

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		// if( turn == 0 ) printErr( 'myScore $myScore\nfoeScore: $foeScore\nmyScannedCreatureIds $myScannedCreatureIds\nfoeIds $foeIds\nmyDrones $myDrones\nfoeDrones $foeDrones\ndroneScans $droneScans\nvisibleCreatureDatasets $visibleCreatureDatasets\nradarBlips $radarBlips' );
		for( creature in creatures ) creature.increaseRanges();
		curtailCreaturePositions();
		findTargetCreatures();

		final actions = [];
		for( i in 0...myDrones.length ) {
			final myDrone = myDrones[i];
			if( myDrone.targetId == -1 ) myDrone.state = Save;
			// printErr( 'drone ${myDrone.id} state ${myDrone.state}' );
			switch myDrone.state {
				case Search: actions.push( doSearch( myDrone ));
				case Save: actions.push( doSave( myDrone ));
			}
		}

		turn++;

		return actions.join( "\n" );
	}

	function curtailCreaturePositions() {
		// for( radarBlip in radarBlips ) printErr( radarBlip );
		for( radarBlip in radarBlips ) {
			final drone = myDronesMap[radarBlip.droneId];
			final creature = creaturesMap[radarBlip.creatureId];
			creature.curtailPossiblePositions( drone.pos.x, drone.pos.y, radarBlip.radar );
			// if( radarBlip.creatureId == 6 ) printErr( 'radarBlip of drone ${drone.id} for creature 6 ${radarBlip.radar}' );
		}
	}

	function findTargetCreatures() {
		final droneCreatureDistances = [];
		for( myDrone in myDrones ) {
			myDrone.resetTarget();
			
			for( creature in creatures ) {
				if( creature.type == -1 || escapedCreatures[creature.id] || scannedCreatures[creature.id] ) continue;
				final distancSq = myDrone.pos.distanceSqXY( creature.centerX, creature.centerY );
				droneCreatureDistances.push({ drone: myDrone, creature: creature, distance: distancSq });
				// printErr( 'drone ${myDrone.id} - creature ${creature.id} dist $distancSq' );
			}
		}
		droneCreatureDistances.sort(( a, b ) -> a.distance - b.distance );

		var assignedDronesNum = 0;
		var prevTargetId = -1;
		for( droneCreatureDistance in droneCreatureDistances ) {
			final drone = droneCreatureDistance.drone;
			final creature = droneCreatureDistance.creature;
			if( drone.targetId == -1 && creature.id != prevTargetId ) {
				drone.targetId = creature.id;
				prevTargetId = creature.id;
				assignedDronesNum++;
				// printErr( 'move drone ${drone.id} to creature ${creature.id} in ${creature.minX}:${creature.minY} - ${creature.maxX}:${creature.maxY}' );
			}
			if( assignedDronesNum == myDrones.length ) break;
		}
	}

	function doSearch( myDrone:Drone ) {
		final targetCreature = creaturesMap[myDrone.targetId];
		final distanceToCenter = myDrone.pos.distanceXY( targetCreature.centerX, targetCreature.centerY );
		if( distanceToCenter < LIGHT_SCAN_RADIUS && myDrone.cooldownCounter > Drone.MIN_LIGHT_COOLDOWN_DURATION ) {
			myDrone.light = 1;
			myDrone.resetLightCooldown();
		} else {
			myDrone.light = 0;
		}
		// final nextLight = turn % 3 == 0 ? 1 : 0;
		// myDrone.light = nextLight;
		

		// if( myDrone.pos.x < 2100 && targetCreature.centerX < myDrone.pos.x ) return 'WAIT $nextLight';
		// if( myDrone.pos.x > 10000 - 2100 && targetCreature.centerX > myDrone.pos.x ) return 'WAIT $nextLight';
		final targetX = max( LIGHT_SCAN_RADIUS, min( MAX_POS - LIGHT_SCAN_RADIUS, targetCreature.centerX ));

		return 'MOVE ${targetX} ${targetCreature.centerY} ${myDrone.light}';
	}

	function doSave( myDrone:Drone) {
		if( myDrone.pos.y < 500 + 600 ) myDrone.state = Search;
		return 'MOVE ${myDrone.pos.x} 0 0';
	}
}
