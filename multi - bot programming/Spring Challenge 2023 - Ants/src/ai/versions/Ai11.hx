package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.algorithm.GetPaths;
import ai.data.CellDataset;
import ai.data.CellType;
import ai.data.FrameCellDataset;
import ai.data.PathDataset;
import ai.data.TPhase;

using Lambda;

class Ai11 implements IAi {

	public var aiId = "Ai11";

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

		return "WAIT";
	}

}