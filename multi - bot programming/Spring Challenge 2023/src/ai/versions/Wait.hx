package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.IAi;
import ai.data.CellDataset;
import ai.data.FrameCellDataset;

using Lambda;

class Wait implements IAi {
	public var aiId = "Wait";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	var cells:Array<CellDataset>;
	var myBaseIndices:Array<Int>;
	var oppBaseIndices:Array<Int>;

	public function new() { }
	
	public function setGlobalInputs( cells:Array<CellDataset>, myBaseIndices:Array<Int>, oppBaseIndices:Array<Int> ) {
		this.cells = cells;
		this.myBaseIndices = myBaseIndices;
		this.oppBaseIndices = oppBaseIndices;

		for( i in 0...cells.length ) {
			final cell = cells[i];
			printErr( 'cell $i $cell' );
		}
	}
	
	public function setInputs( frameCellDatasets:Array<FrameCellDataset> ) {
		for( i in 0...frameCellDatasets.length ) {
			final frameCellDataset = frameCellDatasets[i];
			final cell = cells[i];
			cell.resources = frameCellDataset.resources;
			cell.myAnts = frameCellDataset.myAnts;
			cell.oppAnts = frameCellDataset.oppAnts;
		}
	}

	public function init() { }

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		return "WAIT";
	}
}
