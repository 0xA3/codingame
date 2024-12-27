package ai.versions;

import CodinGame.printErr;
import ai.contexts.OutputTCell.output;
import ai.data.Cell;
import ai.data.Node;
import ai.data.TCell;
import haxe.ds.GenericStack;
import xa3.math.Pos;

using xa3.MathUtils;

class Ai3 {
	
	public var aiId = "Random growth";

	var playerIdx = 1;

	var positions:Array<Array<Pos>>;
	var cells:Map<Pos, Cell>;
	var width:Int;
	var height:Int;
	final harvestedProteins:Map<Pos, Bool> = [];

	var requiredActionsCount:Int;
	var entities:Array<Cell>;
	var myCells:Map<Int, Cell>;
	var myRoots:Array<Cell>;
	var oppCells:Array<Cell>;
	var a:Int;
	var b:Int;
	var c:Int;
	var d:Int;

	var turn:Int;

	public function new() {	}

	public function setGlobalInputs( positions:Array<Array<Pos>>, cells:Map<Pos, Cell>, width:Int, height:Int ) {
		this.positions = positions;
		this.cells = cells;
		this.width = width;
		this.height = height;
		
		turn = 0;
	}
	
	public function setInputs( requiredActionsCount:Int, myRoots:Array<Cell>, myCells:Map<Int, Cell>, oppCells:Array<Cell>, a:Int, b:Int, c:Int, d:Int ) {
		this.requiredActionsCount = requiredActionsCount;
		this.myRoots = myRoots;
		this.myCells = myCells;
		this.oppCells = oppCells;
		
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		turn++;
		
		final outputs = [];
		for( i in 0...requiredActionsCount ) {
			final node = getEmptyNeighborNode( myRoots[i] );
			if( node != Node.NO_NODE && a > 0 ) {
				outputs.push( 'GROW ${node.startCellId} ${node.pos.x} ${node.pos.y} BASIC' );
			} else {
				outputs.push( 'WAIT' );
			}
		}

		return outputs.join( "\n" );
		
	}

	function getEmptyNeighborNode( root:Cell ) {
		for( cell in myCells ) {
			if( cell.organRootId == root.organId ) {
				final neighbors = cell.neighbors;
				for( neighbor in neighbors ) {
					if( neighbor.type == TCell.Empty ) return new Node( cell.organId, neighbor.pos );
				}
			}
		}

		return Node.NO_NODE;
	}
}