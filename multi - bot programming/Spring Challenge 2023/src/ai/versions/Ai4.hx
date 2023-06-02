package ai.versions;

import CodinGame.printErr;
import ai.data.CellDataset;
import ai.data.FrameCellDataset;
import ai.data.Node;
import ai.factory.Graph4Factory;

using Lambda;

// finds closest ressouces or eggs with nearest neighbor heuristic

class Ai4 implements IAi {
	
	public var aiId = "Ai2";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	var cells:Array<CellDataset>;
	var myBaseIndices:Array<Int>;
	var oppBaseIndices:Array<Int>;
	
	var nodes:Array<Node> = [];
	function resetNodes() for( node in nodes ) node.reset();

	var myAntsTotal = 0;
	var oppAntsTotal = 0;
	var turn = 0;
	
	var resourceCellSet:Map<Int, Bool> = [];
	var graph = new Graph4( [], [] );
	
	public function new() { }
	
	public function setGlobalInputs( cells:Array<CellDataset>, myBaseIndices:Array<Int>, oppBaseIndices:Array<Int> ) {
		this.cells = cells;
		this.myBaseIndices = myBaseIndices;
		this.oppBaseIndices = oppBaseIndices;
		
		nodes = [for( _ in cells ) new Node()];
	}
	
	public function setInputs( frameCellDatasets:Array<FrameCellDataset> ) {
		myAntsTotal = 0;
		oppAntsTotal = 0;
		for( i in 0...frameCellDatasets.length ) {
			final frameCellDataset = frameCellDatasets[i];
			cells[i].resources = frameCellDataset.resources;
			cells[i].myAnts = frameCellDataset.myAnts;
			cells[i].oppAnts = frameCellDataset.oppAnts;
			myAntsTotal += frameCellDataset.myAnts;
			oppAntsTotal += frameCellDataset.oppAnts;
		}
		if( turn == 0 ) graph = Graph4Factory.create( myBaseIndices, cells );
	}

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		graph.createMinimumSpanningTree();
		final outputs = [];
		
		turn++;
		
		return outputs.join( ";" );
	}
}