package ai.versions;

import CodinGame.printErr;
import ai.data.CellDataset;
import ai.data.CellPriority;
import ai.data.FrameCellDataset;
import ai.data.Node;

using Lambda;

// finds closest ressouces or eggs and harvests them

class Ai2 implements IAi {
	
	public var aiId = "Ai2";
	
	static final ME = 1;
	static final OPP = 0;
	static final NONE = -1;

	var cells:Array<CellDataset>;
	var myBaseIndices:Array<Int>;
	var oppBaseIndices:Array<Int>;

	var myAntsTotal = 0;
	var oppAntsTotal = 0;

	public function new() { }
	
	public function setGlobalInputs( cells:Array<CellDataset>, myBaseIndices:Array<Int>, oppBaseIndices:Array<Int> ) {
		this.cells = cells;
		this.myBaseIndices = myBaseIndices;
		this.oppBaseIndices = oppBaseIndices;
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
			final cellDistances = getCellPriorities( cells, myBaseIndex );
			cellDistances.sort(( a, b ) -> a.priority < b.priority ? 1 : -1 );
			final closestCell = cellDistances[0];
			outputs.push( 'LINE ${closestCell.start} ${closestCell.end} 1' );
		}

		// for( cellDistance in cellDistances ) printErr( 'start: ${cellDistance.start}, end: ${cellDistance.end}, distance: ${cellDistance.distance}' );
		
		return outputs.join( ";" );
	}

	function getCellPriorities( cells:Array<CellDataset>, start:Int ) {
		final nodes = [for( _ in cells ) new Node()];
		final frontier = new List<Int>();
		
		frontier.add( start );
		nodes[start].visited = true;

		final resourceCellPriorities:Array<CellPriority> = [];
		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			final cell = cells[current];
			if( cell.type != 0 && cell.resources > 0 ) {
				final distance = getDistance( nodes, start, current );
				final priority = cell.type == 1 ? 2 / distance : 1 / distance;
				final cellPriority:CellPriority = { start: start, end: current, priority: priority }
				
				resourceCellPriorities.push( cellPriority );
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
		return resourceCellPriorities;
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