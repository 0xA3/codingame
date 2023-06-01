package ai.versions;

import CodinGame.printErr;
import ai.algorithm.BreadthFirstSearch;
import ai.data.CellDataset;
import ai.data.CellDistance;
import ai.data.FrameCellDataset;

using Lambda;

// finds closest ressouces and harvests them

class Ai1 implements IAi {
	
	public var aiId = "Wait";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	var cells:Array<CellDataset>;
	var cellDistances:Array<CellDistance>;
	var myBaseIndices:Array<Int>;
	var oppBaseIndices:Array<Int>;

	public function new() { }
	
	public function setGlobalInputs( cells:Array<CellDataset>, myBaseIndices:Array<Int>, oppBaseIndices:Array<Int> ) {
		this.cells = cells;
		this.myBaseIndices = myBaseIndices;
		this.oppBaseIndices = oppBaseIndices;
	}
	
	public function setInputs( frameCellDatasets:Array<FrameCellDataset> ) {
		for( i in 0...frameCellDatasets.length ) {
			cells[i].resources = frameCellDatasets[i].resources;
			cells[i].myAnts = frameCellDatasets[i].myAnts;
			cells[i].oppAnts = frameCellDatasets[i].oppAnts;
		}
	}

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		
		var output = "";
		for( myBaseIndex in myBaseIndices ) {
			final cellDistances = BreadthFirstSearch.getCellDistances( cells, myBaseIndex );
			cellDistances.sort(( a, b ) -> a.distance - b.distance );
			final closestCell = cellDistances[0];
			output += 'LINE ${closestCell.start} ${closestCell.end} 1';
		}

		// for( cellDistance in cellDistances ) printErr( 'start: ${cellDistance.start}, end: ${cellDistance.end}, distance: ${cellDistance.distance}' );
		
		return output;
	};
}