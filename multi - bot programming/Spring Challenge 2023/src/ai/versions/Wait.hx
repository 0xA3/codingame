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

	var cellDatasets:Array<CellDataset>;
	var myBaseIndices:Array<Int>;
	var oppBaseIndices:Array<Int>;

	public function new() { }
	
	public function setGlobalInputs( cellDatasets:Array<CellDataset>, myBaseIndices:Array<Int>, oppBaseIndices:Array<Int> ) {
		this.cellDatasets = cellDatasets;
		this.myBaseIndices = myBaseIndices;
		this.oppBaseIndices = oppBaseIndices;
	}
	
	public function setInputs( frameCellDatasets:Array<FrameCellDataset> ) {
		
	}

   // WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
   public function process() return "WAIT";
}
