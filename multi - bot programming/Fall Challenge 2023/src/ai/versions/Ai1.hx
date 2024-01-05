package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import ai.data.Constants.BL;
import ai.data.Constants.BR;
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
	
	var visibleCreatureDatasets:Array<CreatureDataset>;
	var radarBlips:Array<RadarBlip>;
	
	var turn = 0;
	var nextCreatures = [-1, -1];

	public function new() { }
	
	public function setGlobalInputs( creatures:Array<Creature> ) {
		this.creatures = creatures;
		for( creature in creatures ) creaturesMap.set( creature.id, creature );
		creatures.sort(( a, b ) -> {
			if( a.type < b.type ) return -1;
			if( a.type > b.type ) return 1;
			return 0;
		});

		final creatureOutputs = [for( creature in creatures ) creature.toString()].join( "\n" );
		printErr( 'creatures $creatureOutputs' );
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
		visibleCreatureDatasets:Array<CreatureDataset>,
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
		// myDrones.sort(( a, b ) -> a.pos.x - b.pos.x );
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
			if( nextCreatures[i] == -1 ) myDrone.state = Save;
			// printErr( 'drone ${myDrone.id} state ${myDrone.state}' );
			switch myDrone.state {
				case Search: actions.push( doSearch( myDrone, nextCreatures[i] ));
				case Save: actions.push( doSave( myDrone ));
			}
		}

		turn++;

		return actions.join( "\n" );
	}

	function curtailCreaturePositions() {
		if( turn == 0 ) for( radarBlip in radarBlips ) printErr( radarBlip );
		for( radarBlip in radarBlips ) {
			final drone = myDronesMap[radarBlip.droneId];
			final creature = creaturesMap[radarBlip.creatureId];
			creature.curtailPossiblePositions( drone.pos.x, drone.pos.y, radarBlip.radar );
			if( creature.id == 5 ) printErr( 'creature $creature' );
		}
	}

	function findTargetCreatures() {
		nextCreatures[0] = -1;
		nextCreatures[1] = -1;
		var foundFirst = false;
		for( creature in creatures ) {
			if( creature.type == -1 || escapedCreatures[creature.id] ) continue;
			
			if( !scannedCreatures[creature.id] ) {
				if( !foundFirst ) {
					nextCreatures[0] = creature.id;
					foundFirst = true;
				} else {
					nextCreatures[1] = creature.id;
					break;
				}
			}
		}
		printErr( 'nextCreatures $nextCreatures' );
	}

	function doSearch( myDrone:Drone, nextCreature:Int ) {
		final lightDist = myDrone.light == 0 ? 800 : 2000;
		final nextLight = turn % 3 == 0 ? 1 : 0;
		myDrone.light = nextLight;
		
		final directionOfNext = radarBlips.filter( radarBlip -> radarBlip.creatureId == nextCreature );
		if( directionOfNext.length == 0 ) {
			myDrone.state = Save;
			doSave( myDrone );
		}
		
		final radarOfNext = directionOfNext[0].radar;

		if( myDrone.pos.x < 2100 && radarOfNext == BL ) return 'WAIT $nextLight';
		if( myDrone.pos.x > 10000 - 2100 && radarOfNext == BR ) return 'WAIT $nextLight';

		var dx = 0;
		var dy = 0;
		switch directionOfNext[0].radar {
			case TL:
				dx = -500;
				dy = -500;
			case TR:
				dx = 500;
				dy = -500;
			case BR:
				dx = 500;
				dy = 500;
			case BL:
				dx = -500;
				dy = 500;
			default:
		}
		
		if( visibleCreatureDatasets.length > 0 ) {
			visibleCreatureDatasets.sort(( a, b ) -> {
				final distA = myDrone.pos.distanceSq( a.pos );
				final distB = myDrone.pos.distanceSq( b.pos );
				if( distA < distB ) return -1;
				if( distA > distB ) return 1;
				return 0;
			});
			
			for( creature in visibleCreatureDatasets ) {
				final dist = myDrone.pos.distance( creature.pos );
				if( dist < lightDist ) {
					scannedCreatures.set( creature.id, true );
					// printErr( 'scanned creature ${creature.id}' );
				}
			}
		}

		return 'MOVE ${myDrone.pos.x + dx} ${myDrone.pos.y + dy} $nextLight';
	}

	function doSave( myDrone:Drone) {
		if( myDrone.pos.y < 500 + 600 ) myDrone.state = Search;
		return 'MOVE ${myDrone.pos.x} 0 0';
	}
}
