package ai.data;

import CodinGame.printErr;

class TownPath {
	
	public final start:Int;
	public final end:Int;
	public final cells:Array<Cell>;
	public final noTrackCells:Array<Cell> = [];
	public var length:Int;

	public function new( start:Int, end:Int, cells:Array<Cell> ) {
		this.start = start;
		this.end = end;
		this.cells = cells;

		for( cell in cells ) noTrackCells.push( cell );
		recalculateLength();
	}

	public function removeCell( cell:Cell ) {
		noTrackCells.remove( cell );
	}

	public function resetPath( cells:Array<Cell> ) {
		this.cells.resize( 0 );
		this.noTrackCells.resize( 0 );
		for( cell in cells ) {
			this.cells.push( cell );
			if( cell.tracksOwnerId == -1 ) noTrackCells.push( cell );
			recalculateLength();
		}
	}

	public function recalculateLength() {
		var length = 0;
		for( cell in noTrackCells ) length += cell.type + 1;

		this.length = length;
	}

	public static function sortByLength( a:TownPath, b:TownPath ) return a.length - b.length;
}