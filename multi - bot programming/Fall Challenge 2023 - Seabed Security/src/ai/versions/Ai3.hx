package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.parseInt;
import ai.IAi;
import ai.data.Constants.DRONE_HIT_RANGE;
import ai.data.Constants.DRONE_SPEED;
import ai.data.Constants.LIGHT_SCAN_RADIUS;
import ai.data.Constants.MAX_POS;
import ai.data.Constants.MONSTER_ADDITIONAL_DETACTABLE_RANGE;
import ai.data.Constants.MONSTER_EAT_RANGE;
import ai.data.Creature;
import ai.data.CreatureDataset;
import ai.data.Drone;
import ai.data.DroneScan;
import ai.data.RadarBlip;
import xa3.Math.max;
import xa3.Math.min;
import xa3.Vec2;

using Lambda;

// go to closest creature
// evade monsters

class Ai3 implements IAi {
	
	public var aiId = "Ai3";
	
	final escapedCreatures:Map<Int, Bool> = [];
	
	var myScore = 0;
	var foeScore = 0;
	var myScannedCreatureIds:Map<Int, Bool> = [];
	var myDrones:Array<Drone> = [];
	var myDronesMap:Map<Int, Drone> = [];
	var creatures:Array<Creature>;
	var creaturesMap:Map<Int, Creature> = [];
	
	var myDroneScans:Map<Int, Bool> = [];

	var monstersMap:Map<Int, Creature> = [];

	var visibleCreatureDatasets:Map<Int, CreatureDataset>;
	var visibleMonsters:Array<Creature> = [];
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
			escapedCreatures.set( creature.id, false );
		}
		turn = 0;
	}
	
	public function setInputs(
		myScore:Int,
		foeScore:Int,
		myScannedCreatureIds:Map<Int, Bool>,
		foeIds:Array<Int>,
		myDrones:Array<Drone>,
		foeDrones:Array<Drone>,
		droneScans:Array<DroneScan>,
		visibleCreatureDatasets:Map<Int, CreatureDataset>,
		radarBlips:Array<RadarBlip>
	) {
		this.myScore = myScore;
		this.foeScore = foeScore;
		this.myScannedCreatureIds = myScannedCreatureIds;
		this.myDrones = myDrones;
		if( turn == 0 ) for( myDrone in myDrones ) myDronesMap.set( myDrone.id, myDrone );
		
		myDroneScans.clear();
		for( droneScan in droneScans ) if( myDronesMap.exists( droneScan.droneId )) myDroneScans.set( droneScan.creatureId, true );
		
		this.visibleCreatureDatasets = visibleCreatureDatasets;
		this.radarBlips = radarBlips;

		for( id in escapedCreatures.keys()) escapedCreatures.set( id, true );
		for( radarBlip in radarBlips ) escapedCreatures.set( radarBlip.creatureId, false );
		for( i in 0...myDrones.length ) {
			// setScannedCreatures( myDrones[i], myDrones[1 - i] );
			myDrones[i].updateLightCooldown();
		}

		visibleMonsters.splice( 0, visibleMonsters.length );
		for( visibleCreature in visibleCreatureDatasets ) {
			if( monstersMap.exists( visibleCreature.id )) {
				visibleMonsters.push( monstersMap[visibleCreature.id] );
			}
		}
	}
	
	// function setScannedCreatures( myDrone:Drone, otherDrone:Drone ) {
	// 	final lightDist = myDrone.light == 0 ? 800 : 2000;
	// 	for( creature in visibleCreatureDatasets ) {
	// 		if( myDrone.scans[creature.id] ) continue;
	// 		if( otherDrone.scans[creature.id] ) continue;

	// 		final dist = myDrone.pos.distance( creature.pos );
	// 		if( dist < lightDist ) {
	// 			myDrone.scans.set( creature.id, true );
	// 			// printErr( 'drone ${myDrone.id} scanned creature ${creature.id}' );
	// 		}
	// 	}
	// }

	// MOVE <x> <y> <light (1|0)> | WAIT <light (1|0)>
	public function process() {
		// if( turn == 0 ) printErr( 'myScore $myScore\nfoeScore: $foeScore\nmyScannedCreatureIds $myScannedCreatureIds\nfoeIds $foeIds\nmyDrones $myDrones\nfoeDrones $foeDrones\ndroneScans $droneScans\nvisibleCreatureDatasets $visibleCreatureDatasets\nradarBlips $radarBlips' );
		for( creature in creatures ) {
			if( visibleCreatureDatasets.exists( creature.id )) {
				final visibleCreature = visibleCreatureDatasets[creature.id];
				creature.updatePosition( visibleCreature.pos, visibleCreature.vel );
			} else {
				creature.increaseRanges();
			}
		}
		// for( creatureDataset in visibleCreatureDatasets ) if( monstersMap.exists( creatureDataset.id )) printErr( monstersMap[creatureDataset.id] );

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
		for( i in 0...myDrones.length ) {
			final myDrone = myDrones[i];
			final otherDrone = myDrones[1-i];
			myDrone.resetTarget();
			
			for( creature in creatures ) {
				if( creature.type == -1
				|| escapedCreatures[creature.id]
				|| myScannedCreatureIds.exists( creature.id )
				|| myDroneScans.exists( creature.id )) continue;

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
				printErr( 'move drone ${drone.id} to creature ${creature.id} ${creature.pos.x}:${creature.pos.y} range ${creature.minX}:${creature.minY} - ${creature.maxX}:${creature.maxY}' );
			}
			if( assignedDronesNum == myDrones.length ) break;
		}
	}

	function doSearch( myDrone:Drone ) {
		final targetCreature = creaturesMap[myDrone.targetId];
		final monsterDetectRange = myDrone.lightRadius + MONSTER_ADDITIONAL_DETACTABLE_RANGE;
		final monsterDetectRangeSQ = monsterDetectRange * monsterDetectRange;
		final monstersNearDrone = visibleMonsters.filter( monster -> myDrone.pos.distanceSq( monster.pos ) <= monsterDetectRangeSQ );

		final distanceToCenter = myDrone.pos.distance( targetCreature.pos );
		if( distanceToCenter < LIGHT_SCAN_RADIUS && myDrone.cooldownCounter > Drone.MIN_LIGHT_COOLDOWN_DURATION ) {
			myDrone.light = 1;
			myDrone.resetLightCooldown();
		} else {
			myDrone.light = 0;
		}
		
		final targetX = max( LIGHT_SCAN_RADIUS, min( MAX_POS - LIGHT_SCAN_RADIUS, round( targetCreature.pos.x )));
		final targetY = targetCreature.pos.y;

		final destination:Vec2 = { x: targetX, y: targetY }


		final target = monstersNearDrone.length == 0 ? destination : avoidMonsters( myDrone, destination, monstersNearDrone );

		return 'MOVE ${round( target.x )} ${round( target.y )} ${myDrone.light}';
	}

	// function avoidMonsters( dronePos:Vec2, destination:Vec2 ) {
	function avoidMonsters( myDrone:Drone, destination:Vec2, monstersNearDrone:Array<Creature> ) {
		// final monstersNearDroneIds = monstersNearDrone.map( creature -> creature.id );
		// printErr( 'drone ${myDrone.id} avoid monsters $monstersNearDroneIds' );
		
		final dronePos = myDrone.pos;

		final bestVel:Vec2 = { x: destination.x - myDrone.pos.x, y: destination.y - myDrone.pos.y }
		var bestDistance = Math.POSITIVE_INFINITY;

		final testVel:Vec2 = { x: 0, y: 0 }
		var isSavePosition = true;
		for( _ in 0...200 ) {
			final angle = Math.random() * 2 * Math.PI;
			final distance = Math.random() * DRONE_SPEED;
			testVel.x = Math.cos( angle ) * distance;
			testVel.y = Math.sin( angle ) * distance;

			final testPosition = dronePos.add( testVel );
			if( testPosition.x < 0 || testPosition.x >= MAX_POS || testPosition.y >= MAX_POS ) continue;

			isSavePosition = true;
			for( monster in monstersNearDrone ) {
				// printErr( 'drone ${myDrone.id} testPos ${dronePos.add( testVel )} with monster ${monster.id}' );
				if( getCollision( dronePos, testVel, monster.pos, monster.vel )) {
					isSavePosition = false;
					break;
				}
			}
			// printErr( 'drone ${myDrone.id} testPos ${dronePos.add( testVel )} isSave $isSavePosition' );
			if( !isSavePosition ) continue;
			
			final distanceSq = dronePos.add( testVel ).distanceSq( destination );
			if( distanceSq < bestDistance ) {
				bestDistance = distanceSq;
				bestVel.x = testVel.x;
				bestVel.y = testVel.y;
				// printErr( 'testPos ${dronePos.add( testVel )} is better' );
			}
		}
		
		final bestPos = dronePos.add( bestVel );
		// printErr( 'myDrone ${myDrone.id} bestPos ${bestPos.x}:${bestPos.y}  isSave $isSavePosition' );
		return bestPos;
	}

	function doSave( myDrone:Drone) {
		if( myDrone.pos.y < 500 + 600 ) myDrone.state = Search;

		final monstersNearDrone = visibleMonsters.filter( monster -> myDrone.pos.distanceSq( monster.pos ) <= myDrone.lightRadius * myDrone.lightRadius );

		final destination:Vec2 = { x: myDrone.pos.x, y: 0 }
		final target = monstersNearDrone.length == 0 ? destination : avoidMonsters( myDrone, destination, monstersNearDrone );

		return 'MOVE ${round( target.x )} ${round( target.y )} 0';
	}

	function getCollision( dronePos:Vec2, droneVel:Vec2, monsterPos:Vec2, monsterVel:Vec2 ) {
		// Check instant collision
		if( monsterPos.inRange( dronePos, DRONE_HIT_RANGE + MONSTER_EAT_RANGE )) {
			// printErr( 'instant collision' );
			return true;
		}

		// Both units are motionless
		if( droneVel.isZero() && monsterVel.isZero() ) {
			// printErr( 'Both units are motionless' );
			return false;
		}

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

		if( a < 0 ) {
			// printErr( 'a < 0  $a' );
			return false;
		}

		final b = 2.0 * ( x2 * vx2 + y2 * vy2 );
		final c = x2 * x2 + y2 * y2 - r2 * r2;
		final delta = b * b - 4.0 * a * c;

		if( delta < 0 ) {
			// printErr( 'delta < 0  $delta' );
			return false;
		}

		final t = ( -b - Math.sqrt( delta )) / ( 2.0 * a );

		if( t <= 0 || t > 1 ) {
			// printErr( ' <= 0 || t > 1  $t' );
			return false;
		}

		return true;
	}
}
