package ai.versions;

import CodinGame.printErr;
import ai.algorithm.BreadthFirstSearch;
import ai.data.CellDataset;
import ai.data.FrameCellDataset;
import ai.data.Node;
import ai.factory.Graph4Factory;

using Lambda;

// finds closest ressouces or eggs with minimum spanning tree

class Ai6 implements IAi {
	
	public var aiId = "Ai6";
	
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
	var graph = new Graph4( [], [], 0, 0 );
	
	public function new() { }
	
	public function setGlobalInputs( cells:Array<CellDataset>, myBaseIndices:Array<Int>, oppBaseIndices:Array<Int> ) {
		this.cells = cells;
		this.myBaseIndices = myBaseIndices;
		this.oppBaseIndices = oppBaseIndices;
		
		initMinDistances();
	}
	
	function initMinDistances() {
		for( myBaseIndex in myBaseIndices ) {
			final distancesFromBase = BreadthFirstSearch.getDistances( cells, myBaseIndex );
			for( cellId => distance in distancesFromBase ) {
				if( !minDistances.exists( cellId )) minDistances.set( cellId, distance );
				if( distance < minDistances[cellId] ) minDistances.set( cellId, distance );
			}
		}
	}

	public function setInputs( myScore:Int, oppScore:Int, frameCellDatasets:Array<FrameCellDataset> ) {
		myAntsTotal = 0;
		oppAntsTotal = 0;
		for( i in 0...frameCellDatasets.length ) {
			final frameCellDataset = frameCellDatasets[i];
			
			if( cells[i].resources > 0 && frameCellDataset.resources == 0 ) graph.removeVertex( i );
			
			cells[i].resources = frameCellDataset.resources;
			cells[i].myAnts = frameCellDataset.myAnts;
			cells[i].oppAnts = frameCellDataset.oppAnts;
			myAntsTotal += frameCellDataset.myAnts;
			oppAntsTotal += frameCellDataset.oppAnts;
		}
		if( turn == 0 ) graph = Graph4Factory.create( myBaseIndices, cells, [] );
	}

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		if( graph.needsUpdate ) graph.createMinimumSpanningTree( [] );
		
		final startIndices = [for( myBaseIndex in myBaseIndices ) myBaseIndex => true];
		final mstEdges = graph.mstEdges.copy();
		
		final outputEdges = [];
		var totalDistance = 0;
		while( totalDistance < myAntsTotal && mstEdges.length > 0 ) {
			final removeList = [];
			var skippedEdges = 0;
			for( edge in mstEdges ) {
				if( startIndices.exists( edge.start )) {
					if( minDistances[edge.start] <= turn ) outputEdges.push( edge );
					removeList.push( edge );
					
					startIndices.set( edge.end, true );
					totalDistance += edge.distance;
					break;
				}
				if( startIndices.exists( edge.end )) {
					if( minDistances[edge.end] <= turn ) outputEdges.push( edge );
					removeList.push( edge );
					
					startIndices.set( edge.start, true );
					totalDistance += edge.distance;
		
					break;
				}
			}
			for( edge in removeList ) mstEdges.remove( edge );
			
			if( outputEdges.length + skippedEdges >= mstEdges.length ) break;
		}

		final outputs = outputEdges.map( edge -> 'LINE ${edge.start} ${edge.end} 1' );

		turn++;
		
		return outputs.join( ";" );
	}
}