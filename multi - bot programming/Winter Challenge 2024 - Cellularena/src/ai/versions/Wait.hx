package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.Entity;

using Lambda;

class Wait implements IAi {
	
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
	
	public function setGlobalInputs( width:Int, height:Int ) {
		this.width = width;
		this.height = height;
	}
	
	public function setInputs( requiredActionsCount:Int, entities:Array<Entity>, a:Int, b:Int, c:Int, d:Int  ) {
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
