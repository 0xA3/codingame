package ai.data;

import CodinGame.printErr;

class TownPath {
	
	public final start:Int;
	public final end:Int;
	public final cells:Array<Cell>;
	public final noTrackCells:Array<Cell> = [];
	public var length:Int;

	public function new( start:Int, end:Int, cells:Array<Cell>, length:Int ) {
		this.start = start;
		this.end = end;
		this.cells = cells;
		this.length = length;

		for( cell in cells ) noTrackCells.push( cell );
	}

	public function removeCell( cell:Cell ) {
		noTrackCells.remove( cell );
		// printErr( noTrackCells.map( cell -> cell.pos ).join(","));
	}

	public function recalculateLength() {
		var length = 0;
		for( cell in noTrackCells ) length += cell.type + 1;

		this.length = length;
	}

	public static function sortByLength( a:TownPath, b:TownPath ) return a.length - b.length;
}