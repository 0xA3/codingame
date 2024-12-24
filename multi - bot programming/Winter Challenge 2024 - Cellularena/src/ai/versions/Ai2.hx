package ai.versions;

import ai.data.Entity;
import ai.data.Pos;

class Ai2 {
	
	public var aiId = "Ai1";

	var playerIdx = 1;

	var grid:Array<Array<Int>>;
	var width:Int;
	var height:Int;
	var positions:Array<Array<Pos>>;
	var visited:Array<Array<Bool>>;
	final harvestedProteins:Map<Pos, Bool> = [];

	var requiredActionsCount:Int;
	var entities:Array<Entity>;
	var myEntities:Map<Int, Entity>;
	var oppEntities:Array<Entity>;
	var a:Int;
	var b:Int;
	var c:Int;
	var d:Int;

	var turn:Int;

	public function new() {	}

	public function setGlobalInputs( grid:Array<Array<Int>>, width:Int, height:Int, positions:Array<Array<Pos>> ) {
		this.grid = grid;
		this.width = width;
		this.height = height;
		this.positions = positions;
		visited = [for( _ in 0...height ) [for( _ in 0...width ) false]];
		
		turn = 0;
	}
	
	public function setInputs( requiredActionsCount:Int, entities:Array<Entity>, myEntities:Map<Int, Entity>, oppEntities:Array<Entity>, a:Int, b:Int, c:Int, d:Int ) {
		this.requiredActionsCount = requiredActionsCount;
		this.entities = entities;
		this.myEntities = myEntities;
		this.oppEntities = oppEntities;
		
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		
	}
}