package ai.versions;

import CodinGame.printErr;
import ai.algorithm.GetPaths;
import ai.data.CellDataset;
import ai.data.FrameCellDataset;
import haxe.Timer;

using Lambda;

// calculate distances between all cells
// set beacons to closest target

class Ai8 implements IAi {
	
	public var aiId = "Ai8";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	final minDistances:Map<Int, Int> = [];

	var cells:Array<CellDataset>;
	var myBaseIndices:Array<Int>;
	var oppBaseIndices:Array<Int>;
	
	var myAntsTotal = 0;
	var oppAntsTotal = 0;
	var turn = 0;
	
	var resourceCellSet:Map<Int, Bool> = [];
	var paths:Array<Array<Int>> = [];
	
	public function new() { }
	
	public function setGlobalInputs( cells:Array<CellDataset>, myBaseIndices:Array<Int>, oppBaseIndices:Array<Int> ) {
		this.cells = cells;
		this.myBaseIndices = myBaseIndices;
		this.oppBaseIndices = oppBaseIndices;
	}
	
	public function setInputs( myScore:Int, oppScore:Int, frameCellDatasets:Array<FrameCellDataset> ) {
		myAntsTotal = 0;
		oppAntsTotal = 0;
		for( i in 0...frameCellDatasets.length ) {
			final frameCellDataset = frameCellDatasets[i];
			
			// if( cells[i].resources > 0 && frameCellDataset.resources == 0 ) graph.removeVertex( i );
			
			cells[i].resources = frameCellDataset.resources;
			cells[i].myAnts = frameCellDataset.myAnts;
			cells[i].oppAnts = frameCellDataset.oppAnts;
			myAntsTotal += frameCellDataset.myAnts;
			oppAntsTotal += frameCellDataset.oppAnts;
		}
		if( turn == 0 ) {
			final start = Timer.stamp();
			paths = GetPaths.get( cells );
			printErr( 'Paths calculation time: ${Timer.stamp() - start}' );
		}
	}

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		resourceCellSet.clear();
		for( i in 0...cells.length ) if( cells[i].resources > 0 ) resourceCellSet.set( i, true );
		
		final beacons:Map<Int, Int> = [];
		for( baseId in myBaseIndices ) {
			var minDistance = 999;
			var targetId = baseId;
			var path:Array<Int> = [];
			for( resourceCellId in resourceCellSet.keys()) {
				final pathIndex = getPathIndex( baseId, resourceCellId, cells.length );
				final distance = paths[pathIndex].length;
				if( distance < minDistance ) {
					minDistance = distance;
					targetId = resourceCellId;
					path = paths[pathIndex];
				}
			}

			printErr( 'closest resource cell $targetId' );
			for( cellId in path ) beacons.set( cellId, 1 );
		}

		turn++;
		
		final outputs = [for( cellId => amount in beacons ) 'BEACON $cellId $amount'];
		
		if( outputs.length == 0 ) return "WAIT";

		return outputs.join( ";" );
	}

	public static inline function getPathIndex( start:Int, end:Int, width:Int ) return start * width + end;
}