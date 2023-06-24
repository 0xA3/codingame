package ai.versions;

import CodinGame.printErr;
import ai.algorithm.Graph4Factory;
import ai.data.CellDataset;
import ai.data.FrameCellDataset;
import ai.data.Node;

using Lambda;

// finds closest ressouces or eggs with minimum spanning tree

class Ai4 implements IAi {
	
	public var aiId = "Ai4";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	var cells:Array<CellDataset>;
	var myBaseIndices:Array<Int>;
	var oppBaseIndices:Array<Int>;
	
	var myAntsTotal = 0;
	var oppAntsTotal = 0;
	var turn = 0;
	
	var resourceCellSet:Map<Int, Bool> = [];
	var graph = new Graph4( [], [], 0, 0 );
	
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
		if( turn == 0 ) graph.createMinimumSpanningTree();
		
		final startIndices = [for( myBaseIndex in myBaseIndices ) myBaseIndex => true];
		final mstEdges = graph.mstEdges.copy();
		
		final lines = [];
		var totalDistance = 0;
		while( totalDistance < myAntsTotal && mstEdges.length > 0 ) {
			final removeList = [];
			for( edge in mstEdges ) {
				if( startIndices.exists( edge.start )) {
					lines.push( edge );
					removeList.push( edge );
					
					startIndices.set( edge.end, true );
					totalDistance += edge.distance;
					break;
				}
				if( startIndices.exists( edge.end )) {
					lines.push( edge );
					removeList.push( edge );
					
					startIndices.set( edge.start, true );
					totalDistance += edge.distance;
		
					break;
				}
			}
			for( edge in removeList ) mstEdges.remove( edge );
		}

		final outputs = lines.map( line -> 'LINE ${line.start} ${line.end} 1' );

		turn++;
		
		return outputs.join( ";" );
	}
}