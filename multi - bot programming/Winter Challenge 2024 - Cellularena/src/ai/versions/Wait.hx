package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.Entity;
import ai.data.Pos;

using Lambda;

class Wait {
	
	public var aiId = "Wait";
	
	var width:Int;
	var height:Int;

	var requiredActionsCount:Int;
	var entities:Array<Entity>;
	var a:Int;
	var b:Int;
	var c:Int;
	var d:Int;

	public function new() { }
	
	public function setGlobalInputs( grid:Array<Array<Int>>, width:Int, height:Int, positions:Array<Array<Pos>> ) {
		this.width = width;
		this.height = height;
	}
	
	public function setInputs( requiredActionsCount:Int, entities:Array<Entity>, myEntities:Map<Int, Entity>, oppEntities:Array<Entity>, a:Int, b:Int, c:Int, d:Int  ) {
		this.requiredActionsCount = requiredActionsCount;
		this.entities = entities;
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		return [for( _ in 0...requiredActionsCount ) "WAIT"].join( "\n" );
	}
}
