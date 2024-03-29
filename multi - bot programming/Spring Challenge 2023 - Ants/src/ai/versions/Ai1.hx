package ai.versions;

import CodinGame.printErr;
import ai.data.CellDataset;
import ai.data.FrameCellDataset;
import ai.data.Node;

using Lambda;

// finds closest ressouces and harvests them

class Ai1 implements IAi {
	
	public var aiId = "Ai1";
	
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
	}
	
	public function setInputs( myScore:Int, oppScore:Int, frameCellDatasets:Array<FrameCellDataset> ) {
		for( i in 0...frameCellDatasets.length ) {
			cells[i].resources = frameCellDatasets[i].resources;
			cells[i].myAnts = frameCellDatasets[i].myAnts;
			cells[i].oppAnts = frameCellDatasets[i].oppAnts;
		}
	}

	// WAIT | LINE <sourceIdx> <targetIdx> <strength> | BEACON <cellIdx> <strength> | MESSAGE <text>
	public function process() {
		
		var outputs = [];
		for( myBaseIndex in myBaseIndices ) {
			final cellDistances = getCellDistances( cells, myBaseIndex );
			cellDistances.sort(( a, b ) -> a.distance - b.distance );
			final closestCell = cellDistances[0];
			outputs.push( 'LINE ${closestCell.start} ${closestCell.end} 1' );
		}

		// for( cellDistance in cellDistances ) printErr( 'start: ${cellDistance.start}, end: ${cellDistance.end}, distance: ${cellDistance.distance}' );
		return outputs.join(" ");
	}

	function getCellDistances( cells:Array<CellDataset>, start:Int ) {
		final nodes = [for( _ in cells ) Node.getNew()];
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		final resourceCellDistances:Array<CellDistance1> = [];
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			if( cells[current].resources > 0 ) {
				final distance = getDistance( nodes, start, current );
				final cellDistance:CellDistance1 = { start: start, end: current, distance: distance }
				resourceCellDistances.push( cellDistance );
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

@:structInit class CellDistance1 {
	public final start:Int;
	public final end:Int;
	public final distance:Int;

	public function toString() return 'start: $start, end: $end, distance: $distance';
}