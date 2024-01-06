package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import ai.data.Constants.DRONE_HIT_RANGE;
import ai.data.Constants.LIGHT_SCAN_RADIUS;
import ai.data.Constants.MAX_POS;
import ai.data.Constants.MONSTER_EAT_RANGE;
import ai.data.Creature;
import ai.data.CreatureDataset;
import ai.data.Drone;
import ai.data.DroneScan;
import ai.data.RadarBlip;
import xa3.Math.max;
import xa3.Math.min;

using Lambda;

// go to closest creature
// evade monsters

class Ai2 implements IAi {
	
	public var aiId = "Ai2";
	
	final scannedCreatures:Map<Int, Bool> = [];
	final escapedCreatures:Map<Int, Bool> = [];
	
	var myDrones:Array<Drone>;
	var myDronesMap:Map<Int, Drone> = [];
	var creatures:Array<Creature>;
	var creaturesMap:Map<Int, Creature> = [];
	
	var monstersMap:Map<Int, Creature> = [];

	var visibleCreatureDatasets:Map<Int, CreatureDataset>;
	var visibleMonsterIds:Array<Int> = [];
	var radarBlips:Array<RadarBlip>;
	
	var turn = 0;
	
	public function new() { }
	
	public function setGlobalInputs( creatures:Array<Creature> ) {
		this.creatures = creatures;
		for( creature in creatures ) {
			if( creature.type == -1 ) monstersMap.set( creature.id, creature );
			creaturesMap.set( creature.id, creature );
		}

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
		
		visibleMonsterIds.splice( 0, visibleMonsterIds.length );
		for( creature in creatures ) if( creature.type == -1 ) visibleMonsterIds.push( creature.id );
	}
	
	function setScannedCreatures( myDrone:Drone ) {
		final lightDist = myDrone.light == 0 ? 800 : 2000;
		for( creature in visibleCreatureDatasets ) {
			if( scannedCreatures[creature.id] ) continue;

			final dist = myDrone.pos.distance( creature.pos );
			if( dist < lightDist ) {
				scannedCreatures.set( creature.id, true );
				printErr( 'drone ${myDrone.id} scanned creature ${creature.id}' );
			}
		}
	}

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		// if( turn == 0 ) printErr( 'myScore $myScore\nfoeScore: $foeScore\nmyScannedCreatureIds $myScannedCreatureIds\nfoeIds $foeIds\nmyDrones $myDrones\nfoeDrones $foeDrones\ndroneScans $droneScans\nvisibleCreatureDatasets $visibleCreatureDatasets\nradarBlips $radarBlips' );
		for( creature in creatures ) {
			if( visibleCreatureDatasets.exists( creature.id )) {
				final visibleCreature = visibleCreatureDatasets[creature.id];
				creature.updatePosition( visibleCreature.pos.x, visibleCreature.pos.y );
			} else {
				creature.increaseRanges();
			}
		}
		for( creatureDataset in visibleCreatureDatasets ) if( monstersMap.exists( creatureDataset.id )) printErr( monstersMap[creatureDataset.id] );

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
				final distancSq = myDrone.pos.distanceSq( creature.pos );
				droneCreatureDistances.push({ drone: myDrone, creature: creature, distance: distancSq });
				// printErr( 'drone ${myDrone.id} - creature ${creature.id} dist $distancSq' );
			}
		}
		droneCreatureDistances.sort(( a, b ) -> {
			if( a.distance < b.distance ) return -1;
			if( a.distance > b.distance ) return 1;
			return 0;
		});

		var assignedDronesNum = 0;
		var prevTargetId = -1;
		for( droneCreatureDistance in droneCreatureDistances ) {
			final drone = droneCreatureDistance.drone;
			final creature = droneCreatureDistance.creature;
			if( drone.targetId == -1 && creature.id != prevTargetId ) {
				drone.targetId = creature.id;
				prevTargetId = creature.id;
				assignedDronesNum++;
				printErr( 'move drone ${drone.id} to creature ${creature.id} in ${creature.minX}:${creature.minY} - ${creature.maxX}:${creature.maxY}' );
			}
			if( assignedDronesNum == myDrones.length ) break;
		}
	}

	function doSearch( myDrone:Drone ) {
		final targetCreature = creaturesMap[myDrone.targetId];
		final distanceToCenter = myDrone.pos.distance( targetCreature.pos );
		if( distanceToCenter < LIGHT_SCAN_RADIUS && myDrone.cooldownCounter > Drone.MIN_LIGHT_COOLDOWN_DURATION ) {
			myDrone.light = 1;
			myDrone.resetLightCooldown();
		} else {
			myDrone.light = 0;
		}
		
		final targetX = max( LIGHT_SCAN_RADIUS, min( MAX_POS - LIGHT_SCAN_RADIUS, targetCreature.pos.x ));

		return 'MOVE ${targetX} ${targetCreature.pos.y} ${myDrone.light}';
	}

	function doSave( myDrone:Drone) {
		if( myDrone.pos.y < 500 + 600 ) myDrone.state = Search;
		return 'MOVE ${myDrone.pos.x} 0 0';
	}

	function getCollision( dronePos:Vec2, droneVel:Vec2, monsterPos:Vec2, monsterVel:Vec2 ) {
		// Check instant collision
		if( monsterPos.inRange( drone.pos, DRONE_HIT_RANGE + MONSTER_EAT_RANGE )) {
			return true;
		}

		// Both units are motionless
		if( droneVel.isZero() && monsterVel.isZero() ) return false;

		final x = monsterPos.x;
		final y = monsterPos.y;
		final ux = dronePos.x;
		final uy = dronePos.y;

		final x2 = x - ux;
		final y2 = y - uy;
		final r2 = DRONE_HIT_RANGE + MONSTER_EAT_RANGE;
		final vx2 = monsterVel.x - droneVel.x;
		final vy2 = monsterVel.y - droneVel.y;

        // Resolving: sqrt((x + t*vx)^2 + (y + t*vy)^2) = radius <=> t^2*(vx^2 + vy^2) + t*2*(x*vx + y*vy) + x^2 + y^2 - radius^2 = 0
        // at^2 + bt + c = 0;
        // a = vx^2 + vy^2
        // b = 2*(x*vx + y*vy)
        // c = x^2 + y^2 - radius^2

		final a = vx2 * vx2 + vy2 * vy2;

		if( a < 0 ) return false;

		final b = 2.0 * ( x2 * vx2 + y2 * vy2 );
		final c = x2 * x2 + y2 * y2 - r2 * r2;
		final delta = b * b - 4.0 * a * c;

		if( delta < 0 ) return false;

		final t = ( -b - Math.sqrt( delta )) / ( 2.0 * a );

		if( t <= 0 || t > 1 ) return false;

		return true;
	}
}
