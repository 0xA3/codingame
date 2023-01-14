package search;

import data.TCell;

class PathNode {
	
	public static inline var MAX_INTEGER = 2147483647;
	
	public static var noPathNode = new PathNode( 0, Unknown, [], MAX_INTEGER );

	public final id:Int;
	public final distanceToGoal:Int;
	public final cell:TCell;
	public final neighbors:Array<Int> = [];
	public var costFromStart = MAX_INTEGER;
	public var priority = MAX_INTEGER;
	public var previous = -1;
	public var visited = false;

	public function new( id:Int, cell:TCell, neighbors:Array<Int>, distanceToGoal:Int ) {
		this.id = id;
		this.cell = cell;
		this.neighbors = neighbors;
		this.distanceToGoal = distanceToGoal;
	}

	public function addNeighbor( id:Int ) {
		if( !neighbors.contains( id )) neighbors.push( id );
	}

	public function toString() return '{ ${ previous != -1 ? Std.string( previous ) + "-" : ""}$id }';

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

	public static function comparePriorityAndId( a:PathNode, b:PathNode ) {
		if( a.priority > b.priority ) return true;
		if( a.priority < b.priority ) return false;
		if( a.id > b.id ) return true;
		return false;
	}
}