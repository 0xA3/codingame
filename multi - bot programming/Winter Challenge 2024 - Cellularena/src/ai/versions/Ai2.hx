package ai.versions;

import CodinGame.printErr;
import ai.contexts.OutputTCell.output;
import ai.data.Cell;
import ai.data.Pos;

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
	var myEntities:Map<Int, Cell>;
	var oppEntities:Array<Cell>;
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
	
	public function setInputs( requiredActionsCount:Int, myEntities:Map<Int, Cell>, oppEntities:Array<Cell>, a:Int, b:Int, c:Int, d:Int ) {
		this.requiredActionsCount = requiredActionsCount;
		this.myEntities = myEntities;
		this.oppEntities = oppEntities;
		
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		turn++;

		if( turn == 1 ) {
			for( cell in cells ) printErr( 'pos: ${cell.pos}, type: ${output( cell.type )}, neighbors: ${cell.neighborsToString()}' );
		}

		return "WAIT";
	}
}