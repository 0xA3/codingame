package search;

import data.TCell;

class PathNode {
	
	public final id:Int;
	public final cell:TCell;
	public final neighbors:Array<Int> = [];
	public var previous = -1;
	public var visited = false;

	public function new( id:Int, cell:TCell, neighbors:Array<Int> ) {
		this.id = id;
		this.cell = cell;
		this.neighbors = neighbors;
	}

	public function addNeighbor( id:Int ) {
		if( !neighbors.contains( id )) neighbors.push( id );
	}

	public function toString() return '{ ${ previous != -1 ? Std.string( previous ) + "-" : ""}$id }';

}