package ai.versions;

import CodinGame.printErr;
import ai.contexts.OutputTCell.output;
import ai.data.Cell;
import ai.data.TCell;
import xa3.math.Pos;

using xa3.MathUtils;

class Ai2 {
	
	public var aiId = "Wood 1 solver";

	var playerIdx = 1;

	var positions:Array<Array<Pos>>;
	var cells:Map<Pos, Cell>;
	var width:Int;
	var height:Int;
	final harvestedProteins:Map<Pos, Bool> = [];

	var requiredActionsCount:Int;
	var entities:Array<Cell>;
	var myCells:Map<Int, Cell>;
	var oppCells:Array<Cell>;
	var a:Int;
	var b:Int;
	var c:Int;
	var d:Int;

	var turn:Int;

	var myProteinCell = Cell.NO_CELL;
	final myRoots = [];

	public function new() {	}

	public function setGlobalInputs( positions:Array<Array<Pos>>, cells:Map<Pos, Cell>, width:Int, height:Int ) {
		this.positions = positions;
		this.cells = cells;
		this.width = width;
		this.height = height;
		
		turn = 0;
	}
	
	public function setInputs( requiredActionsCount:Int, myCells:Map<Int, Cell>, oppCells:Array<Cell>, a:Int, b:Int, c:Int, d:Int ) {
		this.requiredActionsCount = requiredActionsCount;
		this.myCells = myCells;
		this.oppCells = oppCells;
		
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		turn++;
		
		if( turn == 1 ) {
			// for( cell in cells ) printErr( 'pos: ${cell.pos}, type: ${output( cell.type )}, neighbors: ${cell.neighborsToString()}' );
			myProteinCell = getMyProteinCell();
			final sporerY = myProteinCell.pos.y;
			
			return 'GROW 1 1 $sporerY SPORER E';
		}

		if( turn == 2 ) {
			final sporers = [for( cell in myCells ) if( cell.type == TCell.Sporer ) cell];
			if( sporers.length == 0 ) throw 'Error: no sporers';
			final sporer = sporers[0];
			final secondRootX = myProteinCell.pos.x - 2;
			return 'SPORE ${sporer.organId} $secondRootX ${sporer.pos.y}';
		}

		if( turn == 3 ) {
			for( cell in myCells ) if( cell.type == TCell.Root ) myRoots.push( cell );
			final secondRoot = myRoots[1];
			return 'WAIT\nGROW ${secondRoot.organId} ${secondRoot.pos.x + 1} ${secondRoot.pos.y} HARVESTER E';
		}

		final outputs = [];
		for( i in 0...requiredActionsCount ) {
			final emptyCell = getEmptyCellNearRoot( myRoots[i] );
			if( emptyCell == Cell.NO_CELL ) {
				outputs.push( 'WAIT' );
			} else {
				outputs.push( 'GROW ${myRoots[i].organId} ${emptyCell.pos.x} ${emptyCell.pos.y} BASIC X' );
			}
		}

		return outputs.join( "\n" );
		
	}

	function getMyProteinCell() {
		final proteinCells = [];
		for( cell in cells ) {
			if( cell.type == TCell.A ) {
				proteinCells.push( cell );
			}
		}
		if( proteinCells.length == 0 ) return Cell.NO_CELL;

		var myRootCell = Cell.NO_CELL;
		for( cell in myCells ) {
			if( cell.type == TCell.Root ) {
				myRootCell = cell;
				break;
			}
		}

		proteinCells.sort(( a, b ) -> a.pos.manhattanDistance( myRootCell.pos) - b.pos.manhattanDistance( myRootCell.pos ) );

		return proteinCells[0];
	}

	function getEmptyCellNearRoot( root:Cell ) {
		for( cell in myCells ) {
			if( cell.organRootId == root.organId ) {
				final neighbors = cell.neighbors;
				for( neighbor in neighbors ) {
					if( neighbor.type == TCell.Empty ) return neighbor;
				}
			}
		}

		return Cell.NO_CELL;
	}
}