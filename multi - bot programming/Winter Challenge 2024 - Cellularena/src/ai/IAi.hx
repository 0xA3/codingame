package ai;

import ai.data.Entity;
import ai.data.Pos;

interface IAi {
	function setGlobalInputs( grid:Array<Array<Int>>, width:Int, height:Int, positions:Array<Array<Pos>> ):Void;
	function setInputs(	requiredActionsCount:Int, entities:Array<Entity>, myEntities:Map<Int, Entity>, oppEntities:Array<Entity>, a:Int, b:Int, c:Int, d:Int ):Void;
	function process():String;
}