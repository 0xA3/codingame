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

// calculate distances between all cells
// find closest targets for each base
// phase1 eggs until i have more than half
// phase2 crystals on border to opponent
// phase3 crystals on my side

class Ai9 implements IAi {
	
	public var aiId = "Ai9";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	final minDistances:Map<Int, Int> = [];

	var cells:Array<CellDataset>;
	var myBaseIds:Array<Int>;
	var oppBaseIds:Array<Int>;
	
	var eggsTotal = 0;
	var crystalsTotal = 0;
	var antsTotal = 0;

	var myAntsTotal = 0;
	var oppAntsTotal = 0;
	var myAntsPerBase = 0;
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
				if( cell.type == CellType.Egg ) eggCells.set( i, true );
				if( cell.type == CellType.Crystal ) crystalCells.set( i, true );
			}

			if( turn == 0 ) {
				if( cell.type == 1 ) eggsTotal += frameCellDataset.resources;
				else if( cell.type == 2 ) crystalsTotal += frameCellDataset.resources;
			}
		}
		
		myAntsPerBase = int( myAntsTotal / myBaseIds.length );
		
		if( turn == 0 ) {
			pathDataset = { paths: GetPaths.get( cells ), width: cells.length };
			antsTotal = myAntsTotal + oppAntsTotal + eggsTotal;
			// final start = Timer.stamp();
			// printErr( 'Paths calculation time: ${Timer.stamp() - start}' );
			// printErr( 'eggsTotal $eggsTotal' );
			// printErr( 'crystalsTotal $crystalsTotal' );
		}

		switch phase {
			case Eggs:
				if( myAntsTotal > antsTotal / 2 ) {
					phase = ContestedCrystals;
					printErr( 'switch to ContestedCrystals' );
				}
			case ContestedCrystals: // no-op
			case SaveCrystals: // no-op
		}

	}

	inline function resetTurn() {
		myAntsTotal = 0;
		oppAntsTotal = 0;
		resourceCells.clear();
		eggCells.clear();
		crystalCells.clear();
	}

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		
		final beacons:Map<Int, Int> = [];
		for( baseId in myBaseIds ) {
			final targets = switch phase {
				case Eggs: getEggTargets( baseId );
				default: getTargets( baseId );
			}
			
			// printErr( 'base $baseId  targets $targets' );
			switch phase {
				case Eggs: crackEggs( baseId, targets, beacons );
				case ContestedCrystals: harvestContestedCrystals( baseId, targets, beacons );
				case SaveCrystals: harvestSaveCrystals( baseId, targets, beacons );
			}
		}
		turn++;
		
		final outputs = [for( cellId => amount in beacons ) 'BEACON $cellId $amount'];
		
		if( outputs.length == 0 ) return "WAIT";

		return outputs.join( ";" );
	}

	function getEggTargets( baseId:Int ) {
		final baseTargets = [];
		for( cellId in eggCells.keys()) {
			final baseDistance = pathDataset.getDistance( baseId, cellId );
			var isCloser = false;
			for( myBaseId in myBaseIds ) {
				if( myBaseId != baseId && pathDataset.getDistance( myBaseId, cellId ) < baseDistance ) isCloser = true;
			}
			if( !isCloser ) baseTargets.push( cellId );
		}
		return baseTargets;
	}

	function getTargets( baseId:Int ) {
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
		
		var remainingAnts = myAntsPerBase;
		for( target in targets ) {
			if( remainingAnts <= 0 ) break;
			final path = pathDataset.getPath( target, baseId );
			for( cellId in path ) beacons.set( cellId, 1 );
			remainingAnts -= path.length * 2;
		}
	}

	function harvestContestedCrystals( baseId:Int, targets:Array<Int>, beacons:Map<Int, Int> ) {
		targets.sort(( a, b ) -> pathDataset.getDistance( baseId, a ) - pathDataset.getDistance( baseId, b ));
		
		final contestedTargets = [];
		for( target in targets ) {
			if( crystalCells.exists( target )) {
				final myDistance = pathDataset.getDistance( baseId, target );
				var oppMinDistance = 9999;
				for( oppBaseId in oppBaseIds ) {
					final oppDistance = pathDataset.getDistance( oppBaseId, target );
					if( oppDistance < oppMinDistance ) oppMinDistance = oppDistance;
				}
				if( oppMinDistance == myDistance ) contestedTargets.push( target );
			}
		}

		final totalTargets = contestedTargets.copy();
		for( target in targets ) if( !contestedTargets.contains( target )) totalTargets.push( target );
		
		var remainingAnts = myAntsPerBase;
		for( target in totalTargets ) {
			if( remainingAnts <= 0 ) break;
			final path = pathDataset.getPath( target, baseId );
			for( cellId in path ) beacons.set( cellId, 1 );
			remainingAnts -= path.length * 2;
		}
	}

	function harvestSaveCrystals( baseId:Int, targets:Array<Int>, beacons:Map<Int, Int> ) {
		
	}


}