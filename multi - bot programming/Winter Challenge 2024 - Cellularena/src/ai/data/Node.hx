package ai.data;

import CodinGame.printErr;

class Node {
	
	public static final NO_NODE = new Node();

	public var rootId = -1;
	public var startCellId = -1; // TODO remove
	public var cell = Cell.NO_CELL;
	public var tCell:TCell;
	public var direction:TDir;
	public var a = 0;
	public var b = 0;
	public var c = 0;
	public var d = 0;
	public var distance = 0;
	public var parent:Node;

	public function new() { }

	public function init(
		rootId:Int,
		startCellId:Int,
		cell:Cell,
		tCell:TCell,
		direction:TDir,
		a:Int,
		b:Int,
		c:Int,
		d:Int,
		distance = 0,
		?parent:Node
	) {
		this.rootId = rootId;
		this.startCellId = startCellId;
		this.cell = cell;
		this.tCell = tCell;
		this.direction = direction;
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
		this.distance = distance;
		this.parent = parent;
	}

	public static function sortByDistance( a:Node, b:Node ) return a.distance - b.distance;

	public static function compare( a:Node, b:Node ) return a.distance > b.distance ? true : false;

	public function toString() {
		return 'startCellId: $startCellId, pos: ${cell.pos}, distance: $distance' +
		( parent == null ? '' : ', parent: ${parent.cell.pos}' );
	}
}