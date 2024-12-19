package ai;

import ai.data.Entity;

interface IAi {
	function setGlobalInputs( width:Int, height:Int ):Void;
	function setInputs(	requiredActionsCount:Int, entities:Array<Entity>, a:Int, b:Int, c:Int, d:Int ):Void;
	function process():String;
}