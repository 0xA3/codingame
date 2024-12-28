package ai.data;

import xa3.math.Pos;

class Node {
	
	public static final NO_NODE = new Node( 0, Cell.NO_CELL, 0 );

	public var startCellId:Int;
	public var cell:Cell;
	public var distance:Int;
	public var parent:Node;

	public function new( startCellId:Int, cell:Cell, distance = 1, ?parent:Node ) {
		this.startCellId = startCellId;
		this.cell = cell;
		this.distance = distance;
		this.parent = parent == null ? Node.NO_NODE : parent;
	}

	public function init( startCellId:Int, cell:Cell, distance = 1, ?parent:Node ) {
		this.startCellId = startCellId;
		this.cell = cell;
		this.distance = distance;
		this.parent = parent == null ? Node.NO_NODE : parent;
	}

	public static function sortByDistance( a:Node, b:Node ) return a.distance - b.distance;

	public function toString() return 'startCellId: $startCellId, pos: ${cell.pos}, distance: $distance, parent: ${parent.cell.pos}';
}