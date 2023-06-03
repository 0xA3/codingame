package ai.versions;

import CodinGame.printErr;
import ai.data.CellDataset;
import ai.data.FrameCellDataset;
import ai.data.Node;

using Lambda;

// finds closest ressouces or eggs with nearest neighbor heuristic

class Ai3 implements IAi {
	
	public var aiId = "Ai3";
	
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
	var resourceCellSet:Map<Int, Bool> = [];

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
	}

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		
		var outputs = [];
		for( myBaseIndex in myBaseIndices ) {
			resourceCellSet.clear();
			final lines = getNearestNeighborLines( myBaseIndex );
			for( line in lines ) outputs.push( 'LINE ${line.start} ${line.end} 1' );
		}

		// for( cellDistance in cellDistances ) printErr( 'start: ${cellDistance.start}, end: ${cellDistance.end}, distance: ${cellDistance.distance}' );
		
		return outputs.join( ";" );
	}

	function getNearestNeighborLines( myBaseIndex:Int ) {
		final lines:Array<Line> = [];
		var totalDistance = 0;
		var startIndex = myBaseIndex;

		while( totalDistance < myAntsTotal ) {
			final cellDistances = getCellDistances( cells, startIndex );
			cellDistances.sort(( a, b ) -> a.distance < b.distance ? -1 : 1 );
			var closestCell = CellDistance3.NO_CELL_DISTANCE;
			for( cellDistance in cellDistances ) {
				if( !resourceCellSet.exists( cellDistance.end )) {
					closestCell = cellDistance;
					totalDistance += cellDistance.distance;
					break;
				}
			}
			
			if( closestCell == CellDistance3.NO_CELL_DISTANCE ) break;
			
			resourceCellSet.set( closestCell.end, true );
			lines.push({ start: closestCell.start, end: closestCell.end });
		}

		return lines;
	}

	function getCellDistances( cells:Array<CellDataset>, start:Int ) {
		resetNodes();
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		final resourceCellDistances:Array<CellDistance3> = [];
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			final cell = cells[current];
			if( cell.type != 0 && cell.resources > 0 ) {
				final distance = getDistance( nodes, start, current );
				final cellPriority:CellDistance3 = { start: start, end: current, type: cell.type, distance: distance }
				
				resourceCellDistances.push( cellPriority );
			}
			// trace( 'current $current' );
			for( neighbor in cells[current].neighbors ) {
				// trace( 'check $next' );
				final nextNode = nodes[neighbor];
				if( !nextNode.visited ) {
					nextNode.previous = current;
					nextNode.visited = true;
					frontier.add( neighbor );
				}
			}
		}
		return resourceCellDistances;
	}

	function getDistance( nodes:Array<Node>, start:Int, end:Int ) {
		var distance = 0;
		var i = end;
		while( i != start ) {
			i = nodes[i].previous;
			distance++;
		}
		return distance;
	}
}

typedef Line = {
	final start:Int;
	final end:Int;
}

@:structInit class CellDistance3 {
	public static final NO_CELL_DISTANCE:CellDistance3 = { start: -1, end: -1, type: -1, distance: -1 }
	
	public final start:Int;
	public final end:Int;
	public final type:Int;
	public final distance:Int;

	public function toString() return 'start: $start, end: $end, type: $type, distance: $distance';
}