package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.algorithm.GetPaths;
import ai.data.CellDataset;
import ai.data.CellType;
import ai.data.FrameCellDataset;
import ai.data.PathDataset;
import ai.data.TPhase;
import haxe.Timer;

using Lambda;

// same as Ai9
// add targets if production increases

class Ai10 implements IAi {
	
	public var aiId = "Ai10";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	final minDistances:Map<Int, Int> = [];

	var cells:Array<CellDataset>;
	var myBaseIds:Array<Int>;
	var oppBaseIds:Array<Int>;
	var startAnts = 0;

	var eggsTotal = 0;
	var crystalsTotal = 0;
	var antsTotal = 0;

	var myScore = 0;
	var oppScore = 0;
	var myAntsTotal = 0;
	var oppAntsTotal = 0;
	var myAntsPerBase = 0;
	
	var remainingEggs = 0;
	var remainingCrystals = 0;

	var ratioEggsGathered = 0.0;
	var ratioCrystalsGathered = 0.0;
	var turn = 0;
	
	var resourceCells:Map<Int, Bool> = [];
	var eggCells:Map<Int, Bool> = [];
	var crystalCells:Map<Int, Bool> = [];
	var pathDataset:PathDataset;
	var phase:TPhase = Eggs;

	public function new() { }
	
	public function setGlobalInputs( cells:Array<CellDataset>, myBaseIds:Array<Int>, oppBaseIds:Array<Int> ) {
		this.cells = cells;
		this.myBaseIds = myBaseIds;
		this.oppBaseIds = oppBaseIds;
	}
	
	public function setInputs( myScore:Int, oppScore:Int, frameCellDatasets:Array<FrameCellDataset> ) {
		resetTurn();

		this.myScore = myScore;
		this.oppScore = oppScore;
		
		for( i in 0...frameCellDatasets.length ) {
			final cell = cells[i];
			final frameCellDataset = frameCellDatasets[i];
			cell.resources = frameCellDataset.resources;
			cell.myAnts = frameCellDataset.myAnts;
			cell.oppAnts = frameCellDataset.oppAnts;
			myAntsTotal += frameCellDataset.myAnts;
			oppAntsTotal += frameCellDataset.oppAnts;

			if( cell.resources > 0 ) {
				resourceCells.set( i, true );
				if( cell.type == CellType.Egg ) {
					eggCells.set( i, true );
					remainingEggs += cell.resources;
				}
				if( cell.type == CellType.Crystal ) {
					crystalCells.set( i, true );
					remainingCrystals += cell.resources;
				}
			}
		}
		
		if( turn == 0 ) {
			pathDataset = { paths: GetPaths.get( cells ), width: cells.length };
			startAnts = myAntsTotal;
			eggsTotal = remainingEggs;
			crystalsTotal = remainingCrystals;
			antsTotal = myAntsTotal + oppAntsTotal + eggsTotal;
		}

		calcStats();
		
		switch phase {
			case Eggs: if( ratioEggsGathered >= 0.5 || remainingEggs == 0 ) phase = ContestedCrystals;
			case ContestedCrystals: // no-op
			case SaveCrystals: // no-op
		}

	}

	inline function resetTurn() {
		myAntsTotal = 0;
		oppAntsTotal = 0;
		remainingEggs = 0;
		remainingCrystals = 0;
		resourceCells.clear();
		eggCells.clear();
		crystalCells.clear();
	}

	inline function calcStats() {
		myAntsPerBase = int( myAntsTotal / myBaseIds.length );
		final eggsGathered = myAntsTotal - startAnts;
		ratioEggsGathered = eggsGathered / eggsTotal;
		ratioCrystalsGathered = myScore / crystalsTotal;
		// printErr( 'ratioEggsGathered $ratioEggsGathered  ratioCrystalsGathered $ratioCrystalsGathered' );
	}

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		final beacons:Map<Int, Int> = [];
		for( baseId in myBaseIds ) {
			final targets = switch phase {
				case Eggs: getTargets( baseId, eggCells );
				default: getTargets( baseId, resourceCells );
			}
			
			// printErr( 'base $baseId  targets $targets' );
			switch phase {
				case Eggs: crackEggs( baseId, targets, beacons );
				case ContestedCrystals: harvestContestedCrystals( baseId, targets, beacons );
				case SaveCrystals: harvestSaveCrystals( baseId, targets, beacons );
			}
		}
		turn++;
		// printErr( 'beacons ' + [for( cellId => _ in beacons ) cellId].join( "," ));
		final outputs = [for( cellId => amount in beacons ) 'BEACON $cellId $amount'];
		
		if( outputs.length == 0 ) return "WAIT";

		return outputs.join( ";" ) + ';MESSAGE $phase';
	}

	function getTargets( baseId:Int, cells:Map<Int, Bool> ) {
		final baseTargets = [];
		for( cellId in resourceCells.keys()) {
			final baseDistance = pathDataset.getDistance( baseId, cellId );
			var isCloser = false;
			for( myOtherBaseId in myBaseIds ) {
				if( myOtherBaseId != baseId && pathDataset.getDistance( myOtherBaseId, cellId ) < baseDistance ) isCloser = true;
			}
			if( !isCloser ) baseTargets.push( cellId );
		}
		return baseTargets;
	}

	function crackEggs( baseId:Int, targets:Array<Int>, beacons:Map<Int, Int> ) {
		targets.sort(( a, b ) -> pathDataset.getDistance( baseId, a ) - pathDataset.getDistance( baseId, b ));
		// for( eggTarget in targets ) printErr( '$eggTarget  distance: ${pathDataset.getDistance( baseId, eggTarget )}' );
		
		beacons.set( baseId, 1 );
		var treeLength = 1;
		var targetsNum = 0;
		
		for( target in targets ) {
			final path = pathDataset.getPath( target, baseId );
			final shortestPath = getShortestPath( path, beacons );
			
			final currentProduction = myAntsPerBase / treeLength * targetsNum;
			final nextProduction = myAntsPerBase / ( treeLength + shortestPath.length ) * ( targetsNum + 1 );
			if( nextProduction > currentProduction ) {
				for( cellId in shortestPath ) beacons.set( cellId, 1 );
				treeLength += shortestPath.length;
				targetsNum++;
			}
			else break;
			// printErr( 'path $path  shortestPath $shortestPath  difference ${path.length - shortestPath.length}' );
			// printErr( 'currentProduction $currentProduction  nextProduction $nextProduction' );
		}
	}

	function harvestContestedCrystals( baseId:Int, targets:Array<Int>, beacons:Map<Int, Int> ) {
		targets.sort(( a, b ) -> pathDataset.getDistance( baseId, a ) - pathDataset.getDistance( baseId, b ));
		
		beacons.set( baseId, 1 );
		var treeLength = 1;
		var targetsNum = 0;

		final myTargets = [];
		final oppTargets = [];
		final contestedTargets = [];
		for( target in targets ) {
			if( crystalCells.exists( target )) {
				final myDistance = pathDataset.getDistance( baseId, target );
				var oppMinDistance = 9999;
				for( oppBaseId in oppBaseIds ) {
					final oppDistance = pathDataset.getDistance( oppBaseId, target );
					if( oppDistance < oppMinDistance ) oppMinDistance = oppDistance;
				}
				if( myDistance < oppMinDistance ) myTargets.push( target );
				if( myDistance > oppMinDistance ) oppTargets.push( target );
				if( oppMinDistance == myDistance ) contestedTargets.push( target );
			}
		}

		final totalTargets = myTargets.concat( contestedTargets );
		
		var remainingAnts = myAntsPerBase;
		for( target in contestedTargets ) {
			final path = pathDataset.getPath( target, baseId );
			final shortestPath = getShortestPath( path, beacons );
			// printErr( 'path $path  shortestPath $shortestPath  difference ${path.length - shortestPath.length}' );
			final currentProduction = myAntsPerBase / treeLength * targetsNum;
			final nextProduction = myAntsPerBase / ( treeLength + shortestPath.length ) * ( targetsNum + 1 );
			if( nextProduction > currentProduction ) {
				for( cellId in shortestPath ) beacons.set( cellId, 1 );
				treeLength += shortestPath.length;
				targetsNum++;
			}
			else break;
		}
		
		for( target in myTargets ) {
			final path = pathDataset.getPath( target, baseId );
			final shortestPath = getShortestPath( path, beacons );
			// printErr( 'path $path  shortestPath $shortestPath  difference ${path.length - shortestPath.length}' );
			final currentProduction = myAntsPerBase / treeLength * targetsNum;
			final nextProduction = myAntsPerBase / ( treeLength + shortestPath.length ) * ( targetsNum + 1 );
			if( nextProduction > currentProduction ) {
				for( cellId in shortestPath ) beacons.set( cellId, 1 );
				treeLength += shortestPath.length;
				targetsNum++;
			}
			else break;
		}
		
		for( target in oppTargets ) {
			final path = pathDataset.getPath( target, baseId );
			final shortestPath = getShortestPath( path, beacons );
			// printErr( 'path $path  shortestPath $shortestPath  difference ${path.length - shortestPath.length}' );
			final currentProduction = myAntsPerBase / treeLength * targetsNum;
			final nextProduction = myAntsPerBase / ( treeLength + shortestPath.length ) * ( targetsNum + 1 );
			if( nextProduction > currentProduction ) {
				for( cellId in shortestPath ) beacons.set( cellId, 1 );
				treeLength += shortestPath.length;
				targetsNum++;
			}
			else break;
		}
	}

	function harvestSaveCrystals( baseId:Int, targets:Array<Int>, beacons:Map<Int, Int> ) {
		
	}

	function getShortestPath( path:Array<Int>, beacons:Map<Int, Int> ) {
		var closestCell = path[path.length - 1];
		var minDistance = path.length;
		// printErr( 'path $path  beacons [' + [for( beaconCell in beacons.keys()) beaconCell].join(",") + "]" );
		
		for( beaconCell in beacons.keys()) {
			final distance = pathDataset.getDistance( path[0], beaconCell );
			if( distance < minDistance ) {
				minDistance = distance;
				closestCell = beaconCell;
				// printErr( 'change closestCell to $closestCell  minDistance to $minDistance' );
			}
		}
		final shortestPath = pathDataset.getPath( path[0], closestCell );

		return shortestPath.slice( 0, shortestPath.length - 1 );
	}

	
}