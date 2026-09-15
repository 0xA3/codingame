package ai.algorithm;

import ai.data.Cell;

typedef Edge = {
	final to:PathNode;
	final cost:Int;
}

class PathNode {
	
	public static final NO_PATH_NODE = new PathNode( Cell.NO_CELL, 999, [] );

	public final cell:Cell;
	public final distanceToGoal:Int;
	public final neighbors:Array<Edge> = [];
	public var costFromStart = Math.POSITIVE_INFINITY;
	public var priority = Math.POSITIVE_INFINITY;
	public var previous = NO_PATH_NODE;
	public var visited = false;

	public function new( cell:Cell, distanceToGoal:Int, neighbors:Array<Edge> ) {
		this.cell = cell;
		this.distanceToGoal = distanceToGoal;
		this.neighbors = neighbors;
	}

	public function toString() return '{ ${ previous != NO_PATH_NODE ? Std.string( previous ) + "-" : ""}$cell prio: $priority}';

	public static function compareCostFromStart( a:PathNode, b:PathNode ) {
		if( a.costFromStart > b.costFromStart ) return true;
		return false;
	}

	public static function compareDistanceToGoal( a:PathNode, b:PathNode ) {
		if( a.distanceToGoal > b.distanceToGoal ) return true;
		return false;
	}

	public static function comparePriority( a:PathNode, b:PathNode ) {
		if( a.priority > b.priority ) return true;
		return false;
	}

	public static function comparePriorityAndInstability( a:PathNode, b:PathNode ) {
		if( a.priority > b.priority ) return true;
		if( a.priority < b.priority ) return false;
		if( a.cell.instability > b.cell.instability ) return true;
		return false;
	}
}